//
//  DependencyContainer.swift
//  WeatherApp
//
//  Created by Алексей Молокович on 30.07.2021.
//

protocol DependencyContainerProtocol {
    var networkManager: INetworkManager { get }
    var localLanguageService: LocalLanguageService { get }
    var weatherServices: WeatherServices { get }
    var alertProvider: IAlertProvider { get }
    var locationManager: ILocationManager { get }
    var userDefaultsStorage: IUserDefaultsStorage { get }
}

class DependencyContainer: DependencyContainerProtocol
{
	lazy var networkManager: INetworkManager = NetworkManager()

	lazy var localLanguageService = LocalLanguageService()

	lazy var weatherServices = WeatherServices(networkManager: networkManager,
											   localLanguageService: localLanguageService)

	lazy var alertProvider: IAlertProvider = AlertProvider()

	lazy var locationManager: ILocationManager = LocationManager()

	lazy var userDefaultsStorage: IUserDefaultsStorage = UserDefaultsStorage()
}

class MockDependencyContainer: DependencyContainerProtocol
{
    lazy var networkManager: INetworkManager = NetworkManager()

    lazy var localLanguageService = LocalLanguageService()

    lazy var weatherServices = WeatherServices(networkManager: networkManager,
                                               localLanguageService: localLanguageService)

    lazy var alertProvider: IAlertProvider = AlertProvider()

    lazy var locationManager: ILocationManager = LocationManager()

    lazy var userDefaultsStorage: IUserDefaultsStorage = UserDefaultsStorage()
}
