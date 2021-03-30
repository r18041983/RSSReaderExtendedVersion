//
//  ViewController.swift
//  RSSReader
//
//  Created by Rodion Molchanov on 24.03.2021.
//

import UIKit

class NewsViewController: UIViewController {


    @IBOutlet weak var parseButton: UIButton!
    @IBOutlet weak var newsTableView: UITableView!
    
    //var URLString = "https://lenta.ru/rss"
    
    var URLArray = [String]()
    var postsArray = [Dictionary<String, String>]()
    let reuseIdentifier = "NewsTableCell"
    let segueToSettingsIdentifier = "fromNewsToSettingsSegue"
    var sortOperation: Character = "<"
    let customTitleIstochnik = "istochnik"
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if let settingsArray = loadArrayAtUserDefaults(key: Constants.shared.keyFromSaveSettings) as? [String],
           !settingsArray.isEmpty
        {
            URLArray = settingsArray
        }
        else
        {
            URLArray.append("https://lenta.ru/rss")
            URLArray.append("http://rss.dw.de/xml/rss-ru-all")
        }
        
        self.newsTableView.delegate = self
        self.newsTableView.dataSource = self
        self.newsTableView.register(UINib(nibName: "NewsTableCell", bundle: nil), forCellReuseIdentifier: self.reuseIdentifier)
    }

    deinit {
        saveArrayToUserDefaults(array: self.postsArray, key: Constants.shared.keyFromSavePosts)
        
    }
    
    func openURLinBrowser(link: String)
    {
        if let url = URL(string: link)
        {
            if UIApplication.shared.canOpenURL(url)
            {
                UIApplication.shared.open(url, options: [:])
            }
            else
            {
                self.present(alerter(title: "Error", message: "cannot open browser"), animated: true)
            }
        }
        else
        {
            self.present(alerter(title: "Error", message: "cannot open this link"), animated: true)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == self.segueToSettingsIdentifier
        {
            guard let dst = segue.destination as? SettingsViewController
            else {return}
            
            dst.delegate = self
        }
    }
    
    @IBAction func pressSettingsButton(_ sender: UIBarButtonItem)
    {
        performSegue(withIdentifier: self.segueToSettingsIdentifier, sender: self)
    }
    
    
    @IBAction func pressParseButton(_ sender: UIButton)
    {
        self.postsArray.removeAll()
        
        for itemToParse in self.URLArray {
            let parserRSSLenta = RSSParser(urlString: itemToParse)
            parserRSSLenta.delegate = self
            parserRSSLenta.parseRSS()
        }
    }

    @IBAction func pressLoadButton(_ sender: UIButton)
    {
        guard let loadedArray = loadArrayAtUserDefaults(key: Constants.shared.keyFromSavePosts) as? [Dictionary<String, String>]
        else
        {
            DispatchQueue.main.async
            {
                self.present(alerter(title: "Error", message: "Error load data"), animated: true)
            }
            return
        }
        
        self.postsArray = loadedArray
        self.newsTableView.reloadData()
    }
}
