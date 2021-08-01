//
//  WeatherResponse.swift
//  WeatherApp
//
//  Created by Алексей Молокович on 31.07.2021.
//

struct WeatherResponse: Decodable {

	let temperature: Double
	let name: String
	let weatherId: Int
	let lon: Double
	let lat: Double

	private enum RootKeys: String, CodingKey {
		case main, weather, name, coord
	}
	private enum APIKeys: String, CodingKey {
		case temperature = "temp"
		case lon, lat
	}
	private enum WeatherKeys: String, CodingKey {
		case id
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: RootKeys.self)
		temperature = try container.nestedContainer(keyedBy: APIKeys.self, forKey: .main)
			.decode(Double.self, forKey: .temperature)
		name = try container.decode(String.self, forKey: .name)
		lon = try container.nestedContainer(keyedBy: APIKeys.self, forKey: .coord)
			.decode(Double.self, forKey: .lon)
		lat = try container.nestedContainer(keyedBy: APIKeys.self, forKey: .coord)
			.decode(Double.self, forKey: .lat)

		var weatherContainer = try container.nestedUnkeyedContainer(forKey: .weather)
		let weatherChildContainer = try weatherContainer.nestedContainer(keyedBy: WeatherKeys.self)
		weatherId = try weatherChildContainer.decode(Int.self, forKey: .id)
	}
}
