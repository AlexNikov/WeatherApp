//
//  CoordinatorFactory.swift
//  WeatherApp
//
//  Created by Алексей Молокович on 31.07.2021.
//
import UIKit

class CoordinatorFactory
{
	private let moduleFactory: ModuleFactory

	init(moduleFactory: ModuleFactory) {
		self.moduleFactory = moduleFactory
	}

	func make<T: BaseCoordinator>(navigationController: UINavigationController) -> T {
		T(moduleFactory: moduleFactory,
		  coordinatorFactory: self,
		  navigationController: navigationController)
	}
}
