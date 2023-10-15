//
//  String+Extension.swift
//  WeatherApp
//
//  Created by Алексей Молокович on 15.10.2023.
//

import Foundation


extension String {
    var utf8: Data? {
        self.data(using: String.Encoding.utf8)
    }
}
