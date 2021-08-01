//
//  MainTabAssembly.swift
//  WeatherApp
//
//  Created by Алексей Молокович on 31.07.2021.
//

import UIKit

typealias MainTabCompletion = (MainTabAssembly.CompletionType) -> Void
typealias MainTabUpdateCityCompletion = (CityInfo) -> Void

enum MainTabAssembly
{
	enum CompletionType
	{
		case openCityList(MainTabUpdateCityCompletion)
	}

	struct Dependencies {
		let weatherServices: WeatherServices
		let alertProvider: IAlertProvider
		let locationManager: ILocationManager
		let userDefaultsStorage: IUserDefaultsStorage
	}

	struct Parameters
	{
		let completion: MainTabCompletion
	}

	static func makeModule(parameters: Parameters,
						   dependencies: Dependencies) -> UIViewController {
		var locationManager = dependencies.locationManager
		let interactor = MainTabInteractor(locationManager: locationManager,
										   weatherServices: dependencies.weatherServices,
										   userDefaultsStorage: dependencies.userDefaultsStorage)
		let presenter = MainTabPresenter(interactor: interactor,
										 completion: parameters.completion)
		locationManager.delegate = presenter
		let viewController = MainTabViewController(presenter: presenter,
												   alertProvider: dependencies.alertProvider)

		presenter.alertProvider = dependencies.alertProvider

		return viewController
	}
}
