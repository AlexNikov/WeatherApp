//
//  ForecastTabPresenter.swift
//  WeatherApp
//
//  Created by Алексей Молокович on 31.07.2021.
//

import Foundation

protocol IForecastTabPresenter
{
	func didLoad(vc: IForecastTabViewController,
				 ui: IForecastTabView)

	func willAppear()
}

class ForecastTabPresenter
{
	private weak var ui: IForecastTabView?
	private var interactor: IForecastTabInteractor
	private let alertProvider: IAlertProvider

	init(interactor: IForecastTabInteractor,
		 alertProvider: IAlertProvider) {
		self.interactor = interactor
		self.alertProvider = alertProvider
	}
}

extension ForecastTabPresenter: IForecastTabPresenter
{
	func didLoad(vc: IForecastTabViewController, ui: IForecastTabView) {
		self.ui = ui
		ui.delegate = self

		loadForecast()
	}

	func willAppear() {
		if interactor.items.count == 0 {
			loadForecast()
		}
	}
}

extension ForecastTabPresenter: IForecastTabViewDelegate
{
	func willShow(cell: IForecastTabCell, index: Int) {
		cell.set(data: interactor.items[index])
	}

	func numberOfRows() -> Int {
		return interactor.items.count
	}
}

private extension ForecastTabPresenter
{
	func loadForecast() {
		interactor.getForecast { [weak self] error in
			if let error = error {
				self?.alertProvider.showAlert(with: error.localizedDescription, title: nil)
			}
			self?.ui?.reloadData()
		}
	}
}
