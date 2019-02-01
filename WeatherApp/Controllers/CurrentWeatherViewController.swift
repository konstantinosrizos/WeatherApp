//
//  CurrentWeatherViewController.swift
//  WeatherApp
//
//  Created by Konstantinos Rizos on 30/01/2019.
//  Copyright © 2019 Konstantinos Rizos. All rights reserved.
//

import UIKit

class CurrentWeatherViewController: UIViewController {

    @IBOutlet weak var cityTextLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var summary: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    
    let forecastAPIKey = "12b8080b0933f237c5f0bcafe090b084"
    let coordinate: (lat: Double, long: Double) = (38.005460,23.681471)
    var forecastService: ForecastService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        forecastService = ForecastService(APIKey: forecastAPIKey)
        forecastService.getCurrentWeather(latitude: coordinate.lat, longitude: coordinate.long) { (currentWeather) in
            if let currentWeather = currentWeather {
                DispatchQueue.main.async {
                    // Temperature
                    if let temperature = currentWeather.temperature {
                        self.temperatureLabel.text = "\(temperature)"
                    } else {
                        self.temperatureLabel.text = "***"
                    }
                    // Summary
                    if let summaryTemp = currentWeather.summary {
                        self.summary.text = "\(summaryTemp)"
                    } else {
                        self.summary.text = "***"
                    }
                    // Weather Icon
                    if let weatherIcon = currentWeather.icon {
                        self.weatherIcon.image = UIImage(named: "\(weatherIcon)")
                    } else {
                        self.weatherIcon.image = UIImage(named: "***")
                    }
                }
            }
        }
    }
}
