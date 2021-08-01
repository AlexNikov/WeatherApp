//
//  UserDefaultsStorage.swift
//  WeatherApp
//
//  Created by Алексей Молокович on 01.08.2021.
//

import Foundation

protocol IUserDefaultsStorage: AnyObject
{
	func object<T>(forKey key: StorageKey) -> T? where T: Decodable

	func set<T>(_ value: T?, forKey key: StorageKey) where T: Encodable

	func removeObject(forKey key: StorageKey)

	func removeAll()
}

class UserDefaultsStorage
{
	private let userDefaults = UserDefaults.standard
}

extension UserDefaultsStorage: IUserDefaultsStorage
{
	func object<T>(forKey key: StorageKey) -> T? where T: Decodable {
		guard let data = self.userDefaults.object(forKey: key.rawValue) as? Data else {
			return self.userDefaults.object(forKey: key.rawValue) as? T
		}
		do {
			let object = try JSONDecoder().decode(T.self, from: data)
			return object
		}
		catch {
			return nil
		}
	}

	func set<T>(_ value: T?, forKey key: StorageKey) where T: Encodable {
		do {
			let data = try JSONEncoder().encode(value)
			self.set(object: data, forKey: key.rawValue)
		}
		catch {
			self.set(object: value, forKey: key.rawValue)
		}
	}

	func removeObject(forKey key: StorageKey) {
		self.userDefaults.removeObject(forKey: key.rawValue)
		self.userDefaults.synchronize()
	}

	func removeAll() {
		guard let appDomain = Bundle.main.bundleIdentifier else { return }
		self.userDefaults.removePersistentDomain(forName: appDomain)
		self.userDefaults.synchronize()
	}
}

extension UserDefaultsStorage
{
	func object(key stringKey: String) -> Any? {
		return self.userDefaults.object(forKey: stringKey)
	}

	func set(object value: Any?, forKey stringKey: String) {
		self.userDefaults.setValue(value, forKey: stringKey)
		self.userDefaults.synchronize()
	}
}
