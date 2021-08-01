//
//  IDependencyProvider.swift
//  WeatherApp
//
//  Created by Алексей Молокович on 31.07.2021.
//

protocol IDependencyProvider {
	associatedtype Value

	func get() -> Value
}
