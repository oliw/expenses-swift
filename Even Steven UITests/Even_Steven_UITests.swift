//
//  Even_Steven_UITests.swift
//  Even Steven UITests
//
//  Created by Oliver Wilkie on 10/7/16.
//  Copyright © 2016 Oliver Wilkie. All rights reserved.
//

import XCTest

class Even_Steven_UITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCreateANewEvent() {
        let app = XCUIApplication()
        
        // Events Screen
        app.navigationBars["Events"].buttons["Add"].tap()
        
        // New Event Screen
        let eventNameField = app.tables.children(matching: .cell).element(boundBy: 0).children(matching: .textField).element
        eventNameField.typeText("Boston")
        app.otherElements["“Boston”"].tap()
        
        let addPeopleButton = app.tables.cells.staticTexts["People"]
        addPeopleButton.tap()
        
        // New People Screen
        let tablesQuery = app.tables
        let addPersonStaticText = tablesQuery.staticTexts["Add Person"]
        addPersonStaticText.tap()
        
        // New Person Screen
        let cellsQuery = tablesQuery.cells
        let textField = cellsQuery.children(matching: .textField).element
        textField.typeText("Oliver")
        let doneButton = app.navigationBars["Add Person"].buttons["Done"]
        doneButton.tap()
        
        // New People Screen
        addPersonStaticText.tap()
        
        // New Person Screen
        textField.typeText("Douglas")
        doneButton.tap()
        
        // New People Screen
        addPersonStaticText.tap()
        cellsQuery.children(matching: .button).element.tap()
        
        // Choose From Contacts Screen
        tablesQuery.staticTexts["John Appleseed"].tap()
        
        // New People Screen
        tablesQuery.staticTexts["John Appleseed"].swipeLeft()
        tablesQuery.buttons["Delete"].tap()
        
        addPersonStaticText.tap()
        
        // New Person Screen
        textField.typeText("Angus")
        doneButton.tap()
        
        // New Event Screen
        app.navigationBars["People"].buttons["Event Details"].tap()
        app.navigationBars["Event Details"].buttons["Save"].tap()
        
        // Events Screen
    }
    
}
