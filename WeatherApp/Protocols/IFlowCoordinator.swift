//
//  ICoordinator.swift
//  WeatherApp
//
//  Created by Алексей Молокович on 30.07.2021.
//

protocol ICoordinator: AnyObject
{
	func start(endFlowCompletion: (() -> Void)?)
}
