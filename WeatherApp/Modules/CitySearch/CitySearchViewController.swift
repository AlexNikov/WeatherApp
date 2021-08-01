//
//  CitySearchViewController.swift
//  WeatherApp
//
//  Created by Алексей Молокович on 31.07.2021.
//

import GooglePlaces
import UIKit

class CitySearchViewController: GMSAutocompleteViewController {

	var updateCityHandler: MainTabUpdateCityCompletion?

	override func viewDidLoad() {
		super.viewDidLoad()

		delegate = self

		let fields: GMSPlaceField = GMSPlaceField(rawValue: UInt(GMSPlaceField.name.rawValue) |
													UInt(GMSPlaceField.coordinate.rawValue))
		placeFields = fields

		let filter = GMSAutocompleteFilter()
		filter.type = .city
		autocompleteFilter = filter
	}
}

extension CitySearchViewController: GMSAutocompleteViewControllerDelegate {
	// Handle the user's selection.
	func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
		let cityInfo = CityInfo(name: place.name,
								location: Location(longitude: place.coordinate.longitude,
												   latitude: place.coordinate.latitude))
		updateCityHandler?(cityInfo)
		dismiss(animated: true, completion: nil)
	}

	func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
		Logger.error(error.localizedDescription)
		dismiss(animated: true, completion: nil)
	}

	func wasCancelled(_ viewController: GMSAutocompleteViewController) {
		dismiss(animated: true, completion: nil)
	}

	func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
		UIApplication.shared.isNetworkActivityIndicatorVisible = true
	}

	func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
		UIApplication.shared.isNetworkActivityIndicatorVisible = false
	}
}
