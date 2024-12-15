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

    func fillAmountField(_ amount: String) {
        let amountField = app.textFields["amountField"]
        XCTAssertTrue(amountField.waitForExistence(timeout: 5))
        amountField.tap()
        amountField.typeText(amount)
    }

    func fillDescriptionField(_ description: String) {
        let descriptionField = app.textFields["descriptionField"]
        XCTAssertTrue(descriptionField.waitForExistence(timeout: 5))
        descriptionField.tap()
        descriptionField.typeText(description)
    }

    func clickOnAddButton() {
        app.buttons["Add"].tap()
    }

    func clickOnNewCategoryButton(_ categoryName: String) {
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
    }
    private func fillCategoryNameField(_ name: String) {
        let categoryName = app.textFields["Name"]
        XCTAssertTrue(categoryName.waitForExistence(timeout: 5))
        categoryName.tap()
        categoryName.typeText(name)
    }

    private func clickOnAddCategoryButton() {
        XCTContext.runActivity(named: "Click on Add Category Button") { _ in
            app.alerts["Add category"].buttons["Add"].tap()
        }
    }
}
