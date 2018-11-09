//
//  NoteStructTests.swift
//  NotedTests
//
//  Created by kend on 11/9/18.
//  Copyright © 2018 kenanigans.com. All rights reserved.
//

import XCTest
@testable import Noted

class NoteStructTests: XCTestCase
{

    override func setUp()
    { super.setUp() }

    override func tearDown()
    { super.tearDown() }

    // MARK:- NOTE WITH TITLE AND CONTENT
    
    func testInit_NoteWithTitleAndContent()
    {
        let testTitle = "test title"
        let testContent = "test content"
        var testNote = Note(title: testTitle, content: testContent)
        XCTAssertNotNil(testNote)
        XCTAssertEqual(testNote.title, testTitle)
        XCTAssertEqual(testNote.content, testContent)
    }
    
    func testInit_NoteTitleIsOptional()
    {
        let testTitle = "test title"
        let testContent = "test content"
        var noteWithoutTitle = Note(title: nil, content: testContent)
        var noteWithTitle = Note(title: testTitle, content: testContent)
        XCTAssertNil(noteWithoutTitle.title)
        XCTAssertNotNil(noteWithTitle.title)
        XCTAssertEqual(noteWithTitle.title, testTitle)
    }
    
    // MARK:- UPDATES TITLE AND CONTENT
    
    func testUpdate_UpdatesTitle()
    {
        let testTitle1 = "test title 1"
        let testTitle2 = "test title 2"
        var testNote = Note(title: testTitle1, content: "test")
        XCTAssertEqual(testNote.title, testTitle1)
        testNote.title = testTitle2
        XCTAssertEqual(testNote.title, testTitle2)
    }
    
    func testUpdate_UpdatesContent()
    {
        let testContent1 = "test content 1"
        let testContent2 = "test content 2"
        var testNote = Note(title: nil, content: testContent1)
        XCTAssertEqual(testNote.content, testContent1)
        
        testNote.content = testContent2
        XCTAssertEqual(testNote.content, testContent2)
    }
    
    // MARK:- DATE METADATA
    
    func testDate_NoteInitializesWithSameDates()
    {
        let testNote = Note(title: nil, content: "test")
        let dateCreatedQueried = testNote.getDateMetadata(.Created)
        XCTAssertNotNil(dateCreatedQueried)
        let dateLastModifiedQueried = testNote.getDateMetadata(.LastModified)
        XCTAssertNotNil(dateLastModifiedQueried)
        XCTAssertEqual(dateLastModifiedQueried, dateCreatedQueried)
        let dateLastAccessedQueried = testNote.getDateMetadata(.LastAccessed)
        XCTAssertNotNil(dateLastAccessedQueried)
        XCTAssertEqual(dateLastAccessedQueried, dateCreatedQueried)
    }
    
    func testDate_UpdatingNoteProperties_UpdatesDateLastModified()
    {
        let title1 = "title 1"
        let title2 = "title 2"
        var testNote = Note(title: title1, content: "test content")
        let dateCreatedQueried = testNote.getDateMetadata(.Created)
        let dateLastModifiedQueried1 = testNote.getDateMetadata(.LastModified)
        XCTAssertEqual(dateCreatedQueried, dateLastModifiedQueried1)
        testNote.title = title2
        let dateLastModifiedQueried2 = testNote.getDateMetadata(.LastModified)
        XCTAssertNotEqual(dateLastModifiedQueried2, dateLastModifiedQueried1)
        XCTAssertTrue(dateLastModifiedQueried1 < dateLastModifiedQueried2)
    }
    
    func testDate_UpdatingNoteProperties_DoesNotUpdateDateLastAccessed()
    {
        let title1 = "title 1"
        let title2 = "title 2"
        var testNote = Note(title: title1, content: "test content")
        let dateCreatedQueried = testNote.getDateMetadata(.Created)
        let dateLastAccessedQueried1 = testNote.getDateMetadata(.LastAccessed)
        XCTAssertEqual(dateCreatedQueried, dateLastAccessedQueried1)
        testNote.title = title2
        let dateLastAccessedQueried2 = testNote.getDateMetadata(.LastAccessed)
        XCTAssertEqual(dateLastAccessedQueried1, dateLastAccessedQueried2)
    }
    
    func testDate_ReadingNoteProperties_UpdatesDateLastAccessed()
    {
        var testNote = Note(title: nil, content: "test content")
        let dateLastAccessed1 = testNote.getDateMetadata(.LastAccessed)
        
        _ = testNote.readNote()
        let dateLastAccessed2 = testNote.getDateMetadata(.LastAccessed)
        
        XCTAssertNotEqual(dateLastAccessed1, dateLastAccessed2)
        XCTAssertTrue(dateLastAccessed1 < dateLastAccessed2)
    }
    
    func testDate_ReadingNoteProperties_DoesNotUpdatesDateLastModified()
    {
        var testNote = Note(title: nil, content: "test content")
        let dateLastModified1 = testNote.getDateMetadata(.LastModified)
        
        _ = testNote.readNote()
        let dateLastModified2 = testNote.getDateMetadata(.LastModified)
        XCTAssertEqual(dateLastModified1, dateLastModified2)
    }

}
