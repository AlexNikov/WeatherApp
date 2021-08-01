//
//  ForecastTabCoordinator.swift
//  WeatherApp
//
//  Created by Алексей Молокович on 31.07.2021.
//

import UIKit

class ForecastTabCoordinator: BaseCoordinator, ICoordinator
{
	func start(endFlowCompletion: (() -> Void)?) {
		let forecastTabViewController = moduleFactory.makeForecastModule()
		navigationController.viewControllers = [forecastTabViewController]
	}
}

