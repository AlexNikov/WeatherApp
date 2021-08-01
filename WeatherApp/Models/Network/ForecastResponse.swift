//
//  ForecastResponse.swift
//  WeatherApp
//
//  Created by Алексей Молокович on 01.08.2021.
//

import Foundation

struct WeatherItemResponse: Decodable
{
	let weatherId: Int
	let temperature: Double
	let date: Date

	private enum RootKeys: String, CodingKey {
		case main, weather, name, coord, dt
	}
	private enum APIKeys: String, CodingKey {
		case temperature = "temp"
	}

	private enum WeatherKeys: String, CodingKey {
		case id
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: RootKeys.self)
		temperature = try container.nestedContainer(keyedBy: APIKeys.self, forKey: .main)
			.decode(Double.self, forKey: .temperature)

		var weatherContainer = try container.nestedUnkeyedContainer(forKey: .weather)
		let weatherChildContainer = try weatherContainer.nestedContainer(keyedBy: WeatherKeys.self)
		weatherId = try weatherChildContainer.decode(Int.self, forKey: .id)

		date = try container.decode(Date.self, forKey: .dt)
	}
}

struct ForecastResponse: Decodable
{
	let list: [WeatherItemResponse]

	private enum RootKeys: String, CodingKey {
		case list
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: RootKeys.self)
		list = try container.decode([WeatherItemResponse].self, forKey: .list)
	}
}
