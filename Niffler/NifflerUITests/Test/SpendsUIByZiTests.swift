//
//  SpendsUITestsByZi.swift
//  Niffler
//
//  Created by Mac Zi_Yan on 10.12.24.
//
import XCTest

final class SpendsUIByZiTests: TestCase {

    func test_checkSpendListIsEmpty() throws {
        launchAppWithoutLogin()

        //Arrange
        loginPage.clickOnCreateNewAccountButton()

        let uniqueUsername = RandomTextGenerator().generateRandomString()

        //Act
        registerPage.doRegistration(
            username: uniqueUsername, password: "12345", confirmPasword: "12345"
        )
        .clickOnAlertLoginButton()
        .clickOnLoginButton()

        //Alert
        spendsPage.checkStatisticsLabelIsExist()
            .verifySpendsListValue(expectedValue: "0 ₽")

    }

    func test_AddNewspendWithoutCategory() throws {
        launchAppWithoutLogin()

        //Arrange
        loginPage.clickOnCreateNewAccountButton()

        let uniqueUsername = RandomTextGenerator().generateRandomString()

        //Act
        registerPage.doRegistration(
            username: uniqueUsername, password: "12345", confirmPasword: "12345"
        )
        .clickOnAlertLoginButton()
        .clickOnLoginButton()
        spendsPage.clickOnAddNewSpendButton()
        newSpendPage
            .fillAmountField("250")
            .fillDescriptionField("Test Desc")
            .clickOnAddButton()

        //Asert
        spendsPage.checkNewSpendIsShown(title: "Test Desc")

    }

    func test_AddNewspendWithNewCategory() throws {
        launchAppWithoutLogin()

        //Arrange
        loginPage.clickOnCreateNewAccountButton()

        let uniqueUsername = RandomTextGenerator().generateRandomString()

        //Act
        registerPage.doRegistration(
            username: uniqueUsername, password: "12345", confirmPasword: "12345"
        )
        .clickOnAlertLoginButton()
        .clickOnLoginButton()
        spendsPage.clickOnAddNewSpendButton()
        newSpendPage
            .inputSpend(amount: "250", description: "Test Desc", title: "Test")

        //Asert
        spendsPage.checkNewSpendIsShown(title: "Test Desc")

    }

    func test_checkCategoryNameInProfile() throws {
        launchAppWithoutLogin()

        //Arrange
        loginPage.clickOnCreateNewAccountButton()

        let uniqueUsername = RandomTextGenerator().generateRandomString()

        //Act
        registerPage.doRegistration(
            username: uniqueUsername, password: "12345", confirmPasword: "12345"
        )
        .clickOnAlertLoginButton()
        .clickOnLoginButton()
        spendsPage.clickOnAddNewSpendButton()
        newSpendPage
            .inputSpend(amount: "250", description: "Test Desc", title: "Test")

        //Asert
        spendsPage
            .checkNewSpendIsShown(title: "Test Desc")
            .clickOnMenuButton()
            .clickOnProfileButton()

        profilePage.checkIfcategoryExist(categoryName: "Test")

    }

    func test_checkAfterDeleteCategoryNe3wCategoryButtonIsVisibleAndClickable()
        throws
    {
        launchAppWithoutLogin()

        //Arrange
        loginPage.clickOnCreateNewAccountButton()

        let uniqueUsername = RandomTextGenerator().generateRandomString()

        //Act
        registerPage.doRegistration(
            username: uniqueUsername, password: "12345", confirmPasword: "12345"
        )
        .clickOnAlertLoginButton()
        .clickOnLoginButton()
        spendsPage.clickOnAddNewSpendButton()
        newSpendPage
            .inputSpend(amount: "250", description: "Test Desc", title: "Test")
        spendsPage.checkNewSpendIsShown(title: "Test Desc")
            .clickOnMenuButton()
            .clickOnProfileButton()
        profilePage
            .deleteExistingCategory(categoryName: "Test")
            .clickOnCloseButton()

        //Asert
        spendsPage.clickOnAddNewSpendButton()
        newSpendPage.verifyIfNewCategoryButtonIsVisibleAndClickable()
    }
}
