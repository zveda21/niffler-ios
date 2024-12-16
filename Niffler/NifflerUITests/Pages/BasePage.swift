import XCTest

class BasePage {
    init(app: XCUIApplication) {
        self.app = app
    }

    let app: XCUIApplication

    func checkTextIsAppear(_ text: String, _ message: String) {
        let text = app.staticTexts[text]
        XCTAssertTrue(text.waitForExistence(timeout: 5), message)
    }
    
    func pressReturnKey() {
        XCTContext.runActivity(named: "Click on Return key") { _ in
            let returnKey = app.keyboards.buttons["return"]
            let exists = returnKey.waitForExistence(timeout: 5)
            XCTAssertTrue(exists, "The Return key should exist on the keyboard.")
            returnKey.tap()
        }
    }
}
