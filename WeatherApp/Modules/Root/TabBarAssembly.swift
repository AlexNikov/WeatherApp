//
//  TabBarAssembly.swift
//  WeatherApp
//
//  Created by Алексей Молокович on 31.07.2021.
//

import UIKit

enum TabBarAssembly
{
	enum TabType: Int, CaseIterable
	{
		case main = 0
		case forecast
	}

	struct Parameters
	{
		let items: [TabType: UIViewController]
	}

	static func makeModule(parameters: Parameters) -> UIViewController {
		let presenter = TabBarPresenter(tabs: parameters.items.compactMap({ $0.key }))
		let tabbarController = TabBarViewController(presenter: presenter)

		tabbarController.viewControllers = parameters.items
			.sorted { $0.key.rawValue < $1.key.rawValue }
			.compactMap({ $0.value})

		return tabbarController
	}
}
