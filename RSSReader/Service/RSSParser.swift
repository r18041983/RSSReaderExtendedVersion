//
//  RSSParser.swift
//  RSSReader
//
//  Created by Rodion Molchanov on 28.03.2021.
//

import Foundation

protocol RSSParserDelegate {
    func beginParsing(parser: RSSParser)
    func newPost(parser: RSSParser, postDict: Dictionary<String, String>)
    func endParsing(parser: RSSParser)
    func parseErrorOccurred(parser: RSSParser, parseError: ParserError)
}

enum ParserError: String {
    case parseError = "parse RSS error"
    case networkError = "network error"
    case validationError = "validation news error"
    case urlValidationError = "url validation error"
}

class RSSParser: NSObject {

    var URLString = ""
    var delegate: RSSParserDelegate?
    var tempPost: Dictionary<String, String>?
    var tempElement: String?
    var parserXML: XMLParser?

    init(urlString: String) {
        super.init()
        self.URLString = urlString
    }
    
    func parseRSS()
    {
        guard let url = URL.init(string: self.URLString)
        else
        {
            self.delegate?.parseErrorOccurred(parser: self, parseError: ParserError.urlValidationError)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            if error != nil {
                self.delegate?.parseErrorOccurred(parser: self, parseError: ParserError.networkError)
            }
            guard let data = data else {return}
            
            self.parserXML = XMLParser.init(data: data)
            self.parserXML?.delegate = self
            self.parserXML?.parse()
        }
        DispatchQueue.global(qos: .userInitiated).async
        {
            task.resume()
        }
    }
    
}

// MARK :- XMLParserDelegate
extension RSSParser: XMLParserDelegate
{
    func parserDidStartDocument(_ parser: XMLParser)
    {
        delegate?.beginParsing(parser: self)
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error)
    {
        self.delegate?.parseErrorOccurred(parser: self, parseError: ParserError.parseError)
    }
    
    
    func parserDidEndDocument(_ parser: XMLParser)
    {
        self.delegate?.endParsing(parser: self)
    }

    
    func parser(_ parser: XMLParser, validationErrorOccurred validationError: Error)
    {
        self.delegate?.parseErrorOccurred(parser: self, parseError: ParserError.validationError)
    }
    
   
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:])
    {
        tempElement = elementName
        if elementName == "item"
        {
            tempPost = [String: String]()
        }
    }

    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
    {
        if elementName == "item"
        {
            if let post = tempPost
            {
                self.delegate?.newPost(parser: self, postDict: post)
            }
            tempPost = nil
        }
    }

    
    func parser(_ parser: XMLParser, foundCharacters string: String)
    {
        guard let localElement = self.tempElement, let _ = tempPost
        else
        {return}
            
        guard let stringPost = tempPost![localElement]
        else
        {
            tempPost![localElement] = string
            return
        }
        tempPost![localElement] = stringPost + string
    }
    
}
