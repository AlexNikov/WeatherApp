//
//  GeoService.swift
//  WeatherApp
//
//  Created by Алексей Молокович on 14.10.2023.
//

import Foundation
import RxSwift
import Moya
import RxMoya

final class GeoService {
    private let provider = MoyaProvider<GeoRouter>()

    func getCity(with params: GeoRequestParameters) -> Observable<[GeoResponse]> {
        provider.rx
            .request(.city(params))
            .map([GeoResponse].self)
            .asObservable()
    }
}
