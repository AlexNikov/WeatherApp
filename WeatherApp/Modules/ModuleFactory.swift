//
//  ModuleFactory.swift
//  WeatherApp
//
//  Created by Алексей Молокович on 31.07.2021.
//

import UIKit

class ModuleFactory
{
	private let dependencyContainer: DependencyContainerProtocol

	init(dependencyContainer: DependencyContainerProtocol) {
		self.dependencyContainer = dependencyContainer
	}

	func makeRootModule(parameters: TabBarAssembly.Parameters) -> UIViewController {
		TabBarAssembly.makeModule(parameters: parameters)
	}

	func makeMainTabModule(parameters: MainTabAssembly.Parameters) -> UIViewController {
		let dependencies = MainTabAssembly.Dependencies(
			weatherServices: dependencyContainer.weatherServices,
			alertProvider: dependencyContainer.alertProvider,
			locationManager: dependencyContainer.locationManager,
			userDefaultsStorage: dependencyContainer.userDefaultsStorage
		)
		return MainTabAssembly.makeModule(parameters: parameters,
										  dependencies: dependencies)
	}

	func makeForecastModule() -> UIViewController {
		let dependencies = ForecastTabAssembly.Dependencies(weatherServices: dependencyContainer.weatherServices,
															alertProvider: dependencyContainer.alertProvider,
															userDefaultsStorage: dependencyContainer.userDefaultsStorage)

		return ForecastTabAssembly.makeModule(dependencies: dependencies)
	}

	func makeCitySearch(updateCityHandler: @escaping MainTabUpdateCityCompletion) -> UIViewController {
		CitySearchAssembly.makeModule(
			parameters: CitySearchAssembly.Parameters(
				updateCityHandler: updateCityHandler
			)
		)
	}
}
