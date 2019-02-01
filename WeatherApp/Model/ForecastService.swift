//
//  ForecastService.swift
//  WeatherApp
//
//  Created by Konstantinos Rizos on 30/01/2019.
//  Copyright © 2019 Konstantinos Rizos. All rights reserved.
//

import Foundation
import Alamofire


class ForecastService {
    
    // Sample URL https://api.darksky.net/forecast/ad001d097beab3487012d683b3db23eb/37.8267,-122.4233
    
    let forecastAPIKey: String
    let forecastBaseURL: URL?
    
    init(APIKey: String) {
        self.forecastAPIKey = APIKey
        forecastBaseURL = URL(string: "https://api.darksky.net/forecast/\(APIKey)")
    }
    
    func getCurrentWeather(latitude: Double, longitude: Double, completion: @escaping (CurrentWeather?) -> Void)  {
        if let forecastURL = URL(string: "\(forecastBaseURL!)/\(latitude),\(longitude)?units=auto") {
            
            Alamofire.request(forecastURL).responseJSON(completionHandler: { (response) in
                print(response.value!)
                if let jsonDictionary = response.result.value as? [String:Any] {
                    if let currentWeatherDictionary = jsonDictionary["currently"] as? [String:Any] {
                        let currentWeather = CurrentWeather(weatherDictionary: currentWeatherDictionary)
                        completion(currentWeather)
                    } else {
                        completion(nil)
                    }
                }
            })
        }
        
    }
}
