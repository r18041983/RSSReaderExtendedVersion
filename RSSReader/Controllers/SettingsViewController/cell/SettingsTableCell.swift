//
//  SettingsTableCell.swift
//  RSSReader
//
//  Created by Rodion Molchanov on 30.03.2021.
//

import UIKit

class SettingsTableCell: UITableViewCell {

    @IBOutlet var itemText: UILabel!
    
    var delegate: SettingsTableCellProtocol?
    var savedIndexPath: IndexPath?
    
    
    private func cleanAllCellValues()
    {
        self.delegate = nil
        self.savedIndexPath = nil
        self.itemText.text = nil
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
    
    func setValue(text: String, indexPath: IndexPath)
    {
        self.itemText.text = text
        self.savedIndexPath = indexPath
    }

    @IBAction func pressDisableItemButton(button: UIButton)
    {
        guard let indexPath = self.savedIndexPath
        else
        {
            return
        }
        delegate?.disableItem(indexPath: indexPath)
    }
    
}
