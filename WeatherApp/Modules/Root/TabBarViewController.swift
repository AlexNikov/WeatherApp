//
//  TabBarViewController.swift
//  WeatherApp
//
//  Created by Алексей Молокович on 31.07.2021.
//

import UIKit

protocol ITabBarViewController: AnyObject
{
	func set(tab: TabBarAssembly.TabType,
			 title: String,
			 icon: IconAssets,
			 selectedIcon: IconAssets)
}

class TabBarViewController: UITabBarController, UITabBarControllerDelegate
{
	private var presenter: ITabBarPresenter

	init(presenter: ITabBarPresenter) {
		self.presenter = presenter
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}


	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

		presenter.willAppear(vc: self)
	}
}

extension TabBarViewController: ITabBarViewController
{
	func set(tab: TabBarAssembly.TabType,
			 title: String,
			 icon: IconAssets,
			 selectedIcon: IconAssets) {

		guard let count = tabBar.items?.count,
			  tab.rawValue < count else {
			// упадем только в дебаге
			assertionFailure("некорректный номер таба")
			return
		}
		tabBar.items?[tab.rawValue].title = title
		tabBar.items?[tab.rawValue].image = icon.image
		tabBar.items?[tab.rawValue].selectedImage = selectedIcon.image
	}
}
