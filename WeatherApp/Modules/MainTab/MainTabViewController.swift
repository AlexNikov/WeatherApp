//
//  MainTabViewController.swift
//  WeatherApp
//
//  Created by Алексей Молокович on 31.07.2021.
//

import UIKit

protocol IMainTabViewController: AnyObject
{
	var tapSettingHandler: (() -> Void)? { get set }
}

class MainTabViewController: UIViewController, IMainTabViewController
{

	var tapSettingHandler: (() -> Void)?

	private let presenter: IMainTabPresenter
	private let alertProvider: IAlertProvider

	init(presenter: IMainTabPresenter,
		 alertProvider: IAlertProvider) {
		self.presenter = presenter
		self.alertProvider = alertProvider
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func loadView() {
		view = MainTabView()
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		guard let mainTabView = view as? IMainTabView else { return }

		presenter.didLoad(vc: self, ui: mainTabView )
		configureNavigationBar()
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

		alertProvider.set(viewController: self)
	}

	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)

		alertProvider.set(viewController: nil)
	}
}

private extension MainTabViewController
{
	func configureNavigationBar() {
		let settingItem = UIBarButtonItem(barButtonSystemItem: .add,
										  target: self,
										  action: #selector(tapSettingButton))
		navigationItem.rightBarButtonItem = settingItem
	}

	@objc
	func tapSettingButton() {
		tapSettingHandler?()
	}
}
