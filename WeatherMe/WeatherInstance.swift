//
//  WeatherInstance.swift
//  WeatherMe
//
//  Created by Marcus Cooper on 6/12/16.
//  Copyright © 2016 SZLSoft. All rights reserved.
//

import Foundation
import Alamofire

class WeatherInstance {
    enum weatherTypeEnum: String {
        case ClearDay = "ClearDay.png"
        case ClearNight = "ClearNight.png"
        case Cloudy = "Cloudy.png"
        case Hail = "Hail.png"
        case MostlyMoony = "MostlyMoony.png"
        case MostlySunny = "MostlySunny.png"
        case Rain = "Rain.png"
        case Sleet = "Sleet.png"
        case Snow = "Snow"
        case ThunderShowers = "ThunderShowers.png"
        case Wind = "Wind.png"
    }
    
    private var _cityName: String!
    private var _weatherType: weatherTypeEnum!
    private var _temp: String!
    private var _highTemp: String!
    private var _lowTemp: String!
    private var _windSpeed: String!
    private var _humidity: String!
    private var _currentWeatherUrl: String!
    private var _forecastWeatherUrl: String!
    
    var cityName: String {
        return _cityName
    }

    var weatherType: weatherTypeEnum {
        return _weatherType
    }
    
    var temp: String {
        return _temp
    }
    
    var highTemp: String {
        return _highTemp
    }
    
    var lowTemp: String {
        return _lowTemp
    }
    
    var windSpeed: String {
        return _windSpeed
    }
    
    var humidity: String {
        return _humidity
    }
    
    let degree = "\u{00B0}" // degree symbol

    init(cityName: String) {
        self._cityName = cityName
        
        _currentWeatherUrl = "\(URL_CURRENT_BASE)\(self._cityName)\(URL_OPTIONS)\(URL_UNITS)\(URL_KEY)"
        _forecastWeatherUrl = "\(URL_FORECAST_BASE)\(self._cityName)\(URL_OPTIONS)\(URL_UNITS)\(URL_KEY)"
    }
    
    func isDay() -> Bool {
        return true
    }
    
    func downloadCurentWeatherDetails(completed: DownloadComplete) {
        let url = NSURL(string: _currentWeatherUrl)!
        print("CURRENT URL: \(url)")
        
        Alamofire.request(.GET, url).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                if let name = dict["name"] as? String {
                    self._cityName = name
                }
                
                if let weatherDict = dict["weather"] as? [Dictionary<String, AnyObject>] where weatherDict.count > 0 {
                    if let main = weatherDict[0]["main"] as? String {
                        if main == "Clear" {
                            if self.isDay() {
                                self._weatherType = weatherTypeEnum.ClearDay
                            } else {
                                self._weatherType = weatherTypeEnum.ClearNight
                            }
                        } else {
                            self._weatherType = weatherTypeEnum.Hail
                        }
                        
                        print("Weather Type: \(self._weatherType.rawValue)")
                    }
                    
                    //Description Not Used
                    if let descr = weatherDict[0]["description"] as? String {
                        print("Description: \(descr)")
                    }
                }
                
                if let mainDict = dict["main"] as? Dictionary<String, Double>
                {
                    if let temp = mainDict["temp"] {
                        self._temp = ("\(Int(round(temp)))\(self.degree)")
                        print("Temp: \(self.temp)")
                    }
                    
                    if let lowTemp = mainDict["temp_min"] {
                        self._lowTemp = ("\(Int(round(lowTemp)))\(self.degree)")
                        print("Low Temp: \(self.lowTemp)")
                    }
                    
                    if let highTemp = mainDict["temp_max"] {
                        self._highTemp = ("\(Int(round(highTemp)))\(self.degree)")
                        print("High Temp: \(self.highTemp)")
                    }
                    
                    if let humidity = mainDict["humidity"] {
                        self._humidity = ("\(Int(round(humidity)))\(self.degree)")
                    }
                }
                
                if let windDict = dict["wind"] as? Dictionary<String, Double>
                {
                    if let windSpeed = windDict["speed"] {
                        self._windSpeed = ("\(Int(round(windSpeed)))MPH")
                        print("Wind Speed: \(self.windSpeed)")
                    }
                }
                completed()
            }
        }
    }
    
    func downloadFutureWeatherDetails(completed: DownloadComplete) {
        let url = NSURL(string: _forecastWeatherUrl)!
        print("FORECAST URL: \(url)")
        
        Alamofire.request(.GET, url).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                if let listDict = dict["list"] as? [Dictionary<String, AnyObject>] where listDict.count > 0 {
                    let day1Dict = listDict[0]
                    let day2Dict = listDict[8]
                    let day3Dict = listDict[16]
                    let day4Dict = listDict[24]
                    let day5Dict = listDict[32]
                }
            }
        }
    }
}