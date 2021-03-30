//
//  Utilities.swift
//  RSSReader
//
//  Created by Rodion Molchanov on 29.03.2021.
//

import Foundation
import UIKit


func alerter(title: String?, message: String?) -> UIAlertController
{
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
    return alert
}

func stringRSSToDate(dateString: String?) -> Date
{
    guard var dateString = dateString
    else
    {
        return Date.distantPast
    }
    dateString = dateString.trimmingCharacters(in: .whitespacesAndNewlines)

    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEE, dd MMMM yyyy HH:mm:ss Z"
    let date1 :Date? = dateFormatter.date(from: dateString)

    return date1 ?? Date.distantPast
}


func dateToString(date: Date?) -> String
{
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd.MM.yyyy HH:mm:ss"
    
    if let date = date
    {
        return dateFormatter.string(from: date)
    }
    return dateFormatter.string(from: Date.distantPast)
}

func sortByData(operation: Character, arrayToSort: [Dictionary<String, String>]) -> [Dictionary<String, String>] {
    
    var tempArray = arrayToSort
    for _ in 0..<tempArray.count
    {
        var flagNoChanges = true
        for index in 0..<(tempArray.count - 1)
        {
            let date1 = stringRSSToDate(dateString: tempArray[index]["pubDate"])
            let date2 = stringRSSToDate(dateString: tempArray[index + 1]["pubDate"])
            
            var boolSignature = true
            if operation == ">"
            {
                boolSignature = date1 > date2
            }
            else if operation == "<"
            {
                boolSignature = date1 < date2
            }
            
            if boolSignature
            {
                let tempPost = tempArray[index]["pubDate"]
                tempArray[index]["pubDate"] = tempArray[index + 1]["pubDate"]
                tempArray[index + 1]["pubDate"] = tempPost
                flagNoChanges = false
            }
        }
        if flagNoChanges
        {
            break
        }
    }
return tempArray
}

func saveArrayToUserDefaults(array: [Any], key: String)
{
    if !array.isEmpty
    {
        UserDefaults.standard.set(array, forKey: key)
        UserDefaults.standard.synchronize()
    }
}

func loadArrayAtUserDefaults(key: String) -> [Any]?
{
    if let array = UserDefaults.standard.array(forKey: key)
    {
        return array
    }
    return nil
}
