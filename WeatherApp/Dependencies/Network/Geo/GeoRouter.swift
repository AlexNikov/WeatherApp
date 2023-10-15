//
//  WeatherProvider.swift
//  WeatherApp
//
//  Created by Алексей Молокович on 14.10.2023.
//

import Moya
import Foundation

enum GeoRouter: BaseTarget {

    case city(GeoRequestParameters)

    var baseURL: URL {
        return URL(string: "http://api.openweathermap.org/geo/1.0/")!
    }

    var path: String {
        switch self {
        case .city:
            return "direct"
        }
    }

    var method: Moya.Method {
        switch self {
        case .city:
            return .get
        }
    }


    var task: Task {
        switch self {
        case .city(let params):
            var parameters = params.dictionary
            parameters["appid"] = api
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }

    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }

    var sampleData: Data {
        switch self {
        case .city(let params):
            let json = "\(self.path)?q=\(params.q)"
            guard let url = Bundle.main.url(forResource: json, withExtension: "json"),
                  let data = try? Data(contentsOf: url) else {
                return Data()
            }
            return data
        }
    }
}
