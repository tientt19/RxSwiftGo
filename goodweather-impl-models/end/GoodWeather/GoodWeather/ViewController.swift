//
//  ViewController.swift
//  GoodWeather
//
//  Created by Mohammad Azam on 3/6/19.
//  Copyright © 2019 Mohammad Azam. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    
    @IBOutlet weak var cityNameTextField: UITextField!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.cityNameTextField.rx.controlEvent(.editingDidEndOnExit)
            .asObservable()
            .map { self.cityNameTextField.text }
            .subscribe(onNext: { city in
                if let city = city {
                    if city.isEmpty {
                        self.displayWeather(nil)
                    } else {
                        self.fetchWeather(by: city)
                    }
                }
            }).disposed(by: disposeBag)
    }
}


extension ViewController {
    private func displayWeather(_ weather: Weather?) {
        if let weather = weather {
            self.temperatureLabel.text = "\(weather.temp) 🌡"
            self.humidityLabel.text = "\(weather.humidity) 💦"
        } else {
            self.temperatureLabel.text = "👮🏽"
            self.humidityLabel.text = "👴🏿"
        }
    }
}

extension ViewController {
    private func fetchWeather(by city: String) {
        guard let cityEncoded = city.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
        let url = URL.urlForWeatherAPI(city: cityEncoded) else { return }
        let resource = Resource<WeatherResult?>(url: url)
        
//        let search = URLRequest.load(resource: resource)
//            .observe(on: MainScheduler.instance)
//            .asDriver(onErrorJustReturn: WeatherResult.empty)
        
        
        
//            .catchAndReturn(WeatherResult.empty)
//            .subscribe(onNext: { result in
//                let weather = result?.main
//                self.displayWeather(weather)
//            }).disposed(by: disposeBag)
//
//        search.map { "\($0?.main.temp) 🌡" }
//            .bind(to: self.temperatureLabel.rx.text)
//            .disposed(by: disposeBag)
//
//        search.map { "\($0?.main.humidity) 💦" }
//            .bind(to: self.humidityLabel.rx.text)
//            .disposed(by: disposeBag)
        
        let search = URLRequest.load(resource: resource)
            .observe(on: MainScheduler.instance)
            .retry(3)
            .catch { error in
                print(error.localizedDescription)
                return Observable.just(WeatherResult.empty)
            }.asDriver(onErrorJustReturn: WeatherResult.empty)
        
        search.map { "\($0?.main.temp) 🌡" }
            .drive(self.temperatureLabel.rx.text)
            .disposed(by: disposeBag)
        
        search.map { "\($0?.main.humidity) 💦" }
            .drive(self.humidityLabel.rx.text)
            .disposed(by: disposeBag)
    }
}
