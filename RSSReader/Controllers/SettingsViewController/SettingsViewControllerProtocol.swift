//
//  SettingsViewControllerProtocol.swift
//  RSSReader
//
//  Created by Rodion Molchanov on 30.03.2021.
//

import Foundation

protocol SettingsDelegate {
    func settingsSetArray() -> [String]
    func settingsDidDisappear(settingsArray: [String])
}
