//
//  URLRequest.swift
//  GoodWeather
//
//  Created by Tiến Trần on 09/09/2022.
//  Copyright © 2022 Mohammad Azam. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import RxRelay

struct Resource<T> {
    let url: URL
}

extension URLRequest {
    static func load<T: Decodable>(resource: Resource<T>) -> Observable<T> {
        return Observable.from([resource.url])
            .flatMap { url -> Observable<Data> in
                let request = URLRequest(url: url)
                return URLSession.shared.rx.data(request: request)
            }.map { data -> T in
                return try JSONDecoder().decode(T.self, from: data)
            }.asObservable()
    }
}

