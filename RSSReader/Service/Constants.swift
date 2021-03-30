//
//  Const.swift
//  RSSReader
//
//  Created by Rodion Molchanov on 30.03.2021.
//

import Foundation

struct Constants
{
    static var shared = Constants()
    private init() {}
    
    let keyFromSaveSettings = "settingsArray"
    let keyFromSavePosts = "postsArray"
}
