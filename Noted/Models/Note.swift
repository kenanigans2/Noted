//
//  Note.swift
//  Noted
//
//  Created by kend on 11/9/18.
//  Copyright © 2018 kenanigans.com. All rights reserved.
//

import Foundation

enum DateMetadataType: Int
{ case Created, LastModified, LastAccessed }

struct Note {
    
    // MARK:- PRIVATE PROPERTIES
    
    private var contentData: (title: String?, content: String)
    {
        didSet
        {
            let timestamp = Date()
            dateMetadata.lastModified = timestamp
        }
    }
    
    private var dateMetadata: (created: Date, lastModified: Date, lastAccessed: Date)
    
    // MARK:- INIT
    
    init(title: String?, content: String)
    {
        self.contentData = (title: title, content: content)
        let timestamp = Date()
        dateMetadata.created = timestamp
        dateMetadata.lastModified = timestamp
        dateMetadata.lastAccessed = timestamp
    }
    
    // MARK:- PUBLIC METHODS
    
    func getDateMetadata(_ type: DateMetadataType) -> Date
    {
        switch type
        {
        case .Created: return self.dateMetadata.created
        case .LastModified: return self.dateMetadata.lastModified
        case .LastAccessed: return self.dateMetadata.lastAccessed
        }
    }
    
    mutating func readNote() -> (String?, String)
    {
        dateMetadata.lastAccessed = Date()
        return (contentData.title, contentData.content)
    }
    
}

extension Note
{
    // MARK:- PUBLIC COMPUTED PROPERTIES
    
    var title: String?
    {
        mutating get { dateMetadata.lastAccessed = Date(); return contentData.title }
        set { contentData.title = newValue }
    }
    
    var content: String
    {
        mutating get { dateMetadata.lastAccessed = Date(); return contentData.content }
        set { contentData.content = newValue }
    }
}
