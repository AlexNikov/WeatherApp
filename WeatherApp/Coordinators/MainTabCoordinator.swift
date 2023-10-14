//
//  MainTabCoordinator.swift
//  WeatherApp
//
//  Created by Алексей Молокович on 31.07.2021.
//
import UIKit

class MainTabCoordinator: BaseCoordinator, ICoordinator
{
	func start(endFlowCompletion: (() -> Void)?) {

		let mainTabCompletion: (MainTabAssembly.CompletionType) -> Void = { [weak self] type in
			switch type {
			case .openCityList(let updateCityHandler):
				self?.openCitySearch(updateCityHandler)
			}
		}

		let parameters = MainTabAssembly.Parameters(completion: mainTabCompletion)
		let mainTabViewController = moduleFactory.makeMainTabModule(parameters: parameters)
		navigationController.viewControllers = [mainTabViewController]
	}

	func openCitySearch(_ updateCityHandler: @escaping MainTabUpdateCityCompletion) {
		let citySeachController = moduleFactory.makeCitySearch(updateCityHandler: updateCityHandler)
		navigationController.viewControllers.last?.present(citySeachController,
																animated: true,
																completion: nil)
	}
}
