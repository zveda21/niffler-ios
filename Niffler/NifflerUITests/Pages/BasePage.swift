import XCTest

class BasePage {
    init(app: XCUIApplication) {
        self.app = app
    }

    let app: XCUIApplication

    // MARK: -Domain Specific Language
    func launchAppWithoutLogin() {
        XCTContext.runActivity(named: "Run Application without Login") { _ in
            app.launchArguments = ["RemoveAuthOnStart"]
            app.launch()
        }
    }

    func checkTextIsAppear(_ text: String, _ message: String) {
        let text = app.staticTexts[text]
        XCTAssertTrue(text.waitForExistence(timeout: 5), message)
    }
}
