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
    
    private var _firstWeatherType: weatherTypeEnum!
    private var _firstHighTemp: String!
    private var _firstLowTemp: String!
    
    private var _secondWeatherType: weatherTypeEnum!
    private var _secondHighTemp: String!
    private var _secondLowTemp: String!
    
    private var _thirdWeatherType: weatherTypeEnum!
    private var _thirdHighTemp: String!
    private var _thirdLowTemp: String!
    
    private var _fourthWeatherType: weatherTypeEnum!
    private var _fourthHighTemp: String!
    private var _fourthLowTemp: String!
    
    private var _fifthWeatherType: weatherTypeEnum!
    private var _fifthHighTemp: String!
    private var _fifthLowTemp: String!
    
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
    
    var firstWeatherType: weatherTypeEnum {
        return _firstWeatherType
    }
    
    var firstHighTemp: String {
        return _firstHighTemp
    }
    
    var firstLowTemp: String {
        return _firstLowTemp
    }
    
    var secondWeatherType: weatherTypeEnum {
        return _secondWeatherType
    }
    
    var secondHighTemp: String {
        return _secondHighTemp
    }
    
    var secondLowTemp: String {
        return _secondLowTemp
    }
    
    var thirdWeatherType: weatherTypeEnum {
        return _thirdWeatherType
    }
    
    var thirdHighTemp: String {
        return _thirdHighTemp
    }
    
    var thirdLowTemp: String {
        return _thirdLowTemp
    }
    
    var fourthWeatherType: weatherTypeEnum {
        return _fourthWeatherType
    }
    
    var fourthHighTemp: String {
        return _fourthHighTemp
    }
    
    var fourthLowTemp: String {
        return _fourthLowTemp
    }
    
    var fifthWeatherType: weatherTypeEnum {
        return _fifthWeatherType
    }
    
    var fifthHighTemp: String {
        return _fifthHighTemp
    }
    
    var fifthLowTemp: String {
        return _fifthLowTemp
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
                        switch main {
                            case "Clear":
                                if self.isDay() {
                                    self._weatherType = weatherTypeEnum.ClearDay
                                } else {
                                    self._weatherType = weatherTypeEnum.ClearNight
                                }
                            case "Rain":
                                self._weatherType = weatherTypeEnum.Rain
                            case "Clouds":
                                self._weatherType = weatherTypeEnum.Cloudy
                            case "Thunderstorm":
                                self._weatherType = weatherTypeEnum.ThunderShowers
                            case "Snow":
                                self._weatherType = weatherTypeEnum.Snow
                            case "Hail":
                                self._weatherType = weatherTypeEnum.Hail
                            default:
                                self._weatherType = weatherTypeEnum.ClearDay
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
                    if let weatherDict = day1Dict["weather"] as? [Dictionary<String, AnyObject>] where weatherDict.count > 0 {
                        if let main = weatherDict[0]["main"] as? String {
                            switch main {
                            case "Clear":
                                if self.isDay() {
                                    self._firstWeatherType = weatherTypeEnum.ClearDay
                                } else {
                                    self._firstWeatherType = weatherTypeEnum.ClearNight
                                }
                            case "Rain":
                                self._firstWeatherType = weatherTypeEnum.Rain
                            case "Clouds":
                                self._firstWeatherType = weatherTypeEnum.Cloudy
                            case "Thunderstorm":
                                self._firstWeatherType = weatherTypeEnum.ThunderShowers
                            case "Snow":
                                self._firstWeatherType = weatherTypeEnum.Snow
                            case "Hail":
                                self._firstWeatherType = weatherTypeEnum.Hail
                            default:
                                self._firstWeatherType = weatherTypeEnum.ClearDay
                            }
                            print("Weather Type: \(self._firstWeatherType.rawValue)")
                        }
                    }
                    
                    if let firstMainDict = day1Dict["main"] as? Dictionary<String, AnyObject>
                    {
                        if let firstLowTemp = firstMainDict["temp_min"] as? Double {
                            self._firstLowTemp = ("\(Int(round(firstLowTemp)))\(self.degree)")
                            print("Low Temp(1): \(self._firstLowTemp)")
                        }
                        
                        if let firstHighTemp = firstMainDict["temp_max"] as? Double  {
                            self._firstHighTemp = ("\(Int(round(firstHighTemp)))\(self.degree)")
                            print("High Temp(1): \(self._firstHighTemp)")
                        }
                    }
                    
                    let day2Dict = listDict[8]
                    if let weatherDict = day2Dict["weather"] as? [Dictionary<String, AnyObject>] where weatherDict.count > 0 {
                        if let main = weatherDict[0]["main"] as? String {
                            switch main {
                            case "Clear":
                                if self.isDay() {
                                    self._secondWeatherType = weatherTypeEnum.ClearDay
                                } else {
                                    self._secondWeatherType = weatherTypeEnum.ClearNight
                                }
                            case "Rain":
                                self._secondWeatherType = weatherTypeEnum.Rain
                            case "Clouds":
                                self._secondWeatherType = weatherTypeEnum.Cloudy
                            case "Thunderstorm":
                                self._secondWeatherType = weatherTypeEnum.ThunderShowers
                            case "Snow":
                                self._secondWeatherType = weatherTypeEnum.Snow
                            case "Hail":
                                self._secondWeatherType = weatherTypeEnum.Hail
                            default:
                                self._secondWeatherType = weatherTypeEnum.ClearDay
                            }
                            print("Weather Type: \(self._secondWeatherType.rawValue)")
                        }
                    }
                    
                    if let secondMainDict = day2Dict["main"] as? Dictionary<String, AnyObject>
                    {
                        if let secondLowTemp = secondMainDict["temp_min"] as? Double {
                            self._secondLowTemp = ("\(Int(round(secondLowTemp)))\(self.degree)")
                            print("Low Temp(2): \(self._secondLowTemp)")
                        }
                        
                        if let secondHighTemp = secondMainDict["temp_max"] as? Double  {
                            self._secondHighTemp = ("\(Int(round(secondHighTemp)))\(self.degree)")
                            print("High Temp(2): \(self._secondHighTemp)")
                        }
                    }
                    
                    let day3Dict = listDict[16]
                    if let weatherDict = day3Dict["weather"] as? [Dictionary<String, AnyObject>] where weatherDict.count > 0 {
                        if let main = weatherDict[0]["main"] as? String {
                            switch main {
                            case "Clear":
                                if self.isDay() {
                                    self._thirdWeatherType = weatherTypeEnum.ClearDay
                                } else {
                                    self._thirdWeatherType = weatherTypeEnum.ClearNight
                                }
                            case "Rain":
                                self._thirdWeatherType = weatherTypeEnum.Rain
                            case "Clouds":
                                self._thirdWeatherType = weatherTypeEnum.Cloudy
                            case "Thunderstorm":
                                self._thirdWeatherType = weatherTypeEnum.ThunderShowers
                            case "Snow":
                                self._thirdWeatherType = weatherTypeEnum.Snow
                            case "Hail":
                                self._thirdWeatherType = weatherTypeEnum.Hail
                            default:
                                self._thirdWeatherType = weatherTypeEnum.ClearDay
                            }
                            print("Weather Type: \(self._thirdWeatherType.rawValue)")
                        }
                    }
                    
                    if let thirdMainDict = day3Dict["main"] as? Dictionary<String, AnyObject>
                    {
                        if let thirdLowTemp = thirdMainDict["temp_min"] as? Double {
                            self._thirdLowTemp = ("\(Int(round(thirdLowTemp)))\(self.degree)")
                            print("Low Temp(3): \(self._thirdLowTemp)")
                        }
                        
                        if let thirdHighTemp = thirdMainDict["temp_max"] as? Double  {
                            self._thirdHighTemp = ("\(Int(round(thirdHighTemp)))\(self.degree)")
                            print("High Temp(3): \(self._thirdHighTemp)")
                        }
                    }
                    
                    let day4Dict = listDict[24]
                    if let weatherDict = day4Dict["weather"] as? [Dictionary<String, AnyObject>] where weatherDict.count > 0 {
                        if let main = weatherDict[0]["main"] as? String {
                            switch main {
                            case "Clear":
                                if self.isDay() {
                                    self._fourthWeatherType = weatherTypeEnum.ClearDay
                                } else {
                                    self._fourthWeatherType = weatherTypeEnum.ClearNight
                                }
                            case "Rain":
                                self._fourthWeatherType = weatherTypeEnum.Rain
                            case "Clouds":
                                self._fourthWeatherType = weatherTypeEnum.Cloudy
                            case "Thunderstorm":
                                self._fourthWeatherType = weatherTypeEnum.ThunderShowers
                            case "Snow":
                                self._fourthWeatherType = weatherTypeEnum.Snow
                            case "Hail":
                                self._fourthWeatherType = weatherTypeEnum.Hail
                            default:
                                self._fourthWeatherType = weatherTypeEnum.ClearDay
                            }
                            print("Weather Type: \(self._fourthWeatherType.rawValue)")
                        }
                    }
                    
                    if let fourthMainDict = day4Dict["main"] as? Dictionary<String, AnyObject>
                    {
                        if let fourthLowTemp = fourthMainDict["temp_min"] as? Double {
                            self._fourthLowTemp = ("\(Int(round(fourthLowTemp)))\(self.degree)")
                            print("Low Temp(4): \(self._fourthLowTemp)")
                        }
                        
                        if let fourthHighTemp = fourthMainDict["temp_max"] as? Double  {
                            self._fourthHighTemp = ("\(Int(round(fourthHighTemp)))\(self.degree)")
                            print("High Temp(4): \(self._fourthHighTemp)")
                        }
                    }
                    
                    let day5Dict = listDict[32]
                    if let weatherDict = day5Dict["weather"] as? [Dictionary<String, AnyObject>] where weatherDict.count > 0 {
                        if let main = weatherDict[0]["main"] as? String {
                            switch main {
                            case "Clear":
                                if self.isDay() {
                                    self._fifthWeatherType = weatherTypeEnum.ClearDay
                                } else {
                                    self._fifthWeatherType = weatherTypeEnum.ClearNight
                                }
                            case "Rain":
                                self._fifthWeatherType = weatherTypeEnum.Rain
                            case "Clouds":
                                self._fifthWeatherType = weatherTypeEnum.Cloudy
                            case "Thunderstorm":
                                self._fifthWeatherType = weatherTypeEnum.ThunderShowers
                            case "Snow":
                                self._fifthWeatherType = weatherTypeEnum.Snow
                            case "Hail":
                                self._fifthWeatherType = weatherTypeEnum.Hail
                            default:
                                self._fifthWeatherType = weatherTypeEnum.ClearDay
                            }
                            print("Weather Type: \(self._fifthWeatherType.rawValue)")
                        }
                    }
                    
                    if let fifthMainDict = day5Dict["main"] as? Dictionary<String, AnyObject>
                    {
                        if let fifthLowTemp = fifthMainDict["temp_min"] as? Double {
                            self._fifthLowTemp = ("\(Int(round(fifthLowTemp)))\(self.degree)")
                            print("Low Temp(5): \(self._fifthLowTemp)")
                        }
                        
                        if let fifthHighTemp = fifthMainDict["temp_max"] as? Double  {
                            self._fifthHighTemp = ("\(Int(round(fifthHighTemp)))\(self.degree)")
                            print("High Temp(5): \(self._fifthHighTemp)")
                        }
                    }
                    completed()
                }
            }
        }
    }
}