//
//  WeatherAppUITests.swift
//  WeatherAppUITests
//
//  Created by Алексей Молокович on 14.10.2023.
//

import XCTest
import SnapshotTesting

final class WeatherAppUITests: XCTestCase {

    var app: XCUIApplication!
    let mainTabScreen = MainTabScreen()
    let citySearchScreen = CitySearchScreen()

    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = [CommandLine.uiTesting]
        app.launch()
    }

    func testExample() throws {

        mainTabScreen
            .tapOnPlus()
        citySearchScreen
            .wait()
            .typeInSearchBar(text: "Moscow")
            .checkAndTap(text: "RU-Moscow-Москва")
    }
}
