//
//  HabitTrackerLearningUITests.swift
//  HabitTrackerLearningUITests
//
//  Created by ken on 2026/1/3.
//

import XCTest

final class HabitTrackerLearningUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor
    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        XCTAssertTrue(app.navigationBars["My habits"].exists)
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    @MainActor
    func testAddHabitButtonShowsSheet() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.navigationBars["My habits"].buttons["Add Habits"].tap()
        
        XCTAssertTrue(app.navigationBars["New Habits"].waitForExistence(timeout: 2))
    }
    
    
    @MainActor
    func testLaunchPerformance() throws {
        // This measures how long it takes to launch your application.
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
}
