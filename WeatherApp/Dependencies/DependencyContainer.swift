//
//  DependencyContainer.swift
//  WeatherApp
//
//  Created by Алексей Молокович on 30.07.2021.
//

class DependencyContainer
{
	lazy var networkManager: INetworkManager = NetworkManager()

	lazy var localLanguageService = LocalLanguageService()

	lazy var weatherServices = WeatherServices(networkManager: networkManager,
											   localLanguageService: localLanguageService)

	lazy var alertProvider: IAlertProvider = AlertProvider()

	lazy var locationManager: ILocationManager = LocationManager()

	lazy var userDefaultsStorage: IUserDefaultsStorage = UserDefaultsStorage()
}
