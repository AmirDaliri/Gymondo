//
//  GymandoMainListUITests.swift
//  GymandoMainListUITests
//
//  Created by Amir Daliri on 9.01.2024.
//

import XCTest

final class GymandoMainListUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    func testExerciseTableViewScrolling() {

        // 1. Get the table view
        let tableView = app.tables["ExerciseTableView"]

        // 2. Assert the table view exists
        XCTAssertTrue(tableView.exists, "The exercise table view exists")

        // 3. Swipe up to scroll
        tableView.swipeUp()
                
        // 4. Swipe down to scroll
        tableView.swipeDown()
    }
}
