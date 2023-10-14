//
//  Encodable+Extension.swift
//  WeatherApp
//
//  Created by Алексей Молокович on 14.10.2023.
//

import Foundation

extension Encodable {
    var dictionary: [ String: Any] {
        (try? JSONSerialization.jsonObject(
            with: JSONEncoder.snakeCase.encode(self)
        )) as? [String: Any] ?? [:]
    }
}
