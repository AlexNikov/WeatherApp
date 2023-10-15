//
//  CitySearchScreen.swift
//  WeatherAppUITests
//
//  Created by Алексей Молокович on 14.10.2023.
//

import Foundation
import XCTest

final class CitySearchScreen: BaseScreen {

    @discardableResult
    func wait() -> Self {
        let searchBar = app.searchFields[CitySearchAccessibility.searchBar.rawValue]
        searchBar.waitUntilExists(5)
        return self
    }

    @discardableResult
    func typeInSearchBar(text: String) -> Self {
        let searchBar = app.searchFields[CitySearchAccessibility.searchBar.rawValue]
        searchBar.ifExists { element in
            searchBar.tap()
            searchBar.typeText("Moscow")
        }
        return self
    }

    @discardableResult
    func checkAndTap(text: String) -> Self {
        let cell = app.tables.cells.staticTexts[text]
        cell.waitForExistence(timeout: 5)
        XCTAssertTrue(cell.exists)
        cell.tap()
        return self
    }
}
