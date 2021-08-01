//
//  BaseCoordinator.swift
//  WeatherApp
//
//  Created by Алексей Молокович on 31.07.2021.
//

import UIKit

class BaseCoordinator
{
	let navigationController: UINavigationController
	var completion: (() -> Void)? // для удаления из childCoordinator
	let moduleFactory: ModuleFactory
	let coordinatorFactory: CoordinatorFactory
	var childCoordinator: [ICoordinator] = []

	required init(moduleFactory: ModuleFactory,
				  coordinatorFactory: CoordinatorFactory,
				  navigationController: UINavigationController) {
		self.moduleFactory = moduleFactory
		self.navigationController = navigationController
		self.coordinatorFactory = coordinatorFactory
	}
}
