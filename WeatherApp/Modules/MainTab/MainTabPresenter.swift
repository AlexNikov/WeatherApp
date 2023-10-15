//
//  MainTabPresenter.swift
//  WeatherApp
//
//  Created by Алексей Молокович on 31.07.2021.
//
import UIKit

protocol IMainTabPresenter
{
	func didLoad(vc: IMainTabViewController,
				 ui: IMainTabView)
}

class MainTabPresenter
{
	var alertProvider: IAlertProvider?

	private weak var ui: IMainTabView?
	private var completion: MainTabCompletion
	private var interactor: IMainTabInteractor

	init(interactor: IMainTabInteractor,
		 completion: @escaping MainTabCompletion) {
		self.interactor = interactor
		self.completion = completion
	}

}

extension MainTabPresenter: IMainTabPresenter
{
	func didLoad(vc: IMainTabViewController,
				 ui: IMainTabView) {
		self.ui = ui

		vc.tapSettingHandler = {[weak self] in
			guard let self = self else { return }
			self.completion(.openCityList(self.updateCity(city:)))
		}

		loadSavedCityWeather()

		interactor.handlerIfDeniedLocation = { [weak self] in
//			self?.showLocationAlert()
		}
		interactor.checkPermission()
	}

	func updateCity(city: CityInfo) {
		guard let cityName = city.name else { return }
		interactor.save(byLocation: false)
		interactor.save(city: city)
		interactor.deleteLastForecast()
		ui?.set(cityName: cityName)

		loadWeather(location: city.location)
	}

	func loadSavedCityWeather() {
		if let city = interactor.loadSavedCity() {
			loadWeather(location: city.location)
		}
	}

	func loadWeather(location: Location) {
		interactor.getWeather(with: location) {[weak self] result in
			switch result {
			case .success(let data):
				self?.updateUI(data: data)
			case .failure(let error):
				self?.alertProvider?.showAlert(with: error.localizedDescription, title: nil)
			}
		}
	}

	func updateUI(data: WeatherDecorator) {
		if interactor.showCityByLocation {
			ui?.set(cityName: data.response.name)
			let city = CityInfo(name: data.response.name,
								location: Location(longitude: data.response.lon,
												   latitude: data.response.lat))
			interactor.save(city: city)
		} else {
			let cityName = interactor.loadSavedCity()?.name ?? data.response.name
			ui?.set(cityName: cityName)
		}

		ui?.set(hint: data.weatherCondition.textualRepresentation,
				temperature: data.temperatureFormated ?? "",
				icon: data.weatherCondition.icon)
	}

	func showLocationAlert() {
		let message = NSLocalizedString("LocationWarning", comment: "To get weather data, you need to enable the definition of geolocation in the settings")
		let title = NSLocalizedString("Warning", comment: "Warning")
		let buttonTitle = NSLocalizedString("Settings", comment: "Settings")
		let action: () -> Void = { [weak self] in
			guard let url = self?.interactor.settingsUrl() else { return }
			UIApplication.shared.open(url)
		}

		alertProvider?.showAlert(with: message,
								 title: title,
								 secondButtonTitle: buttonTitle,
								 action: action)
	}
}

extension MainTabPresenter: ILocationManagerDelegate
{
	func didUpdate(with notifire: LocationNotifierType) {
		switch notifire {
		case .update(let location):
			if interactor.showCityByLocation {
				loadWeather(location: location)
			}
		case .changeStatus:
			interactor.checkPermission()
		case .failure(let error):
			Logger.error(error.localizedDescription)
		case .willEnterForeground:
			loadSavedCityWeather()
		}
	}
}
