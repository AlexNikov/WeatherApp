//
//  ForecastTabCell.swift
//  WeatherApp
//
//  Created by Алексей Молокович on 01.08.2021.
//

import UIKit

protocol IForecastTabCell
{
	func set(data: WeatherItem)
}

class ForecastTabCell: UITableViewCell
{
	private lazy var weatherIconImageView = UIImageView()
	private lazy var temperatureLabel = UILabel()
	private lazy var dateLabel = UILabel()


	@available(*, unavailable)
	public init() { fatalError() }

	@available(*, unavailable)
	public init(frame: CGRect) { fatalError() }

	@available(*, unavailable)
	public required init?(coder aDecoder: NSCoder) { fatalError() }

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
	{
		super.init(style: style, reuseIdentifier: reuseIdentifier)

		self.backgroundColor = .white
		self.preservesSuperviewLayoutMargins = false
		self.separatorInset = UIEdgeInsets.zero
		self.layoutMargins = UIEdgeInsets.zero
		self.selectionStyle = .none

		configureView()
	}
}

extension ForecastTabCell: IForecastTabCell
{
	func set(data: WeatherItem) {
		weatherIconImageView.image = data.icon.image
		dateLabel.text = data.date
		temperatureLabel.text = data.temperature
	}
}

private extension ForecastTabCell
{
	func configureView() {
		addSubview(weatherIconImageView)
		addSubview(temperatureLabel)
		addSubview(dateLabel)

		dateLabel.translatesAutoresizingMaskIntoConstraints = false
		dateLabel.textAlignment = .left
		dateLabel.font = AppFont.bodyText.font
		NSLayoutConstraint.activate([
			dateLabel.leftAnchor.constraint(equalTo: leftAnchor),
			dateLabel.rightAnchor.constraint(equalTo: weatherIconImageView.leftAnchor),
			dateLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
		])

		weatherIconImageView.translatesAutoresizingMaskIntoConstraints = false
		weatherIconImageView.contentMode = .scaleAspectFit
		NSLayoutConstraint.activate([
			weatherIconImageView.rightAnchor.constraint(equalTo: temperatureLabel.leftAnchor),
			weatherIconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
			weatherIconImageView.widthAnchor.constraint(equalToConstant: 32),
			weatherIconImageView.heightAnchor.constraint(equalToConstant: 32),

		])

		temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
		temperatureLabel.textAlignment = .right
		temperatureLabel.font = AppFont.bodyText.font
		NSLayoutConstraint.activate([
			temperatureLabel.rightAnchor.constraint(equalTo: rightAnchor),
			temperatureLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
			temperatureLabel.widthAnchor.constraint(equalToConstant: 40),
		])
	}
}
