//
//  RegisterUITests.swift
//  Niffler
//
//  Created by Mac Zi_Yan on 09.12.24.
//
import XCTest

final class RegisterUITests:XCTestCase{
    func test1() throws{
       let app = XCUIApplication()
                app.launch()
        
        let createNewAccountButton = app.staticTexts["Create new account"]
        XCTAssertTrue(createNewAccountButton.exists, "The 'Create new account' button should exist")
        createNewAccountButton.tap()

        
        let signUpLabel = app.staticTexts["Sign Up"]
        XCTAssertTrue(signUpLabel.waitForExistence(timeout: 5), "The 'Sign Up' label should appear on the page")

        
        let userNameTextField = app.textFields["userNameTextField"].firstMatch
        XCTAssertTrue(userNameTextField.exists, "The username text field should exist")
        let uniqueUsername = generateRandomString()

        userNameTextField.tap()
        userNameTextField.typeText(uniqueUsername)
        
        app.buttons["return"].tap()
                
        let passwordTextField =   app.secureTextFields["passwordTextField"].firstMatch
        XCTAssertTrue(passwordTextField.exists, "The password text field should exist")
        passwordTextField.tap()
        passwordTextField.typeText("12345")
        
        app.buttons["return"].tap()
        
        let confirmPasswordTextField = app.secureTextFields["confirmPasswordTextField"].firstMatch
        XCTAssertTrue(confirmPasswordTextField.exists, "The confirm password text field should exist")
        confirmPasswordTextField.tap()
        confirmPasswordTextField.typeText("12345")
        app.buttons["return"].tap()
        
        let signUpButton = app.buttons["Sign Up"]
        signUpButton.tap()
        
        let congratulationsAlert = app.alerts["Congratulations!"]
        let alertLogInButton = congratulationsAlert.buttons["Log in"]
        alertLogInButton.tap()
        
        XCTAssertEqual(app.textFields["userNameTextField"].firstMatch.value as! String, uniqueUsername)
        
        let loginButton = app.buttons["loginButton"]
        loginButton.tap()
        let addSpendButton = app.buttons["addSpendButton"]
        XCTAssertTrue(addSpendButton.waitForExistence(timeout: 3))
        let statisticsLabel = app.staticTexts["Statistics"]
        XCTAssertTrue(statisticsLabel.waitForExistence(timeout: 3))

    }
    
    func generateRandomString(length: Int = 6) -> String {
        let characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map { _ in characters.randomElement()! })
    }
    
}
