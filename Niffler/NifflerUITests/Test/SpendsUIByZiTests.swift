//
//  SpendsUITestsByZi.swift
//  Niffler
//
//  Created by Mac Zi_Yan on 10.12.24.
//
import XCTest

final class SpendsUIByZiTests:XCTestCase{
    
    var app : XCUIApplication!
    
    override func setUp() {
        super.setUp()
        launchAppWithoutLogin()
    }
    
    func test() throws{
        //Arrange
        clickOnCreateNewAccountButton()
        
        let uniqueUsername = generateRandomString()

        //Act
        doRegistration(username: uniqueUsername,password: "12345", confirmPasword: "12345")
        clickOnAlertLoginButton()
        clickOnLoginButton()
        
        //Alert
        checkStatisticsLabelIsExist()
        verifySpendsListValue(expectedValue:"0 ₽")
        
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
    
    private func clickOnCreateNewAccountButton(){
        let createNewAccountButton = app.staticTexts["Create new account"]
        XCTAssertTrue(createNewAccountButton.exists, "The 'Create new account' button should exist")
        createNewAccountButton.tap()
        checkTextIsAppear("Sign Up","The 'Sign Up' label should appear on the page")
    }
    
    private func checkTextIsAppear(_ text:String ,_ message:String){
        let text = app.staticTexts[text]
        XCTAssertTrue(text.waitForExistence(timeout: 5), message)
    }
    
    private func input(username :String){
        XCTContext.runActivity(named: "Enter the login\(username)"){ _ in
            let userNameTextField = app.textFields["userNameTextField"].firstMatch
            userNameTextField.tap()
            userNameTextField.typeText(username)
        }
    }
    
    private func input(password:String){
        XCTContext.runActivity(named: "Enter the password\(password)"){ _ in
            let passwordTextField =   app.secureTextFields["passwordTextField"].firstMatch
            passwordTextField.tap()
            passwordTextField.typeText(password)
        }
    }
    
    private func input(confirmPasword:String){
        XCTContext.runActivity(named: "Enter the confirmPasword\(confirmPasword)"){ _ in
            let confirmPasswordTextField = app.secureTextFields["confirmPasswordTextField"].firstMatch
            confirmPasswordTextField.tap()
            confirmPasswordTextField.typeText(confirmPasword)
        }
    }
    
    private func clickOnSignUpButton(){
        app.buttons["Sign Up"].tap()
    }
    
    private func doRegistration(username:String,password:String,confirmPasword:String){
        XCTContext.runActivity(named: "Register user with name is \(username)"){ _ in
            input(username: username)
            input(password: password)
            input(confirmPasword: confirmPasword)
            clickOnSignUpButton()
        }
    }
    
    private func clickOnAlertLoginButton(){
        app.alerts["Congratulations!"].buttons["Log in"].tap()
    }
    
    private func clickOnLoginButton(){
        app.buttons["loginButton"].tap()
    }
    
    private func checkSpendsListIsNotVisible(){
       // this method will work when we dont have an identifier
        let spendsList = app.staticTexts["spendsList"]
        XCTAssertFalse(spendsList.exists, "The spendsList element should not exist in the hierarchy.")
    }
    
    // MARK: - Method to verify spends list value using identifier
    private func verifySpendsListValue(expectedValue: String) {
        let spendsList = app.staticTexts["spendsList"]
        let exists = spendsList.waitForExistence(timeout: 5)
        XCTAssertTrue(exists, "The spends list element with identifier \("spendsList") does not exist.")
        let actualValue = spendsList.label
        XCTAssertEqual(actualValue, expectedValue, "The value of spends list should be \(expectedValue), but it is \(actualValue).")
    }
    
    public func checkStatisticsLabelIsExist(){
        let statisticsLabel = app.staticTexts["Statistics"]
        XCTAssertTrue(statisticsLabel.waitForExistence(timeout: 3))
    }
    
}
