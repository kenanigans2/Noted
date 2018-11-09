//
//  NoteManager.swift
//  Noted
//
//  Created by kend on 11/9/18.
//  Copyright © 2018 kenanigans.com. All rights reserved.
//

import Foundation

class NoteManager
{
    var noteArray: [Note] = []
    var noteCount: Int { return noteArray.count }
    
    func addNote(_ note: Note)
    { noteArray.insert(note, at: 0) }
    
    func readNoteDataAt(index: Int) -> (String?, String)
    {
        guard self.noteArray.indices.contains(index) else { fatalError() }
        return noteArray[index].readNote()
    }
    
    func readNoteMetadataAt(index: Int, metadataType: DateMetadataType) -> Date
    {
        guard self.noteArray.indices.contains(index) else { fatalError() }
        
        switch metadataType
        {
        case .Created: return noteArray[index].getDateMetadata(.Created)
        case .LastAccessed: return noteArray[index].getDateMetadata(.LastAccessed)
        case .LastModified: return noteArray[index].getDateMetadata(.LastModified)
        }
    }
    
    func updateNoteAt(index: Int, contentData: (String?, String)) -> Bool
    {
        guard noteArray.indices.contains(index) else { fatalError() }
        let (title, content) = contentData
        noteArray[index].title = title
        noteArray[index].content = content
        if noteArray[index].title == contentData.0, noteArray[index].content == contentData.1
        { return true }
        else
        { return false }
    }
    
    func deleteNoteAt(index: Int) -> Note
    {
        guard noteArray.indices.contains(index) else { fatalError() }
        return noteArray.remove(at: index)
    }
    
    func deleteAllNotes()
    { noteArray.removeAll() }
    
}
