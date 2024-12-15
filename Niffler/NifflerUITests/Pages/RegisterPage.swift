//
//  RegisterPage.swift
//  Niffler
//
//  Created by Mac on 15.12.24.
//
import XCTest

class RegisterPage: BasePage {

    func input(login: String) {
        XCTContext.runActivity(named: "Enter the login\(login)") { _ in
            let userNameTextField = app.textFields["userNameTextField"]
                .firstMatch
            userNameTextField.tap()
            userNameTextField.typeText(login)
        }
    }

    func input(password: String) {
        XCTContext.runActivity(named: "Enter the password\(password)") { _ in
            let passwordTextField = app.secureTextFields["passwordTextField"]
                .firstMatch
            passwordTextField.tap()
            passwordTextField.typeText(password)
        }
    }

    func input(confirmPasword: String) {
        XCTContext.runActivity(
            named: "Enter the confirmPasword\(confirmPasword)"
        ) { _ in
            let confirmPasswordTextField = app.secureTextFields[
                "confirmPasswordTextField"
            ].firstMatch
            confirmPasswordTextField.tap()
            confirmPasswordTextField.typeText(confirmPasword)
        }
    }

    func input(login: String, password: String, confirmPasword: String) {
        input(login: login)
        input(password: password)
        input(confirmPasword: confirmPasword)
    }
    
    func doRegistration(username:String,password:String,confirmPasword:String){
        XCTContext.runActivity(named: "Register user with name is \(username)"){ _ in
            input(login: username)
            input(password: password)
            input(confirmPasword: confirmPasword)
            clickOnSignUpButton()
        }
    }

    func clickOnSignUpButton() {
        app.buttons["Sign Up"].tap()
    }

    func clickOnLoginButton() {
        app.buttons["loginButton"].tap()
    }

    func clickOnAlertLoginButton() {
        app.alerts["Congratulations!"].buttons["Log in"].tap()
    }

    func verifyTextFieldValue(
        _ textFieldIdentifier: String, expectedValue: String
    ) {
        let textField = app.textFields[textFieldIdentifier].firstMatch
        XCTAssertTrue(
            textField.exists,
            "The text field with identifier \(textFieldIdentifier) should exist."
        )
        XCTAssertEqual(
            textField.value as? String,
            expectedValue,
            "The value in the text field should be \(expectedValue).",
            file: #file,
            line: #line
        )
    }
    
}
