//
//  OpenWeatherService.swift
//  HW3-Solution
//
//  Created by Johnathon Frocillo on 4/15/20.
//  Copyright © 2020 Jonathan Engelsma. All rights reserved.
//

import Foundation

let sharedOpenWeatherInstance = OpenWeatherService()
 
class OpenWeatherService: WeatherService {
    
    let API_BASE = "https://api.openweathermap.org/data/2.5/weather?units=imperial&"
    var urlSession = URLSession.shared
    
    class func getInstance() -> OpenWeatherService {
        return sharedOpenWeatherInstance
    }
    
    func getWeatherForLocation(forLocation location: (Double, Double),
                           completion: @escaping (Weather?) -> Void)
    {
 
        //concatentate the complete endpoint URL here.
        let urlStr = "\(API_BASE)lat=\(location.0)&lon=\(location.1)&appid=d95c851ba17c7cfb569485fd364ab2a1"
        let url = URL(string: urlStr)
        
        let task = self.urlSession.dataTask(with: url!) {
            (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            } else if let _ = response {
                let parsedObj : Dictionary<String,AnyObject>!
                do {
                    parsedObj = try JSONSerialization.jsonObject(with: data!, options:
                        .allowFragments) as? Dictionary<String,AnyObject>
                    
                    guard let weather = parsedObj["weather"] as? Array<Any>,
                        let main = parsedObj["main"] as? Dictionary<String, Any>,
                        
                        let tempVar = weather.first as? Dictionary<String, Any>,
                        let icon = tempVar["icon"] as? String,
                        let description = tempVar["description"] as? String,
                        let temp = main["temp"] as? Double
                        else {
                            completion(nil)
                            return
                    }
                    
                    
                    
                    let weatherForecast = Weather(iconName: icon, temperature: temp,
                                          summary: description)
                    completion(weatherForecast)
                    
                }  catch {
                    completion(nil)
                }
            }
        }
        
        task.resume()
    }
}
