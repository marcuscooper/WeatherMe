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
    
    private var _sunrise: String!
    private var _sunset: String!
    
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
    
    var sunrise: String {
        return _sunrise
    }
    
    var sunset: String {
        return _sunset
    }
    
    let degree = "\u{00B0}" // degree symbol
    var weatherDetails = [WeatherDetails]()

    init(cityName: String) {
        self._cityName = cityName
        
    }
    
    func isDay() -> Bool {
        return true
    }
    
    func downloadCurentWeatherDetails(completed: DownloadComplete) {
        _currentWeatherUrl = "\(URL_CURRENT_BASE)\(self._cityName)\(URL_OPTIONS)\(URL_UNITS)\(URL_KEY)"
        _currentWeatherUrl = _currentWeatherUrl.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
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
                    
                    self._lowTemp = ""
                    self._highTemp = ""
                    
                    //Commented out because I need to read the array of 3-hour data for the day to find the min/max temps
                    /*
                    if let lowTemp = mainDict["temp_min"] {
                        self._lowTemp = ("\(Int(round(lowTemp)))\(self.degree)")
                        print("Low Temp: \(self.lowTemp)")
                    }
                    
                    if let highTemp = mainDict["temp_max"] {
                        self._highTemp = ("\(Int(round(highTemp)))\(self.degree)")
                        print("High Temp: \(self.highTemp)")
                    }
                    */
                    
                    if let humidity = mainDict["humidity"] {
                        self._humidity = ("\(Int(round(humidity)))\(self.degree)")
                    }
                }
                
                if let sysDict = dict["sys"] as? Dictionary<String, AnyObject>
                {
                    if let sunriseInt = sysDict["sunrise"] as? Double {
                        self._sunrise = self.getTimeString(sunriseInt)
                    }
                    
                    if let sunsetInt = sysDict["sunset"] as? Double {
                        self._sunset = self.getTimeString(sunsetInt)
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
        _forecastWeatherUrl = "\(URL_FORECAST_BASE)\(self._cityName)\(URL_OPTIONS)\(URL_UNITS)\(URL_KEY)"
        _forecastWeatherUrl = _forecastWeatherUrl.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        let url = NSURL(string: _forecastWeatherUrl)!
        print("FORECAST URL: \(url)")
        
        Alamofire.request(.GET, url).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                if let listDict = dict["list"] as? [Dictionary<String, AnyObject>] where listDict.count > 0 {
                    
                    self.fillWeatherDetails(listDict)

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
                    completed()
                }
            }
        }
    }
    
    func getTimeString(time: Double) -> String {
        let date = NSDate(timeIntervalSince1970: time)
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        return dateFormatter.stringFromDate(date)
    }
    
    func getDateWithoutTime(time: Double) -> NSDate {
        //let newDate = cal.startOfDayForDate(NSDate(timeIntervalSince1970: time))
        
        let cal: NSCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        let newDate: NSDate = cal.dateBySettingHour(0, minute: 0, second: 0, ofDate: NSDate(timeIntervalSince1970: time), options: NSCalendarOptions())!
        
        return newDate
    }
    
    func fillWeatherDetails(listDict: [Dictionary<String, AnyObject>]) {
        for i in 0..<listDict.count {
            let dayDict = listDict[i]
            
            var weatherDate: NSDate!
            
            if let detailDate = dayDict["dt"] as? Double {
                weatherDate = getDateWithoutTime(detailDate)
            } else {
                weatherDate = NSDate()
            }
            
            var weatherType: weatherTypeEnum!
            
            if let weatherDict = dayDict["weather"] as? [Dictionary<String, AnyObject>] where weatherDict.count > 0 {
                if let main = weatherDict[0]["main"] as? String {
                    switch main {
                    case "Clear":
                        if self.isDay() {
                            weatherType = weatherTypeEnum.ClearDay
                        } else {
                            weatherType = weatherTypeEnum.ClearNight
                        }
                    case "Rain":
                        weatherType = weatherTypeEnum.Rain
                    case "Clouds":
                        weatherType = weatherTypeEnum.Cloudy
                    case "Thunderstorm":
                        weatherType = weatherTypeEnum.ThunderShowers
                    case "Snow":
                        weatherType = weatherTypeEnum.Snow
                    case "Hail":
                        weatherType = weatherTypeEnum.Hail
                    default:
                        weatherType = weatherTypeEnum.ClearDay
                    }
                }
            }
            
            var lowTempStr: String!
            var highTempStr: String!
            var lowTempInt: Int = 0
            var highTempInt: Int = 0
            
            if let mainDict = dayDict["main"] as? Dictionary<String, AnyObject>
            {
                if let lowTemp = mainDict["temp_min"] as? Double {
                    lowTempStr = ("\(Int(round(lowTemp)))\(self.degree)")
                    lowTempInt = Int(round(lowTemp))
                }
                
                if let highTemp = mainDict["temp_max"] as? Double  {
                    highTempStr = ("\(Int(round(highTemp)))\(self.degree)")
                    highTempInt = Int(round(highTemp))
                }
            }
            
            let detail = WeatherDetails(weatherDate: weatherDate, weatherType: weatherType, lowTemp: lowTempInt, highTemp: highTempInt, lowTempStr: lowTempStr, highTempStr: highTempStr)
            weatherDetails.append(detail)
        } //weatherDetails() Array filled, now find data for each day
        
        //Today's High and Low temp
        let calendar = NSCalendar.autoupdatingCurrentCalendar()
        
        let targetData = weatherDetails.filter({calendar.isDateInToday($0.weatherDate)})
        
        let minElement = targetData.minElement ({ (a, b) -> Bool in
            return a.highTemp < b.highTemp
        })
        let minTempInt = minElement?.lowTemp
        let minTempStr = minTempInt!
        self._lowTemp = ("\(minTempStr)\(self.degree)")
        
        let maxElement = targetData.maxElement ({ (a, b) -> Bool in
            return a.highTemp < b.highTemp
        })
        let maxTempInt = maxElement?.highTemp
        let maxTempStr = maxTempInt!
        self._highTemp = ("\(maxTempStr)\(self.degree)")
        
        print("Today's Final High: \(self._highTemp)")
        print("Today's Final Low: \(self._lowTemp)")
        
        let cal: NSCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        let dayPlusOne: NSDate = cal.dateBySettingHour(0, minute: 0, second: 0, ofDate: NSDate().addDays(1), options: NSCalendarOptions())!
        let dayPlusTwo: NSDate = cal.dateBySettingHour(0, minute: 0, second: 0, ofDate: NSDate().addDays(2), options: NSCalendarOptions())!
        let dayPlusThree: NSDate = cal.dateBySettingHour(0, minute: 0, second: 0, ofDate: NSDate().addDays(3), options: NSCalendarOptions())!
        let dayPlusFour: NSDate = cal.dateBySettingHour(0, minute: 0, second: 0, ofDate: NSDate().addDays(4), options: NSCalendarOptions())!
        let dayPlusFive: NSDate = cal.dateBySettingHour(0, minute: 0, second: 0, ofDate: NSDate().addDays(5), options: NSCalendarOptions())!
        
        var weatherDetailsPlus1 = [WeatherDetails]()
        var weatherDetailsPlus2 = [WeatherDetails]()
        var weatherDetailsPlus3 = [WeatherDetails]()
        var weatherDetailsPlus4 = [WeatherDetails]()
        var weatherDetailsPlus5 = [WeatherDetails]()
        
        for days in 1...5 {
            for i in 0..<weatherDetails.count {
                switch days {
                case 1:
                    if weatherDetails[i].weatherDate.compare(dayPlusOne) == NSComparisonResult.OrderedSame {
                        weatherDetailsPlus1.append(weatherDetails[i])
                    }
                case 2:
                    if weatherDetails[i].weatherDate.compare(dayPlusTwo) == NSComparisonResult.OrderedSame {
                        weatherDetailsPlus2.append(weatherDetails[i])
                    }
                case 3:
                    if weatherDetails[i].weatherDate.compare(dayPlusThree) == NSComparisonResult.OrderedSame {
                        weatherDetailsPlus3.append(weatherDetails[i])
                    }
                case 4:
                    if weatherDetails[i].weatherDate.compare(dayPlusFour) == NSComparisonResult.OrderedSame {
                        weatherDetailsPlus4.append(weatherDetails[i])
                    }
                case 5:
                    if weatherDetails[i].weatherDate.compare(dayPlusFive) == NSComparisonResult.OrderedSame {
                        weatherDetailsPlus5.append(weatherDetails[i])
                    }
                default:
                    print("did nothing")
                }
            }
        }
        
        if let minElementPlus1 = weatherDetailsPlus1.minElement ({ (a, b) -> Bool in
            return a.lowTemp < b.lowTemp}) {
            self._firstLowTemp = ("\(minElementPlus1.lowTemp)\(self.degree)")
        } else {
            self._firstLowTemp = ""
        }
        if let maxElementPlus1 = weatherDetailsPlus1.maxElement ({ (a, b) -> Bool in
            return a.highTemp < b.highTemp}) {
            self._firstHighTemp = ("\(maxElementPlus1.highTemp)\(self.degree)")
        } else {
            self._firstHighTemp = ""
        }
        
        if let minElementPlus2 = weatherDetailsPlus2.minElement ({ (a, b) -> Bool in
            return a.lowTemp < b.lowTemp}) {
            self._secondLowTemp = ("\(minElementPlus2.lowTemp)\(self.degree)")
        } else {
            self._secondLowTemp = ""
        }
        if let maxElementPlus2 = weatherDetailsPlus2.maxElement ({ (a, b) -> Bool in
            return a.highTemp < b.highTemp}) {
            self._secondHighTemp = ("\(maxElementPlus2.highTemp)\(self.degree)")
        } else {
            self._secondHighTemp = ""
        }
        if let minElementPlus3 = weatherDetailsPlus3.minElement ({ (a, b) -> Bool in
            return a.lowTemp < b.lowTemp}) {
            self._thirdLowTemp = ("\(minElementPlus3.lowTemp)\(self.degree)")
        } else {
            self._thirdLowTemp = ""
        }
        if let maxElementPlus3 = weatherDetailsPlus3.maxElement ({ (a, b) -> Bool in
            return a.highTemp < b.highTemp}) {
            self._thirdHighTemp = ("\(maxElementPlus3.highTemp)\(self.degree)")
        } else {
            self._thirdHighTemp = ""
        }
        if let minElementPlus4 = weatherDetailsPlus4.minElement ({ (a, b) -> Bool in
            return a.lowTemp < b.lowTemp}){
            self._fourthLowTemp = ("\(minElementPlus4.lowTemp)\(self.degree)")
        } else {
            self._fourthLowTemp = ""
        }
        if let maxElementPlus4 = weatherDetailsPlus4.maxElement ({ (a, b) -> Bool in
            return a.highTemp < b.highTemp}) {
            self._fourthHighTemp = ("\(maxElementPlus4.highTemp)\(self.degree)")
        } else {
            self._fourthHighTemp = ""
        }
        if let minElementPlus5 = weatherDetailsPlus5.minElement ({ (a, b) -> Bool in
            return a.lowTemp < b.lowTemp}) {
            self._fifthLowTemp = ("\(minElementPlus5.lowTemp)\(self.degree)")
        } else {
            self._fifthLowTemp = ""
        }
        if let maxElementPlus5 = weatherDetailsPlus5.maxElement ({ (a, b) -> Bool in
            return a.highTemp < b.highTemp}) {
            self._fifthHighTemp = ("\(maxElementPlus5.highTemp)\(self.degree)")
        } else {
            self._fifthHighTemp = ""
        }
    }
}











