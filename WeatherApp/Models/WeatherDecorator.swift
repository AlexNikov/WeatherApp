//
//  WeatherDecorator.swift
//  WeatherApp
//
//  Created by Алексей Молокович on 01.08.2021.
//

import Foundation

protocol IWeatherDecorator: AnyObject
{
	var response: WeatherResponse { get }
	var temperatureFormated: String? { get }
	var weatherCondition: WeatherCondition { get }
}

final class WeatherDecorator: IWeatherDecorator
{

	let response: WeatherResponse
	private let degreeString = "\u{00B0}"

	private static let temperatureFormatter: NumberFormatter = {
		let formatter = NumberFormatter()
		formatter.numberStyle = .decimal
		formatter.maximumFractionDigits = 1
		formatter.roundingMode = .halfUp
		return formatter
	}()

	init(response: WeatherResponse) {
		self.response = response
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
		WeatherDecorator.temperatureFormatter.maximumFractionDigits = 0

		guard let formattedString = WeatherDecorator.temperatureFormatter.string(
			from: NSNumber(value: response.temperature)
		)
		else {
			Logger.error("Невозможно распарсить температуру")

			return nil
		}

		return [formattedString, "C"].joined(separator: degreeString)
	}
}
