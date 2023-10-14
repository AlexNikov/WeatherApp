//
//  GeoRequestParameters.swift
//  WeatherApp
//
//  Created by Алексей Молокович on 14.10.2023.
//

struct GeoRequestParameters: Codable  {
    let q: String
    var limit: Int = 10
}
