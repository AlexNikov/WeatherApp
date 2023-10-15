//
//  CommandLine.swift
//  WeatherApp
//
//  Created by Алексей Молокович on 15.10.2023.
//

import Foundation

extension CommandLine {
    static let uiTesting = "testing"

    static var isUITesting: Bool {
        CommandLine.arguments.contains(uiTesting)
    }
}
