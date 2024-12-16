import XCTest

class NewSpendPage: BasePage {

    func inputSpent(title: String) {
        inputAmount()
            .selectCategory()
            .inputDescription(title)
            //        .swipeToAddSpendsButton()
            .pressAddSpend()
    }

    func inputAmount() -> Self {
        app.textFields["amountField"].typeText("14")
        return self
    }

    func selectCategory() -> Self {
        app.buttons["Select category"].tap()
        app.buttons["Рыбалка"].tap()  // TODO: Bug
        return self
    }

    func inputDescription(_ title: String) -> Self {
        app.textFields["descriptionField"].tap()
        app.textFields["descriptionField"].typeText(title)
        return self
    }

    //    func swipeToAddSpendsButton() -> Self {
    //        let screenCenter = app.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5))
    //        let screenTop = app.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.15))
    //        screenCenter.press(forDuration: 0.01, thenDragTo: screenTop)
    //        return self
    //    }

    func pressAddSpend() {
        app.buttons["Add"].tap()
    }

    func inputSpend(amount: String, description: String, title: String) {
        fillAmountField(amount)
            .fillDescriptionField(description)
            .clickOnNewCategoryButton(title)
            .clickOnAddButton()
    }
    
    func fillAmountField(_ amount: String) -> Self {
        let amountField = app.textFields["amountField"]
        if amountField.waitForExistence(timeout: 5) {
            amountField.tap()
            amountField.typeText(amount)
        }
        return self
    }

    @discardableResult
    func fillDescriptionField(_ description: String) -> Self {
        let descriptionField = app.textFields["descriptionField"]
        if descriptionField.waitForExistence(timeout: 5) {
            descriptionField.tap()
            descriptionField.typeText(description)
        }
        return self
    }

    func clickOnAddButton() {
        app.buttons["Add"].tap()
    }

    func clickOnNewCategoryButton(_ categoryName: String) -> Self {
        XCTContext.runActivity(named: "Click on new Category Button") { _ in
            let newCategoryButton = app.buttons["Select category"]
            XCTAssertTrue(newCategoryButton.waitForExistence(timeout: 5))

            if newCategoryButton.isHittable {
                newCategoryButton.tap()
                fillCategoryNameField("Test")
                clickOnAddCategoryButton()
            } else {
                newCategoryButton.tap()
                app.buttons[categoryName].tap()
            }
        }
        return self
    }
    private func fillCategoryNameField(_ name: String) -> Self {
        let categoryName = app.textFields["Name"]
        XCTAssertTrue(categoryName.waitForExistence(timeout: 5))
        categoryName.tap()
        categoryName.typeText(name)
        return self
    }

    private func clickOnAddCategoryButton() -> Self {
        XCTContext.runActivity(named: "Click on Add Category Button") { _ in
            app.alerts["Add category"].buttons["Add"].tap()
        }
        return self
    }

    @discardableResult
    func verifyIfNewCategoryButtonIsVisibleAndClickable(
        file: StaticString = #file, line: UInt = #line
    ) -> Self {
        XCTContext.runActivity(
            named: "Verify if New category button is visible and clickable "
        ) { _ in
            let addCategoryButton = app.buttons["+ New category"]
            let isExists = addCategoryButton.waitForExistence(timeout: 5)
            XCTAssertTrue(
                isExists,
                "'+ New category' button should be visible after waiting for 5 seconds.",
                file: file,
                line: line
            )
            XCTAssertTrue(
                addCategoryButton.isHittable,
                "'+ New category' button should be tappable.", file: file,
                line: line)
        }
        return self
    }
}
