//
//  GeoResponse.swift
//  WeatherApp
//
//  Created by Алексей Молокович on 14.10.2023.
//

struct GeoResponse: Codable {
    let name: String?
    let localNames: LocalNames?
    let lat, lon: Double?
    let country, state: String?

    enum CodingKeys: String, CodingKey {
        case name
        case localNames = "local_names"
        case lat, lon, country, state
    }
}

// MARK: - LocalNames
struct LocalNames: Codable {
    let en, ru: String?
}
