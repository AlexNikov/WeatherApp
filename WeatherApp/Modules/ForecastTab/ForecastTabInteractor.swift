//
//  ForecastTabInteractor.swift
//  WeatherApp
//
//  Created by Алексей Молокович on 01.08.2021.
//

import Foundation

protocol IForecastTabInteractor
{
	var items: [WeatherItem] { get }

	func getForecast(completion: @escaping (NetError?) -> Void)
}

class ForecastTabInteractor
{
	private let weatherServices: WeatherServices
	private let userDefaultsStorage: IUserDefaultsStorage

	init(weatherServices: WeatherServices,
		 userDefaultsStorage: IUserDefaultsStorage) {
		self.weatherServices = weatherServices
		self.userDefaultsStorage = userDefaultsStorage
	}
}

extension ForecastTabInteractor: IForecastTabInteractor
{
	var items: [WeatherItem] {
		set {
			userDefaultsStorage.set(newValue, forKey: .forecast)
		}
		get {
			userDefaultsStorage.object(forKey: .forecast) ?? []
		}
	}

	func getForecast(completion: @escaping (NetError?) -> Void) {
		guard let cityInfo: CityInfo = userDefaultsStorage.object(forKey: .lastCity) else {
			return
		}
		weatherServices.getForecast(with: cityInfo.location) { [weak self] response in
			switch response
			{
			case .success(let data):
				self?.items = data.list.map { item in
					let decor = WeatherItemDecorator(response: item)

					return WeatherItem(date: decor.dateFormated ?? "",
									   icon: decor.weatherCondition.icon,
									   temperature: decor.temperatureFormated ?? "")
				}

				DispatchQueue.main.async {
					completion(nil)
				}

			case .failure(let error):
				DispatchQueue.main.async {
					completion(error)
				}

			}
		}
	}
}
