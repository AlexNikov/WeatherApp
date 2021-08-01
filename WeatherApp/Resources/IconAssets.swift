//
//  IconAssets.swift
//  WeatherApp
//
//  Created by Алексей Молокович on 31.07.2021.
//

import UIKit

enum IconAssets: String, Codable
{
	case hail
	case drizzle
	case showers
	case foggy
	case tornado
	case thunderstroms
	case isolatedThunderstroms
	case snowFlurries
	case sleet
	case snow
	case windy
	case cloudy
	case mostlyCloudy
	case partlyCloudy
	case clearCloudy
	case cold
	case hot
	case sunny
	case home
	case menuHamburger

	var image: UIImage {
		UIImage(imageLiteralResourceName: rawValue)
	}
}
