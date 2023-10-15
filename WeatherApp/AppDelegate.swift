//
//  AppDelegate.swift
//  WeatherApp
//
//  Created by Алексей Молокович on 30.07.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	lazy var dependencyContainer = DependencyContainer()
	lazy var moduleFactory = ModuleFactory(dependencyContainer: dependencyContainer)
	lazy var coordinatorFactory = CoordinatorFactory(moduleFactory: moduleFactory)
	lazy var rootCoordinator: RootCoordinator = coordinatorFactory.make(
		navigationController: UINavigationController()
	)

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

		window = UIWindow()
		window?.rootViewController = rootCoordinator.navigationController
		rootCoordinator.start()
		window?.makeKeyAndVisible()

        if CommandLine.isUITesting {
            UIView.setAnimationsEnabled(false)
        }

		return true
	}
}

