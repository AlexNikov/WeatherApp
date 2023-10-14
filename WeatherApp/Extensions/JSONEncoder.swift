//
//  JSONEncoder.swift
//  WeatherApp
//
//  Created by Алексей Молокович on 14.10.2023.
//

import Foundation

extension JSONEncoder {
    static let snakeCase: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }()
}
