//
//  WeatherItem.swift
//  WeatherApp
//
//  Created by Алексей Молокович on 01.08.2021.
//

import Foundation

struct WeatherItem: Codable
{
	let date: String
	let icon: IconAssets
	let temperature: String
}
