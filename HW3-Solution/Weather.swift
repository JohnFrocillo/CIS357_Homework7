//
//  Weather.swift
//  HW3-Solution
//
//  Created by Johnathon Frocillo on 4/15/20.
//  Copyright © 2020 Jonathan Engelsma. All rights reserved.
//

import Foundation

struct Weather {
    var iconName : String
    var temperature : Double
    var summary : String
    
    init(iconName: String, temperature: Double, summary: String) {
        self.iconName = iconName
        self.temperature = temperature
        self.summary = summary
    }
}
 
protocol WeatherService {
    func getWeatherForLocation(forLocation location: (Double, Double),
                           completion: @escaping (Weather?) -> Void)
}
