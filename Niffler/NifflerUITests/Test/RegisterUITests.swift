//
//  RegisterUITests.swift
//  Niffler
//
//  Created by Mac Zi_Yan on 09.12.24.
//
import XCTest

final class RegisterUITests: TestCase {

    func test_register() throws {
        launchAppWithoutLogin()

        //Arrange
        loginPage.clickOnCreateNewAccountButton()

        //Act
        let uniqueUsername = RandomTextGenerator().generateRandomString()
        registerPage.doRegistration(
            username: uniqueUsername, password: "12345", confirmPasword: "12345"
        )
        .clickOnAlertLoginButton()
        .clickOnLoginButton()

        //Asert
        spendsPage
            .checkAddSpendButtonIsExist()
            .checkStatisticsLabelIsExist()
    }
}
