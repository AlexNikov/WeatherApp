//
//  WeatherItemDecorator.swift
//  WeatherApp
//
//  Created by Алексей Молокович on 01.08.2021.
//

import Foundation

protocol IWeatherItemDecorator: AnyObject
{
	var response: WeatherItemResponse { get }
	var temperatureFormated: String? { get }
	var dateFormated: String? { get }
	var weatherCondition: WeatherCondition { get }
}

final class WeatherItemDecorator: IWeatherItemDecorator
{
	let response: WeatherItemResponse
	private let degreeString = "\u{00B0}"

	private static let temperatureFormatter: NumberFormatter = {
		let formatter = NumberFormatter()
		formatter.numberStyle = .decimal
		formatter.maximumFractionDigits = 1
		formatter.roundingMode = .halfUp
		return formatter
	}()

	private static let dateFormatter: DateFormatter = {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "dd.MM.yyyy"
		return dateFormatter
	}()

	init(response: WeatherItemResponse) {
		self.response = response
	}

	var dateFormated: String? {
		WeatherItemDecorator.dateFormatter.string(from: response.date)
	}

	var weatherCondition: WeatherCondition {
		switch response.weatherId {
		case 801:
			return .partlyCloudy
		case 802...900:
			return .cloudy
		case 700..<800:
			return .mist
		case 600..<700:
			return .snow
		case 520..<600:
			return .partlyCloudyRain
		case 511:
			return .freezingRain
		case 500...504:
			return .heavyRain
		case 300..<500:
			return .lightRain
		case 200..<300:
			return .thunderstorm
		default:
			return .sunny
		}
	}

	var temperatureFormated: String? {
		WeatherItemDecorator.temperatureFormatter.maximumFractionDigits = 0

		guard let formattedString = WeatherItemDecorator.temperatureFormatter.string(
			from: NSNumber(value: response.temperature)
		)
		else {
			Logger.error("Невозможно распарсить температуру")

			return nil
		}

		return [formattedString, "C"].joined(separator: degreeString)
	}
}
