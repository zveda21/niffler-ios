//
//  RegisterUITests.swift
//  Niffler
//
//  Created by Mac Zi_Yan on 09.12.24.
//
import XCTest

final class RegisterUITests: TestCase {

    func test_register() throws {
        let app = XCUIApplication()
        let loginPage = LoginPage(app: app)
        let registerPage = RegisterPage(app: app)
        let spendsPage = SpendsPage(app: app)
        loginPage.launchAppWithoutLogin()

        //Arrange
        loginPage.clickOnCreateNewAccountButton()

        //Act
        let uniqueUsername = RandomTextGenerator().generateRandomString()
        registerPage.input(login: uniqueUsername)
        registerPage.input(password: "12345")
        registerPage.input(confirmPasword: "12345")
        registerPage.clickOnSignUpButton()
        registerPage.clickOnAlertLoginButton()
        registerPage.clickOnLoginButton()

        //Asert
        spendsPage.checkAddSpendButtonIsExist()
        spendsPage.checkStatisticsLabelIsExist()

    }
}
