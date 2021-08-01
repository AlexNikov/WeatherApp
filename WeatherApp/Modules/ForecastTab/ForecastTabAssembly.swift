//
//  ForecastTabAssembly.swift
//  WeatherApp
//
//  Created by Алексей Молокович on 31.07.2021.
//

import UIKit

enum ForecastTabAssembly
{
	struct Dependencies {
		let weatherServices: WeatherServices
		let alertProvider: IAlertProvider
		let userDefaultsStorage: IUserDefaultsStorage
	}

	static func makeModule(dependencies: Dependencies) -> UIViewController {

		let interactor = ForecastTabInteractor(weatherServices: dependencies.weatherServices,
											   userDefaultsStorage: dependencies.userDefaultsStorage)
		let presenter = ForecastTabPresenter(interactor: interactor,
											 alertProvider: dependencies.alertProvider)
		let viewController = ForecastTabViewController(presenter: presenter,
													   alertProvider: dependencies.alertProvider)
		return viewController
	}
}
