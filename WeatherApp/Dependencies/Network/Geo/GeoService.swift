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
    private lazy var provider: MoyaProvider<GeoRouter> = {
        if CommandLine.isUITesting {
            return MoyaProvider<GeoRouter>(stubClosure: MoyaProvider.immediatelyStub)
        }
        return MoyaProvider<GeoRouter>()
    }()

    func getCity(with params: GeoRequestParameters) -> Observable<[GeoResponse]> {
        provider.rx
            .request(.city(params))
            .map([GeoResponse].self)
            .asObservable()
    }
}
