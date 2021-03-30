//
//  SettingsViewController + SettingsTableCellDelegate.swift
//  RSSReader
//
//  Created by Rodion Molchanov on 30.03.2021.
//

import Foundation

extension SettingsViewController: SettingsTableCellProtocol
{
    func disableItem(indexPath: IndexPath)
    {
        self.stationLinkArray.remove(at: indexPath.row)
        self.SettingsTableView.reloadData()
    }
    
}
