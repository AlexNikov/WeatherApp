//
//  MainTabScreen.swift
//  WeatherAppUITests
//
//  Created by Алексей Молокович on 14.10.2023.
//

import Foundation

final class MainTabScreen: BaseScreen {

    @discardableResult
    func tapOnPlus() -> Self {
        app.navigationBars["WeatherApp.MainTabView"].buttons[MainTabAccessibility.settingItem.rawValue].tap()
        return self
    }
}
