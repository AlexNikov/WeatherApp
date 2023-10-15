//
//  BaseTarget.swift
//  WeatherApp
//
//  Created by Алексей Молокович on 14.10.2023.
//

import Moya

protocol BaseTarget: TargetType {
    var api: String { get }
}

extension BaseTarget {
    var api: String {
        "a06c8c7b508541390312adeece82c917"
    }
}

