//
//  CitySearchAssembly.swift
//  WeatherApp
//
//  Created by Алексей Молокович on 01.08.2021.
//

import UIKit

enum CitySearchAssembly
{
	struct Parameters
	{
		let updateCityHandler: MainTabUpdateCityCompletion
	}

	static func makeModule(parameters: Parameters) -> UIViewController {
		let viewController = CitySearchViewController()
		viewController.updateCityHandler = parameters.updateCityHandler
		return viewController
	}
}
