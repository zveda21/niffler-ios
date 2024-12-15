//
//  RegisterUITests.swift
//  Niffler
//
//  Created by Mac Zi_Yan on 09.12.24.
//
import XCTest

final class RegisterUITests:XCTestCase{
    
    var app :XCUIApplication!
    
    override func setUp() {
        super.setUp()
        launchAppWithoutLogin()
    }
    
    func test_register()  throws {
        
        //Arrange
        clickOnCreateNewAccountButton()
        
        //Act
        let uniqueUsername = generateRandomString()
        input(login: uniqueUsername)
        input(password: "12345")
        input(confirmPasword: "12345")
        clickOnSignUpButton()
        clickOnAlertLoginButton()
        clickOnLoginButton()
        
        //verifyTextFieldValue("userNameTextField", expectedValue: uniqueUsername)

        //Asert
        checkAddSpendButtonIsExist()
        checkStatisticsLabelIsExist()
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
    
    private func input(login:String){
        XCTContext.runActivity(named: "Enter the login\(login)"){ _ in
            let userNameTextField = app.textFields["userNameTextField"].firstMatch
            userNameTextField.tap()
            userNameTextField.typeText(login)
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
    
    private func input(login:String,password:String,confirmPasword:String){
        input(login: login)
        input(password: password)
        input(confirmPasword: confirmPasword)
    }
    
    private func clickOnSignUpButton(){
        app.buttons["Sign Up"].tap()
    }
    
    private func verifyTextFieldValue(_ textFieldIdentifier: String, expectedValue: String) {
        let textField = app.textFields[textFieldIdentifier].firstMatch
        XCTAssertTrue(textField.exists, "The text field with identifier \(textFieldIdentifier) should exist.")
        XCTAssertEqual(
            textField.value as? String,
            expectedValue,
            "The value in the text field should be \(expectedValue).",
            file: #file,
            line: #line
        )
    }

    private func clickOnLoginButton(){
        app.buttons["loginButton"].tap()
    }
    
    
    private func clickOnAlertLoginButton(){
        app.alerts["Congratulations!"].buttons["Log in"].tap()
    }
    
    public func checkAddSpendButtonIsExist(){
        let addSpendButton = app.buttons["addSpendButton"]
        XCTAssertTrue(addSpendButton.waitForExistence(timeout: 5))
    }
    
    public func checkStatisticsLabelIsExist(){
        let statisticsLabel = app.staticTexts["Statistics"]
        XCTAssertTrue(statisticsLabel.waitForExistence(timeout: 3))
    }
}
