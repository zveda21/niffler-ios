import XCTest

class SpendsPage: BasePage {
    func assertIsSpendsViewAppeared(
        file: StaticString = #filePath, line: UInt = #line
    ) {
        XCTContext.runActivity(named: "Жду экран с тратами") { _ in
            waitSpendsScreen(file: file, line: line)
            XCTAssertGreaterThanOrEqual(
                app.scrollViews.switches.count, 1,
                "Не нашел трат в списке",
                file: file, line: line)
        }
    }

    @discardableResult
    func waitSpendsScreen(file: StaticString = #filePath, line: UInt = #line)
        -> Self
    {
        let isFound = app.firstMatch
            .scrollViews.firstMatch
            .switches.firstMatch
            .waitForExistence(timeout: 10)

        XCTAssertTrue(
            isFound,
            "Не дождались экрана со списком трат",
            file: file, line: line)

        return self
    }

    func addSpent() {
        app.buttons["addSpendButton"].tap()
    }

    func assertNewSpendIsShown(
        title: String, file: StaticString = #filePath, line: UInt = #line
    ) {
        let isFound = app.firstMatch
            .scrollViews.firstMatch
            .staticTexts[title].firstMatch
            .waitForExistence(timeout: 1)

        XCTAssertTrue(isFound, file: file, line: line)
    }

    func checkAddSpendButtonIsExist() {
        let addSpendButton = app.buttons["addSpendButton"]
        XCTAssertTrue(addSpendButton.waitForExistence(timeout: 5))
    }

    func checkStatisticsLabelIsExist() {
        let statisticsLabel = app.staticTexts["Statistics"]
        XCTAssertTrue(statisticsLabel.waitForExistence(timeout: 3))
    }

    func checkNewSpendIsShown(
        title: String, file: StaticString = #filePath, line: UInt = #line
    ) {
        XCTContext.runActivity(
            named: "Check New Spend Is Shown with \(title) name "
        ) { _ in
            let spendTitle = app.firstMatch
                .scrollViews.firstMatch
                .staticTexts[title].firstMatch
                .waitForExistence(timeout: 1)

            XCTAssertTrue(spendTitle, file: file, line: line)
        }
    }

    func checkSpendsListIsNotVisible() {
        // this method will work when we dont have an identifier
        let spendsList = app.staticTexts["spendsList"]
        XCTAssertFalse(
            spendsList.exists,
            "The spendsList element should not exist in the hierarchy.")
    }

    // MARK: - Method to verify spends list value using identifier
    func verifySpendsListValue(expectedValue: String) {
        let spendsList = app.staticTexts["spendsList"]
        let exists = spendsList.waitForExistence(timeout: 5)
        XCTAssertTrue(
            exists,
            "The spends list element with identifier \("spendsList") does not exist."
        )
        let actualValue = spendsList.label
        XCTAssertEqual(
            actualValue, expectedValue,
            "The value of spends list should be \(expectedValue), but it is \(actualValue)."
        )
    }

    func clickOnAddNewSpendButton() {
        XCTContext.runActivity(named: "Click on Add Spend Button") { _ in
            let addSpendButton = app.buttons["addSpendButton"]
            XCTAssertTrue(addSpendButton.waitForExistence(timeout: 5))
            addSpendButton.tap()
        }
    }

    func clickOnMenuButton() {
        XCTContext.runActivity(named: "Click on Add Spend Button") { _ in
            let menuIcon = app.images["ic_menu"]
            XCTAssertTrue(menuIcon.waitForExistence(timeout: 5))
            menuIcon.tap()
        }
    }
    
    func clickOnProfileButton(){
        XCTContext.runActivity(named: "Click on Add Spend Button") { _ in
            let profileIcon = app.buttons["Profile"]
            XCTAssertTrue(profileIcon.waitForExistence(timeout: 5))
            profileIcon.tap()
        }
    }
}
