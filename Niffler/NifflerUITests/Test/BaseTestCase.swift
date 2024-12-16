import XCTest

class TestCase: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        
        app = XCUIApplication()
    }
    
    override func tearDown() {
        app = nil
        
        loginPage = nil
        spendsPage = nil
        newSpendPage = nil
        registerPage = nil
        profilePage = nil
        
        super.tearDown()
    }
    
    // MARK: -Domain Specific Language
    func launchAppWithoutLogin() {
        XCTContext.runActivity(named: "Run Application without Login") { _ in
            app.launchArguments = ["RemoveAuthOnStart"]
            app.launch()
        }
    }
    
    lazy var loginPage: LoginPage! = LoginPage(app: app)
    lazy var spendsPage: SpendsPage! = SpendsPage(app: app)
    lazy var newSpendPage: NewSpendPage! = NewSpendPage(app: app)
    lazy var registerPage: RegisterPage! = RegisterPage(app: app)
    lazy var profilePage: ProfilePage! = ProfilePage(app: app)
}

