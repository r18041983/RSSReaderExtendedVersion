//
//  SettingsViewController.swift
//  RSSReader
//
//  Created by Rodion Molchanov on 30.03.2021.
//

import UIKit

class SettingsViewController: UIViewController
{
    @IBOutlet weak var SettingsTableView: UITableView!
    @IBOutlet weak var addStationTextField: UITextField!
    
    let reuseTableCellIdentifier = "SettingsTableCell"
    var stationLinkArray = [String]()
    var delegate: SettingsDelegate?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.SettingsTableView.delegate = self
        self.SettingsTableView.dataSource = self
        self.SettingsTableView.register(UINib(nibName: "SettingsTableCell", bundle: nil), forCellReuseIdentifier: self.reuseTableCellIdentifier)
        if let _ = delegate
        {
            self.stationLinkArray = delegate!.settingsSetArray()
        }
    }

    override func viewDidDisappear(_ animated: Bool)
    {
        super.viewDidDisappear(animated)
        delegate?.settingsDidDisappear(settingsArray: self.stationLinkArray)
    }
    
    @IBAction func pressAddStationButton(_ sender: UIButton) {
        if let text = self.addStationTextField.text,
           !text.isEmpty
        {
            self.stationLinkArray.append(text)
            self.SettingsTableView.reloadData()
        }
    }

}
