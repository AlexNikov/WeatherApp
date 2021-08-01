//
//  WeatherServices.swift
//  WeatherApp
//
//  Created by Алексей Молокович on 31.07.2021.
//

import Foundation

class WeatherServices
{
	private let networkManager: INetworkManager
	private let localLanguageService: LocalLanguageService

	private enum QueryType: String
	{
		case lat
		case lon
		case lang
	}

	init(networkManager: INetworkManager,
		 localLanguageService: LocalLanguageService) {
		self.networkManager = networkManager
		self.localLanguageService = localLanguageService
	}

	func getWeather(with location: Location,
					completion: @escaping (Result<WeatherResponse, NetError>) -> Void) {

		networkManager.getRequest(
			queryItems: [
				QueryType.lat.rawValue : "\(location.latitude)",
				QueryType.lon.rawValue : "\(location.longitude)",
				QueryType.lang.rawValue : localLanguageService.languageCode,
			],
			url: "weather",
			completion: completion)
	}

	func getForecast(with location: Location,
					 completion: @escaping (Result<ForecastResponse, NetError>) -> Void) {

		networkManager.getRequest(
			queryItems: [
				QueryType.lat.rawValue : "\(location.latitude)",
				QueryType.lon.rawValue : "\(location.longitude)",
				QueryType.lang.rawValue : localLanguageService.languageCode,
			],
			url: "forecast",
			completion: completion)
	}
}
