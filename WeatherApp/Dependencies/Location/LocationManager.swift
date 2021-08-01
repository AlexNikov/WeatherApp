//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Алексей Молокович on 01.08.2021.
//

import CoreLocation
import UIKit

enum LocationNotifierType
{
	case update(Location)
	case changeStatus(CLAuthorizationStatus)
	case failure(Error)
	case willEnterForeground
}
protocol ILocationManagerDelegate: AnyObject
{
	func didUpdate(with notifire: LocationNotifierType)
}

protocol ILocationManager
{
	var authorizationStatus: CLAuthorizationStatus { get }
	var delegate: ILocationManagerDelegate? { get set}

	func settingsUrl() -> URL?
	func requestAuthorization()
	func startUpdatingLocation()
	func stopUpdatingLocation()
}

class LocationManager: NSObject
{
	weak var delegate: ILocationManagerDelegate?

	var authorizationStatus: CLAuthorizationStatus {
		CLLocationManager.authorizationStatus()
	}

	private(set) var lastLocation: CLLocation?
	private(set) var isStarted = false

	private let desiredAccuracy: CLLocationAccuracy = kCLLocationAccuracyKilometer
	private let locationManager = CLLocationManager()

	override init() {
		super.init()

		configureLocationManager()

		NotificationCenter.default.addObserver(self,
											   selector: #selector(applicationWillEnterForeground(_:)),
											   name: UIApplication.willEnterForegroundNotification,
											   object: nil)
	}

	deinit {
		//можно и не делать
		NotificationCenter.default.removeObserver(self)
	}
}

extension LocationManager: ILocationManager
{
	func startUpdatingLocation() {
		guard isStarted == false else { return }

		isStarted = true

		switch self.authorizationStatus {
		case .notDetermined,
			 .restricted,
			 .denied:
			sendNoAccessError()
		case .authorizedAlways,
			 .authorizedWhenInUse:
			startLocationManager()
		@unknown default:
			Logger.error("")
			sendNoAccessError()
		}
	}

	func stopUpdatingLocation() {
		locationManager.stopUpdatingLocation()
		locationManager.delegate = nil
		isStarted = false
	}

	func requestAuthorization() {
		if authorizationStatus == .notDetermined {
			locationManager.requestWhenInUseAuthorization()
		}
	}

	func settingsUrl() -> URL? {
		return URL(string: UIApplication.openSettingsURLString)
	}
}

extension LocationManager: CLLocationManagerDelegate
{
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		guard let coordinate = locations.first?.coordinate else {
			Logger.error("нет координат")
			return
		}
		delegate?.didUpdate(with: .update(Location(longitude: coordinate.longitude,
												   latitude: coordinate.latitude)))
	}

	func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
		delegate?.didUpdate(with: .failure(error))
		isStarted = false
	}

	func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
		delegate?.didUpdate(with: .changeStatus(status))

		if self.isStarted {
			let isAvailabile = (status == .authorizedAlways || status == .authorizedWhenInUse)
			if isAvailabile {
				startLocationManager()
			}
			else {
				sendNoAccessError()
			}
		}
	}
}

private extension LocationManager
{
	func startLocationManager() {
		locationManager.delegate = self
		locationManager.startUpdatingLocation()
	}

	func sendNoAccessError() {
		let userInfo = [NSLocalizedDescriptionKey: "Test"]
		let error = NSError(domain: "LocationManagerErrorDomain", code: 0, userInfo: userInfo)
		Logger.error("LocationManager sendNoAccessError")
		delegate?.didUpdate(with: .failure(error))
		isStarted = false
	}

	@objc
	func applicationWillEnterForeground(_ notfication: NSNotification) {
		delegate?.didUpdate(with: .willEnterForeground)
	}

	func configureLocationManager() {
		locationManager.delegate = self
		locationManager.desiredAccuracy = desiredAccuracy
		locationManager.headingFilter = kCLHeadingFilterNone
	}
}
