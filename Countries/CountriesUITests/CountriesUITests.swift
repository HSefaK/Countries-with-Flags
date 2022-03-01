//
//  CountriesUITests.swift
//  CountriesUITests
//
//  Created by huseyin.kucuk on 1.03.2022.
//

import XCTest
import Countries

class CountriesUITests: XCTestCase {


    func unitTestingForUI() {
        let app = XCUIApplication()
        app.tabBars["TabBarController"].buttons["Saved"].tap()
        app.tabBars["TabBarController"].buttons["Countries"].tap()


    }
}
