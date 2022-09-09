//
//  URLExtension.swift
//  GoodWeather
//
//  Created by Tiến Trần on 09/09/2022.
//  Copyright © 2022 Mohammad Azam. All rights reserved.
//

import Foundation

extension URL {
    static func urlForWeatherAPI(city: String) -> URL?  {
        return URL(string: "api.openweathermap.org/data/2.5/weather?q=\(city)&appid=2ec7db1e1687f7afadcbd3640852bb60&units=imperial")
    }
}

//ec97852abf7396636dbad00c15b2bb93
