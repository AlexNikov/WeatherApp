//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Алексей Молокович on 31.07.2021.
//

import Foundation

protocol INetworkManager: AnyObject
{
	func getRequest<R: Decodable>(queryItems: [String: String],
								  url: String,
								  completion: @escaping (Result<R, NetError>) -> Void)
}

enum NetError: Swift.Error
{
	case unableToConstructUrl
	case network(Swift.Error)
	case http(Int)
	case invalidResponse
	case format(Swift.Error)
}

class NetworkManager {
	enum ParametersType: String
	{
		case appid
		case lang
		case units

		var value: String {
			switch self {
			case .appid: return "01a0cda4988c1f69cc1b996ef4b4fe28"
			case .lang: return Locale.preferredLanguages[0]
			case .units: return "metric"
			}
		}
	}

	private enum API {
		static let baseURL = "https://api.openweathermap.org/data/2.5/"
	}

	typealias JSONDictionary = [String : Any]
	typealias JSONArray = [Any]

	lazy var defaultSession: URLSession = {
		let config = URLSessionConfiguration.default
		config.httpAdditionalHeaders = ["Content-Type":"application/json"]
		return URLSession(configuration: config, delegate: nil, delegateQueue: nil)
	}()
}

extension NetworkManager: INetworkManager
{
	func getRequest<R: Decodable>(queryItems: [String : String],
								  url: String,
								  completion: @escaping (Result<R, NetError>) -> Void) {

		var urlQueryItems = queryItems.map{ URLQueryItem(name: $0, value: $1) }
		urlQueryItems.append(URLQueryItem(name: ParametersType.appid.rawValue,
										  value: ParametersType.appid.value))
		urlQueryItems.append(URLQueryItem(name: ParametersType.units.rawValue,
										  value: ParametersType.units.value))

		var urlComps = URLComponents(string: "\(API.baseURL)\(url)")
		urlComps?.queryItems = urlQueryItems
		guard let url = urlComps?.url else {
			completion(.failure(.unableToConstructUrl))
			return
		}

		let urlRequest = URLRequest(url: url)

		URLSession.shared
			.dataTask(with: urlRequest) { data, urlResponse, error in
				if let error = error {
					completion(.failure(NetError.network(error)))
					return
				}

				if let httpURLResponse = urlResponse as? HTTPURLResponse,
				   httpURLResponse.statusCode < 200 || httpURLResponse.statusCode >= 300
				{
					completion(.failure(NetError.http(httpURLResponse.statusCode)))
					return
				}

				guard let data = data else {
					completion(.failure(NetError.invalidResponse))
					return
				}

				do {
					let jsonDecoder = JSONDecoder()
					jsonDecoder.dateDecodingStrategy = .secondsSince1970
					let result = try jsonDecoder.decode(R.self, from: data)

					DispatchQueue.main.async {
						completion(.success(result))
					}

				} catch {
					completion(.failure(NetError.format(error)))
				}
			}
			.resume()
	}
}
