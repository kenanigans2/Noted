//
//  NoteManagerTests.swift
//  NotedTests
//
//  Created by kend on 11/9/18.
//  Copyright © 2018 kenanigans.com. All rights reserved.
//

import XCTest
@testable import Noted

class NoteManagerTests: XCTestCase
{
    var sut: NoteManager!
    
    let testNote1 = Note(title: "test note 1", content: "test note 1")
    let testNote2 = Note(title: "test note 2", content: "test note 2")
    
    override func setUp()
    {
        sut = NoteManager()
    }

    override func tearDown() { super.tearDown() }

    // MARK:- INITITIALIZATION
    
    func testInit_NoteManager_Exists() { XCTAssertNotNil(sut) }
    
    func testInit_NoteManagerCountsNotes_InitializesWithCountOfZero()
    { XCTAssertEqual(sut.noteCount, 0) }
    
    // MARK:- ADD & QUERY
    
    func testAdd_AddingNote_UpdatesNoteCount()
    {
        sut.addNote(testNote1)
        XCTAssertEqual(sut.noteCount, 1)
    }
    
    func testQuery_ReadsNoteAtIndex()
    {
        sut.addNote(testNote1)
        let (titleQueried, contentQueried) = sut.readNoteDataAt(index: 0)
        XCTAssertEqual(titleQueried, testNote1.title)
        XCTAssertEqual(contentQueried, testNote1.content)
    }
    
    func testQuery_ReturnsNoteDateMetadata()
    {
        sut.addNote(testNote1)
        let dateCreated = sut.readNoteMetadataAt(index: 0, metadataType: .Created)
        let lastModified = sut.readNoteMetadataAt(index: 0, metadataType: .LastModified)
        let lastAccessed = sut.readNoteMetadataAt(index: 0, metadataType: .LastAccessed)
        XCTAssertNotNil(dateCreated)
        XCTAssertNotNil(lastModified)
        XCTAssertNotNil(lastAccessed)
        XCTAssertEqual(dateCreated, lastModified)
        XCTAssertEqual(dateCreated, lastAccessed)
    }

    func testQuery_ReadingNoteData_UpdatesDateLastAccessed()
    {
        sut.addNote(testNote1)
        let modified1 = sut.readNoteMetadataAt(index: 0, metadataType: .LastModified)
        let accessed1 = sut.readNoteMetadataAt(index: 0, metadataType: .LastAccessed)
        
        let _ = sut.readNoteDataAt(index: 0)
        let modified2 = sut.readNoteMetadataAt(index: 0, metadataType: .LastModified)
        let accessed2 = sut.readNoteMetadataAt(index: 0, metadataType: .LastAccessed)
        
        XCTAssertEqual(modified1, modified2)
        XCTAssertNotEqual(accessed1, accessed2)
        XCTAssertTrue(accessed1 < accessed2)
    }
    
    // MARK:- UPDATE & DELETE
    
    func testUpdate_UpdatesNoteAtIndex()
    {
        let title1 = "title 1"
        let title2 = "title 2"
        let content1 = "content 1"
        let content2 = "content 2"
        
        let testNote = Note(title: title1, content: content1)
        let testNoteBefore = testNote
        sut.addNote(testNote)
        _ = sut.updateNoteAt(index: 0, contentData: (title2, content2))
        XCTAssertNotEqual(sut.noteArray[0], testNoteBefore)
        let noteDataQueried = sut.readNoteDataAt(index: 0)
        XCTAssertEqual(noteDataQueried.0!, title2)
        XCTAssertEqual(noteDataQueried.1, content2)
    }
    
    func testUpdate_UpdatingNoteUpdatesDateLastModified()
    {
        let testNote = Note(title: "titleBefore", content: "contentBefore")
        sut.addNote(testNote)
        let lastModified1 = sut.readNoteMetadataAt(index: 0, metadataType: .LastModified)
        _ = sut.updateNoteAt(index: 0, contentData: (nil, "contentBefore"))
        let lastModified2 = sut.readNoteMetadataAt(index: 0, metadataType: .LastModified)
        XCTAssertNotEqual(lastModified1, lastModified2)
        XCTAssertTrue(lastModified1 < lastModified2)
    }
    
    func testDelete_DeletesNoteAtIndex()
    {
        sut.addNote(testNote1)
        XCTAssertEqual(sut.noteCount, 1)
        
        _ = sut.deleteNoteAt(index: 0)
        XCTAssertEqual(sut.noteCount, 0)
    }
    
    func testDelete_DeletingReturnsDeletedNote()
    {
        sut.addNote(testNote1)
        let deletedNote = sut.deleteNoteAt(index: 0)
        XCTAssertEqual(testNote1, deletedNote)
    }
    
    func testDelete_DeletesAllData()
    {
        sut.addNote(testNote1)
        sut.addNote(testNote2)
        XCTAssertEqual(sut.noteCount, 2)
        sut.deleteAllNotes()
        XCTAssertEqual(sut.noteCount, 0)
    }

}
