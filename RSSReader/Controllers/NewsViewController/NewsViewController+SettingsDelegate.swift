//
//  NewsViewController+SettingsDelegate.swift
//  RSSReader
//
//  Created by Rodion Molchanov on 30.03.2021.
//

import Foundation

extension NewsViewController: SettingsDelegate
{
    func settingsSetArray() -> [String]
    {
        return self.URLArray
    }
    
    func settingsDidDisappear(settingsArray: [String])
    {
        self.URLArray = settingsArray
        saveArrayToUserDefaults(array: settingsArray, key: Constants.shared.keyFromSaveSettings)
    }
}
