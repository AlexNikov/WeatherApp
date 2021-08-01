//
//  TabBarPresenter.swift
//  WeatherApp
//
//  Created by Алексей Молокович on 31.07.2021.
//

import Foundation

protocol ITabBarPresenter
{
	func willAppear(vc: ITabBarViewController)
}
class TabBarPresenter
{
	private weak var vc: ITabBarViewController?
	private let tabs: [TabBarAssembly.TabType]

	init(tabs: [TabBarAssembly.TabType]) {
		self.tabs = tabs
	}
}

extension TabBarPresenter: ITabBarPresenter
{
	func willAppear(vc: ITabBarViewController) {
		self.vc = vc
		
		configureTabs()
	}
}

private extension TabBarPresenter
{
	func configureTabs() {
		tabs.forEach { tab in
			switch tab {
			case .main:
				let title = NSLocalizedString("Main", comment: "Main")
				vc?.set(tab: tab, title: title, icon: .home, selectedIcon: .home)
			case .forecast:
				let title = NSLocalizedString("Forecast", comment: "Forecast")
				vc?.set(tab: tab, title: title, icon: .menuHamburger, selectedIcon: .menuHamburger)
			}
		}
	}
}

