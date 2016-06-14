//
//  WeatherDetails.swift
//  WeatherMe
//
//  Created by Marcus Cooper on 6/13/16.
//  Copyright © 2016 SZLSoft. All rights reserved.
//

import Foundation

class WeatherDetails {
    var _weatherDate: NSDate!
    var _weatherType: WeatherInstance.weatherTypeEnum!
    var _lowTemp: Int!
    var _highTemp: Int!
    var _lowTempStr: String!
    var _highTempStr: String!
    
    var weatherDate: NSDate {
        return _weatherDate
    }
    
    var weatherType: WeatherInstance.weatherTypeEnum {
        return _weatherType
    }
    
    var lowTemp: Int {
        return _lowTemp
    }
    
    var highTemp: Int {
        return _highTemp
    }
    
    var lowTempStr: String {
        return _lowTempStr
    }
    
    var highTempStr: String {
        return _highTempStr
    }
    
    init(weatherDate: NSDate, weatherType: WeatherInstance.weatherTypeEnum, lowTemp: Int, highTemp: Int, lowTempStr: String, highTempStr: String) {
        self._weatherDate = weatherDate
        self._weatherType = weatherType
        self._lowTemp = lowTemp
        self._highTemp = highTemp
        self._lowTempStr = lowTempStr
        self._highTempStr = highTempStr
    }
}