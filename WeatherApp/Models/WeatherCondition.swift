//
//  WeatherCondition.swift
//  WeatherApp
//
//  Created by Алексей Молокович on 31.07.2021.
//

import Foundation

enum WeatherCondition: String {
	case sunny = "Sunny"
	case partlyCloudy = "Partly cloudy"
	case cloudy = "Cloudy"
	case mist = "Mist"
	case snow = "Snow"
	case freezingRain = "Freezing rain"
	case heavyRain = "Heavy rain"
	case partlyCloudyRain = "Partly cloudy with rain"
	case lightRain = "Light rain"
	case thunderstorm = "Thunderstorm"

	var textualRepresentation: String {
		switch self {
		case .sunny:
			return NSLocalizedString("Sunny", comment: "Sunny weather condition")
		case .partlyCloudy:
			return NSLocalizedString("Partly cloudy", comment: "Partly cloudy weather condition")
		case .cloudy:
			return NSLocalizedString("Cloudy", comment: "Cloudy weather condition")
		case .mist:
			return NSLocalizedString("Mist", comment: "Mist weather condition")
		case .snow:
			return NSLocalizedString("Snow", comment: "Snow weather condition")
		case .freezingRain:
			return NSLocalizedString("Freezing rain", comment: "Freezing rain weather condition")
		case .heavyRain:
			return NSLocalizedString("Heavy rain", comment: "Heavy rain weather condition")
		case .partlyCloudyRain:
			return NSLocalizedString("Partly cloudy with rain", comment: "Partly cloudy with rain weather condition")
		case .lightRain:
			return NSLocalizedString("Light rain", comment: "Light rain weather condition")
		case .thunderstorm:
			return NSLocalizedString("Thunderstorm", comment: "Thunderstorm weather condition")
		}
	}

	var icon: IconAssets {
		switch self {
		case .sunny: return .sunny
		case .partlyCloudy: return .clearCloudy
		case .cloudy: return .cloudy
		case .mist: return .foggy
		case .snow: return .snow
		case .freezingRain: return .hail
		case .heavyRain: return .sleet
		case .partlyCloudyRain: return .drizzle
		case .lightRain: return .showers
		case .thunderstorm: return .thunderstroms
		}
	}
}
