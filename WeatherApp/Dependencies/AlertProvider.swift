//
//  AlertProvider.swift
//  WeatherApp
//
//  Created by Алексей Молокович on 01.08.2021.
//

import UIKit

protocol IAlertProvider
{
	func showAlert(with message: String, title: String?)
	func showAlert(with message: String,
				   title: String?,
				   secondButtonTitle: String,
				   action: @escaping () -> Void )

	func set(viewController: UIViewController?)
}

class AlertProvider: IAlertProvider
{
	private weak var viewController: UIViewController?

	func set(viewController: UIViewController?) {
		self.viewController = viewController
	}

	func showAlert(with message: String, title: String? = nil) {
		let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
		alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))

		show(alertController)
	}

	func showAlert(with message: String, title: String? = nil, secondButtonTitle: String, action: @escaping () -> Void ) {
		let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
		alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
		alertController.addAction(UIAlertAction(title: secondButtonTitle,
												style: UIAlertAction.Style.default,
												handler: { _ in
													action()
												}))
		show(alertController)

	}

	func show(_ alertController: UIAlertController) {
		DispatchQueue.main.async { [weak self] in
			if let vc = self?.viewController {
				vc.present(alertController, animated: true, completion: nil)
			}
			else {
				UIApplication.shared.keyWindow?.rootViewController?.present(
					alertController, animated: true, completion: nil
				)
			}
		}
	}
}
