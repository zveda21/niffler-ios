//
//  SpendsUITestsByZi.swift
//  Niffler
//
//  Created by Mac Zi_Yan on 10.12.24.
//
import XCTest

final class SpendsUIByZiTests: TestCase {

    func test_checkSpendListIsEmpty() throws {
        let app = XCUIApplication()
        let loginPage = LoginPage(app: app)
        let registerPage = RegisterPage(app: app)
        let spendsPage = SpendsPage(app: app)
        loginPage.launchAppWithoutLogin()

        //Arrange
        loginPage.clickOnCreateNewAccountButton()

        let uniqueUsername = RandomTextGenerator().generateRandomString()

        //Act
        registerPage.doRegistration(
            username: uniqueUsername, password: "12345", confirmPasword: "12345"
        )
        registerPage.clickOnAlertLoginButton()
        registerPage.clickOnLoginButton()

        //Alert
        spendsPage.checkStatisticsLabelIsExist()
        spendsPage.verifySpendsListValue(expectedValue: "0 ₽")

    }

    func test_AddNewspendWithoutCategory() throws {

        let app = XCUIApplication()
        let loginPage = LoginPage(app: app)
        let registerPage = RegisterPage(app: app)
        let spendsPage = SpendsPage(app: app)
        let newSpendPage = NewSpendPage(app: app)
        loginPage.launchAppWithoutLogin()

        //Arrange
        loginPage.clickOnCreateNewAccountButton()

        let uniqueUsername = RandomTextGenerator().generateRandomString()

        //Act
        registerPage.doRegistration(
            username: uniqueUsername, password: "12345", confirmPasword: "12345"
        )
        registerPage.clickOnAlertLoginButton()
        registerPage.clickOnLoginButton()
        spendsPage.clickOnAddNewSpendButton()
        newSpendPage.fillAmountField("250")
        newSpendPage.fillDescriptionField("Test Desc")
        newSpendPage.clickOnAddButton()

        //Asert
        spendsPage.checkNewSpendIsShown(title: "Test Desc")

    }

    func test_AddNewspendWithNewCategory() throws {
        let app = XCUIApplication()
        let loginPage = LoginPage(app: app)
        let registerPage = RegisterPage(app: app)
        let spendsPage = SpendsPage(app: app)
        let newSpendPage = NewSpendPage(app: app)
        loginPage.launchAppWithoutLogin()

        //Arrange
        loginPage.clickOnCreateNewAccountButton()

        let uniqueUsername = RandomTextGenerator().generateRandomString()

        //Act
        registerPage.doRegistration(
            username: uniqueUsername, password: "12345", confirmPasword: "12345"
        )
        registerPage.clickOnAlertLoginButton()
        registerPage.clickOnLoginButton()
        spendsPage.clickOnAddNewSpendButton()
        newSpendPage.fillAmountField("250")
        newSpendPage.fillDescriptionField("Test Desc")
        newSpendPage.clickOnNewCategoryButton("Test")
        newSpendPage.clickOnAddButton()

        //Asert
        spendsPage.checkNewSpendIsShown(title: "Test Desc")
        
    }
    
    func test_checkCategoryNameInProfile() throws {
        let app = XCUIApplication()
        let loginPage = LoginPage(app: app)
        let registerPage = RegisterPage(app: app)
        let spendsPage = SpendsPage(app: app)
        let newSpendPage = NewSpendPage(app: app)
        let profilePage = ProfilePage(app: app)
        loginPage.launchAppWithoutLogin()

        //Arrange
        loginPage.clickOnCreateNewAccountButton()

        let uniqueUsername = RandomTextGenerator().generateRandomString()

        //Act
        registerPage.doRegistration(
            username: uniqueUsername, password: "12345", confirmPasword: "12345"
        )
        registerPage.clickOnAlertLoginButton()
        registerPage.clickOnLoginButton()
        spendsPage.clickOnAddNewSpendButton()
        newSpendPage.fillAmountField("250")
        newSpendPage.fillDescriptionField("Test Desc")
        newSpendPage.clickOnNewCategoryButton("Test")
        newSpendPage.clickOnAddButton()

        //Asert
        spendsPage.checkNewSpendIsShown(title: "Test Desc")
        
        spendsPage.clickOnMenuButton()
        spendsPage.clickOnProfileButton()
        
        profilePage.checkIfcategoryExist(categoryName: "Test")
        
    }
    
    func test_checkAfterDeleteCategoryNe3wCategoryButtonIsVisibleAndClickable() throws {
        let app = XCUIApplication()
        let loginPage = LoginPage(app: app)
        let registerPage = RegisterPage(app: app)
        let spendsPage = SpendsPage(app: app)
        let newSpendPage = NewSpendPage(app: app)
        let profilePage = ProfilePage(app: app)
        loginPage.launchAppWithoutLogin()

        //Arrange
        loginPage.clickOnCreateNewAccountButton()

        let uniqueUsername = RandomTextGenerator().generateRandomString()

        //Act
        registerPage.doRegistration(
            username: uniqueUsername, password: "12345", confirmPasword: "12345"
        )
        registerPage.clickOnAlertLoginButton()
        registerPage.clickOnLoginButton()
        spendsPage.clickOnAddNewSpendButton()
        newSpendPage.fillAmountField("250")
        newSpendPage.fillDescriptionField("Test Desc")
        newSpendPage.clickOnNewCategoryButton("Test")
        newSpendPage.clickOnAddButton()
        spendsPage.checkNewSpendIsShown(title: "Test Desc")
        spendsPage.clickOnMenuButton()
        spendsPage.clickOnProfileButton()
        profilePage.deleteExistingCategory(categoryName: "Test")
        profilePage.clickOnCloseButton()
        
        //Asert
        spendsPage.clickOnAddNewSpendButton()
        newSpendPage.verifyIfNewCategoryButtonIsVisibleAndClickable()
        
    }
}
