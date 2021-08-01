//
//  RootCoordinator.swift
//  WeatherApp
//
//  Created by Алексей Молокович on 30.07.2021.
//

import UIKit

class RootCoordinator: BaseCoordinator, ICoordinator
{
	func start(endFlowCompletion: (() -> Void)? = nil) {
		navigationController.setNavigationBarHidden(true, animated: false)

		let mainTabNavigationController = UINavigationController()
		let mainTabCoordinator: MainTabCoordinator = coordinatorFactory.make(
			navigationController: mainTabNavigationController
		)
		childCoordinator.append(mainTabCoordinator)
		mainTabCoordinator.start(endFlowCompletion: nil)

		let forecastTabNavigationController = UINavigationController()
		let forecastTabCoordinator: ForecastTabCoordinator = coordinatorFactory.make(
			navigationController: forecastTabNavigationController
		)

		childCoordinator.append(forecastTabCoordinator)
		forecastTabCoordinator.start(endFlowCompletion: nil)

		let tabItems: [TabBarAssembly.TabType: UIViewController] = [
			.main : mainTabNavigationController,
			.forecast : forecastTabNavigationController
		]
		let parameters = TabBarAssembly.Parameters(items: tabItems)
		let mainViewController = moduleFactory.makeRootModule(parameters: parameters)
		navigationController.viewControllers = [mainViewController]
	}
}
