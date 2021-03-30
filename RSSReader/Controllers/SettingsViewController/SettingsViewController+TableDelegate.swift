//
//  SettingsViewController+TableDelegate.swift
//  RSSReader
//
//  Created by Rodion Molchanov on 30.03.2021.
//

import Foundation
import UIKit

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.stationLinkArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: self.reuseTableCellIdentifier, for: indexPath) as? SettingsTableCell
        else
        {
            return UITableViewCell()
        }
        
        cell.setValue(text: self.stationLinkArray[indexPath.row], indexPath: indexPath)
        cell.delegate = self
        
        return cell
    }
    
}
