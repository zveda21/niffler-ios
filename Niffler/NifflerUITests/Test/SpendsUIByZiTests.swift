//
//  SpendsUITestsByZi.swift
//  Niffler
//
//  Created by Mac Zi_Yan on 10.12.24.
//
final class SpendsUIBYZiTests : XCTestCase{
    
    var app :XCUIApplication!
    
    override func setUp() {
        super.setUp()
        launchAppWithoutLogin()
    }
    
    private func generateRandomString(length: Int = 6) -> String {
        let characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map { _ in characters.randomElement()! })
    }
    
    // MARK: -Domain Specific Language
    private func launchAppWithoutLogin(){
        XCTContext.runActivity(named: "Run Application without Login"){ _ in
            app = XCUIApplication()
            app.launchArguments=["RemoveAuthOnStart"]
            app.launch()
        }
    }
}
