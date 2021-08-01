//
//  ForecastTabViewController.swift
//  WeatherApp
//
//  Created by Алексей Молокович on 31.07.2021.
//

import UIKit

protocol IForecastTabViewController
{

}

class ForecastTabViewController: UIViewController, IForecastTabViewController
{
	private let presenter: IForecastTabPresenter
	private let alertProvider: IAlertProvider

	init(presenter: IForecastTabPresenter,
		 alertProvider: IAlertProvider) {
		self.presenter = presenter
		self.alertProvider = alertProvider
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func loadView() {
		view = ForecastTabView()
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		guard let ui = view as? IForecastTabView else { return }
		presenter.didLoad(vc: self, ui: ui)
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

		presenter.willAppear()
		alertProvider.set(viewController: self)
	}

	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)

		alertProvider.set(viewController: nil)
	}
}
