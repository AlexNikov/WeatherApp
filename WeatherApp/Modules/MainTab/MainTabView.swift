//
//  MainTabView.swift
//  WeatherApp
//
//  Created by Алексей Молокович on 31.07.2021.
//

import UIKit

protocol IMainTabView: AnyObject
{
	func set(cityName: String)
	func set(hint: String,
			 temperature: String,
			 icon: IconAssets)
}

class MainTabView: UIView
{
	private lazy var weatherIconImageView = UIImageView()
	private lazy var cityNameLabel = UILabel()
	private lazy var hintLabel = UILabel()
	private lazy var temperatureLabel = UILabel()

	override init(frame: CGRect) {
		super.init(frame: frame)
		configureView()
	}

	@available(*, unavailable)
	public required init(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension MainTabView: IMainTabView
{
	func set(cityName: String) {
		cityNameLabel.text = cityName
        cityNameLabel.accessibilityIdentifier = MainTabAccessibility.cityNameLabel.rawValue
	}

	func set(hint: String,
			 temperature: String,
			 icon: IconAssets) {
		hintLabel.text = hint
		weatherIconImageView.image = icon.image
		temperatureLabel.text = temperature
	}
}

private extension MainTabView
{
	func configureView() {
		backgroundColor = .white

		addSubview(weatherIconImageView)
		addSubview(cityNameLabel)
		addSubview(hintLabel)
		addSubview(temperatureLabel)

		cityNameLabel.translatesAutoresizingMaskIntoConstraints = false
		cityNameLabel.textAlignment = .center
		cityNameLabel.font = AppFont.title1Header.font
		NSLayoutConstraint.activate([
			cityNameLabel.topAnchor.constraint(equalTo: topAnchor,
													  constant: 100),
			cityNameLabel.leftAnchor.constraint(equalTo: leftAnchor),
			cityNameLabel.rightAnchor.constraint(equalTo: rightAnchor),
			cityNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
		])

		weatherIconImageView.contentMode = .scaleAspectFit
		weatherIconImageView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			weatherIconImageView.topAnchor.constraint(equalTo: cityNameLabel.bottomAnchor,
														   constant: 50),
			weatherIconImageView.widthAnchor.constraint(equalToConstant: 100),
			weatherIconImageView.heightAnchor.constraint(equalToConstant: 100),
			weatherIconImageView.centerXAnchor.constraint(equalTo: centerXAnchor)
		])

		temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
		temperatureLabel.textAlignment = .center
		temperatureLabel.font = AppFont.title2Text.font
		NSLayoutConstraint.activate([
			temperatureLabel.topAnchor.constraint(equalTo: weatherIconImageView.bottomAnchor,
											   constant: 16),
			temperatureLabel.leftAnchor.constraint(equalTo: leftAnchor),
			temperatureLabel.rightAnchor.constraint(equalTo: rightAnchor),
			temperatureLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
		])

		hintLabel.translatesAutoresizingMaskIntoConstraints = false
		hintLabel.textAlignment = .center
		hintLabel.font = AppFont.bodyText.font
		NSLayoutConstraint.activate([
			hintLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor,
												  constant: 16),
			hintLabel.leftAnchor.constraint(equalTo: leftAnchor),
			hintLabel.rightAnchor.constraint(equalTo: rightAnchor),
			hintLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
		])
	}
}
