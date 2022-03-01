//
//  CountriesUITestsLaunchTests.swift
//  CountriesUITests
//
//  Created by huseyin.kucuk on 1.03.2022.
//

import XCTest

class CountriesUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launchEnvironment = ["UITEST_DISABLE_ANIMATIONS" : "YES"]
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
    
    func testUIwithError() throws {
        
        let app = XCUIApplication()
        app.launch()
        app.launchEnvironment = ["UITEST_DISABLE_ANIMATIONS" : "YES"]
        let tablesQuery = app.tables
        let ghanaStaticText = tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Ghana"]/*[[".cells.staticTexts[\"Ghana\"]",".staticTexts[\"Ghana\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        ghanaStaticText.twoFingerTap()
        
        let ghanaNavigationBar = app.navigationBars["Ghana"]
        let loveButton = ghanaNavigationBar.buttons["love"]
        loveButton.twoFingerTap()
        
        let leftButton = ghanaNavigationBar.buttons["Left"]
        leftButton.twoFingerTap()
        
        let tabBar = app.tabBars["Tab Bar"]
        let savedButton = tabBar.buttons["Saved"]
        savedButton.twoFingerTap()
        ghanaStaticText.twoFingerTap()
        loveButton.twoFingerTap()
        leftButton.twoFingerTap()
        
        let countriesButton = tabBar.buttons["Countries"]
        countriesButton.twoFingerTap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["San Marino"]/*[[".cells.staticTexts[\"San Marino\"]",".staticTexts[\"San Marino\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.twoFingerTap()
        
        let sanMarinoNavigationBar = app.navigationBars["San Marino"]
        sanMarinoNavigationBar.buttons["love"].twoFingerTap()
        sanMarinoNavigationBar.buttons["Left"].twoFingerTap()
        savedButton.twoFingerTap()
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["love"]/*[[".cells.buttons[\"love\"]",".buttons[\"love\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.twoFingerTap()
        countriesButton.twoFingerTap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Niger"]/*[[".cells.staticTexts[\"Niger\"]",".staticTexts[\"Niger\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.twoFingerTap()
        
        let nigerNavigationBar = app.navigationBars["Niger"]
        nigerNavigationBar.buttons["love"].twoFingerTap()
        nigerNavigationBar.buttons["Left"].twoFingerTap()
        tablesQuery.cells.containing(.staticText, identifier:"Niger").buttons["love"].twoFingerTap()
        savedButton.twoFingerTap()
                        
       
    }
    
    func testUIWithoutError() throws {
        
        let app = XCUIApplication()
        app.launch()
        app.launchEnvironment = ["UITEST_DISABLE_ANIMATIONS" : "YES"]
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Namibia"]/*[[".cells.staticTexts[\"Namibia\"]",".staticTexts[\"Namibia\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let namibiaNavigationBar = app.navigationBars["Namibia"]
        namibiaNavigationBar.buttons["love"].tap()
        namibiaNavigationBar.buttons["Left"].tap()
        
        let tabBar = app.tabBars["Tab Bar"]
        tabBar.buttons["Saved"].tap()
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["love"]/*[[".cells.buttons[\"love\"]",".buttons[\"love\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tabBar.buttons["Countries"].tap()
                        
    }
}
