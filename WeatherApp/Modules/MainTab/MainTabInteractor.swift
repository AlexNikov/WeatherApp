//
//  MainTabInteractor.swift
//  WeatherApp
//
//  Created by Алексей Молокович on 01.08.2021.
//

import Foundation

protocol IMainTabInteractor
{
	var handlerIfDeniedLocation: (() -> Void)? { get set }
	var showCityByLocation: Bool { get}

	func getWeather(with location: Location,
					completion: @escaping (Result<WeatherDecorator, NetError>) -> Void)

	func save(city: CityInfo)
	func save(byLocation: Bool)
	func deleteLastForecast()
	func loadSavedCity() -> CityInfo?

	func settingsUrl() -> URL?
	func checkPermission()
}

class MainTabInteractor
{
	var handlerIfDeniedLocation: (() -> Void)?

	private var locationManager: ILocationManager
	private let weatherServices: WeatherServices
	private let userDefaultsStorage: IUserDefaultsStorage

	init(locationManager: ILocationManager,
		 weatherServices: WeatherServices,
		 userDefaultsStorage: IUserDefaultsStorage) {
		self.locationManager = locationManager
		self.weatherServices = weatherServices
		self.userDefaultsStorage = userDefaultsStorage
	}

}

extension MainTabInteractor: IMainTabInteractor
{
	var showCityByLocation: Bool {
		userDefaultsStorage.object(forKey: .showCityByLocation) ?? true
	}

	func settingsUrl() -> URL? {
		locationManager.settingsUrl()
	}

	func getWeather(with location: Location, completion: @escaping (Result<WeatherDecorator, NetError>) -> Void) {
		weatherServices.getWeather(with: location) { response in
			DispatchQueue.main.async {
				switch response {
				case .success(let data):
					completion(.success(WeatherDecorator(response: data)))
				case .failure(let error):
					completion(.failure(error))
				}
			}
		}
	}

	func save(city: CityInfo)  {
		userDefaultsStorage.set(city, forKey: .lastCity)
	}

	func deleteLastForecast()  {
		let items: [WeatherItem]? = nil
		userDefaultsStorage.set(items, forKey: .forecast)
	}

	func save(byLocation: Bool) {
		userDefaultsStorage.set(byLocation, forKey: .showCityByLocation)
	}

	func loadSavedCity() -> CityInfo? {
		userDefaultsStorage.object(forKey: .lastCity)
	}

	func checkPermission() {
		switch locationManager.authorizationStatus {
		case .authorizedAlways, .authorizedWhenInUse:
			locationManager.startUpdatingLocation()
		case .restricted, .notDetermined:
			locationManager.requestAuthorization()
		case .denied:
			handlerIfDeniedLocation?()
		default:
			return
		}
	}
}

private extension MainTabInteractor
{

}
