//
//  ProfilePage.swift
//  Niffler
//
//  Created by Mac Zi_Yan on 16.12.24.
//
import XCTest

class ProfilePage: BasePage {

    func checkIfcategoryExist(
        categoryName: String, file: StaticString = #file, line: UInt = #line
    ) {
        XCTContext.runActivity(named: "Check category name ") { _ in
            let categoryLabel = app.staticTexts[categoryName]
            let IsExists = categoryLabel.waitForExistence(timeout: 5)
            XCTAssertTrue(
                IsExists,
                "'\(categoryName)' category should be present in the categories list.",
                file: file, line: line
            )
        }
    }

    func deleteExistingCategory(categoryName: String) {
        XCTContext.runActivity(named: "Check category name ") { _ in
            let categoryCell = app.cells.staticTexts[categoryName].firstMatch
            categoryCell.waitForExistence(timeout: 5)
            XCTContext.runActivity(named: "Swipe to left ") { _ in
                categoryCell.swipeLeft()
            }
            let deleteButton = app.buttons["Delete"]
            let deleteButtonExists = deleteButton.waitForExistence(timeout: 3)
            XCTAssertTrue(
                deleteButtonExists,
                "'Delete' button should appear after swiping left.")

            XCTContext.runActivity(named: "Delete selected category") { _ in
                deleteButton.tap()
            }
        }
    }

    func clickOnCloseButton() {
        XCTContext.runActivity(named: "Close Profile Page") { _ in
            let closeButton = app.buttons["Close"]
            closeButton.waitForExistence(timeout: 5)
            closeButton.tap()
        }
    }
}
