//
//  NewsTableCell.swift
//  RSSReader
//
//  Created by Rodion Molchanov on 29.03.2021.
//

import UIKit

class NewsTableCell: UITableViewCell
{

    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textPostLabel: UILabel!
    @IBOutlet weak var istochnikLabel: UILabel!
    
    var savedLink: String?
    var savedData: String?
    var savedTitle: String?
    var savedText: String?
    
 
    func cleanAllCellValues()
    {
        self.dataLabel.text = ""
        self.titleLabel.text = ""
        self.textPostLabel.text = ""
        self.istochnikLabel.text = ""
        self.savedLink = nil
        self.savedData = nil
        self.savedTitle = nil
        self.savedText = nil
    }
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        cleanAllCellValues()
    }
    
    
    override func prepareForReuse()
    {
        cleanAllCellValues()
    }
    
    
    func setNewsCellParameters(data: String?, title: String?, text: String?, link: String?, istochnik: String?)
    {
        if let data = data
        {
            self.dataLabel.text = dateToString(date: stringRSSToDate(dateString: data.trimmingCharacters(in: .whitespacesAndNewlines)))
            self.savedData = data
        }
        if let title = title
        {
            self.titleLabel.text = title.trimmingCharacters(in: .whitespacesAndNewlines)
            self.savedTitle = title
        }
        if let text = text
        {
            self.textPostLabel.text = text.trimmingCharacters(in: .whitespacesAndNewlines)
            self.savedText = text
        }
        if let istochnik = istochnik
        {
            self.istochnikLabel.text = istochnik.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        if let link = link
        {
            self.savedLink = link
        }
    }
    
}
