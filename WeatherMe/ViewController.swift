//
//  ViewController.swift
//  WeatherMe
//
//  Created by Marcus Cooper on 6/11/16.
//  Copyright © 2016 SZLSoft. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cityNameLbl: UILabel!
    @IBOutlet weak var currentWeatherImg: UIImageView!
    @IBOutlet weak var currentTempLbl: UILabel!
    @IBOutlet weak var currentTimeLbl: UILabel!
    @IBOutlet weak var currentDayLbl: UILabel!
    @IBOutlet weak var thermometerImg: UIImageView!
    @IBOutlet weak var todayHighTempLbl: UILabel!
    @IBOutlet weak var todayLowTempLbl: UILabel!
    @IBOutlet weak var windSpeedLbl: UILabel!
    @IBOutlet weak var humidityLbl: UILabel!

    @IBOutlet weak var dayOneDayLbl: UILabel!
    @IBOutlet weak var dayOneWeatherImg: UIImageView!
    @IBOutlet weak var dayOneHighTempLbl: UILabel!
    @IBOutlet weak var dayOneLowTempLbl: UILabel!
    
    @IBOutlet weak var dayTwoDayLbl: UILabel!
    @IBOutlet weak var dayTwoWeatherImg: UIImageView!
    @IBOutlet weak var dayTwoHighTempLbl: UILabel!
    @IBOutlet weak var dayTwoLowTempLbl: UILabel!
    
    @IBOutlet weak var dayThreeDayLbl: UILabel!
    @IBOutlet weak var dayThreeWeatherImg: UIImageView!
    @IBOutlet weak var dayThreeHighTempLbl: UILabel!
    @IBOutlet weak var dayThreeLowTempLbl: UILabel!
    
    @IBOutlet weak var dayFourDayLbl: UILabel!
    @IBOutlet weak var dayFourWeatherImg: UIImageView!
    @IBOutlet weak var dayFourHighTempLbl: UILabel!
    @IBOutlet weak var dayFourLowTempLbl: UILabel!
    
    @IBOutlet weak var dayFiveDayLbl: UILabel!
    @IBOutlet weak var dayFiveWeatherImg: UIImageView!
    @IBOutlet weak var dayFiveHighTempLbl: UILabel!
    @IBOutlet weak var dayFiveLowTempLbl: UILabel!
    
    var cityName: String!
    var weatherInstance: WeatherInstance!
    var currentDate: String!
    var currentTime: String!
    var dayPlusOne: String!
    var dayPlusTwo: String!
    var dayPlusThree: String!
    var dayPlusFour: String!
    var dayPlusFive: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cityName = "28173"
        weatherInstance = WeatherInstance.init(cityName: cityName)
        
        let timeStyler = NSDateFormatter()
        timeStyler.timeStyle = NSDateFormatterStyle.ShortStyle
        currentTime = timeStyler.stringFromDate(NSDate())
        
        let dateStyler = NSDateFormatter()
        dateStyler.dateStyle = NSDateFormatterStyle.ShortStyle
        currentDate = dateStyler.stringFromDate(NSDate())
        
        getNextFiveWeekdays()
        dayOneDayLbl.text = dayPlusOne
        dayTwoDayLbl.text = dayPlusTwo
        dayThreeDayLbl.text = dayPlusThree
        dayFourDayLbl.text = dayPlusFour
        dayFiveDayLbl.text = dayPlusFive
        
        weatherInstance.downloadCurentWeatherDetails { () -> () in
            //this will be called after download is done
            self.updateUI()
        }
        
        weatherInstance.downloadFutureWeatherDetails { () -> () in
            //this will be called after download is done
            self.updateBottomUI()
        }
    }
    
    func updateUI() {
        cityNameLbl.text = weatherInstance.cityName
        currentWeatherImg.image = UIImage(named: weatherInstance.weatherType.rawValue)
        currentTempLbl.text = weatherInstance.temp
        currentDayLbl.text = getDayOfWeekString(currentDate)
        currentTimeLbl.text = currentTime
        todayHighTempLbl.text = weatherInstance.highTemp
        todayLowTempLbl.text = weatherInstance.lowTemp
        windSpeedLbl.text = weatherInstance.windSpeed
        humidityLbl.text = weatherInstance.humidity
    }
    
    func updateBottomUI() {
        dayOneWeatherImg.image = UIImage(named: weatherInstance.firstWeatherType.rawValue)
        dayOneLowTempLbl.text = weatherInstance.firstLowTemp
        dayOneHighTempLbl.text = weatherInstance.firstHighTemp

        dayTwoWeatherImg.image = UIImage(named: weatherInstance.secondWeatherType.rawValue)
        dayTwoLowTempLbl.text = weatherInstance.secondLowTemp
        dayTwoHighTempLbl.text = weatherInstance.secondHighTemp

        dayThreeWeatherImg.image = UIImage(named: weatherInstance.thirdWeatherType.rawValue)
        dayThreeLowTempLbl.text = weatherInstance.thirdLowTemp
        dayThreeHighTempLbl.text = weatherInstance.thirdHighTemp

        dayFourWeatherImg.image = UIImage(named: weatherInstance.fourthWeatherType.rawValue)
        dayFourLowTempLbl.text = weatherInstance.fourthLowTemp
        dayFourHighTempLbl.text = weatherInstance.fourthHighTemp

        dayFiveWeatherImg.image = UIImage(named: weatherInstance.fifthWeatherType.rawValue)
        dayFiveLowTempLbl.text = weatherInstance.fifthLowTemp
        dayFiveHighTempLbl.text = weatherInstance.fifthHighTemp
}
    
    @IBAction func didPressSunRiseSetBtn(sender: AnyObject) {
        
    }
    
    func getDayOfWeekString(today:String)->String? {
        let formatter  = NSDateFormatter()
        formatter.dateFormat = "M/dd/YY"
        if let todayDate = formatter.dateFromString(today) {
            let myCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
            let myComponents = myCalendar.components(.Weekday, fromDate: todayDate)
            let weekDay = myComponents.weekday
            switch weekDay {
            case 1:
                return "Sunday"
            case 2:
                return "Monday"
            case 3:
                return "Tueday"
            case 4:
                return "Wedday"
            case 5:
                return "Thuday"
            case 6:
                return "Friday"
            case 7:
                return "Satday"
            default:
                print("Error fetching days")
                return "Day"
            }
        } else {
            return nil
        }
    }
    
    func getNextFiveWeekdays() {
        print(currentDate)
        print(getDayOfWeekString(currentDate))
        
        switch getDayOfWeekString(currentDate)! {
            case "Sunday":
                dayPlusOne = "MON"
                dayPlusTwo = "TUE"
                dayPlusThree = "WED"
                dayPlusFour = "THU"
                dayPlusFive = "FRI"
            case "Monday":
                dayPlusOne = "TUE"
                dayPlusTwo = "WED"
                dayPlusThree = "ThU"
                dayPlusFour = "FRI"
                dayPlusFive = "SAT"
            case "Tuesday":
                dayPlusOne = "WED"
                dayPlusTwo = "THU"
                dayPlusThree = "FRI"
                dayPlusFour = "SAT"
                dayPlusFive = "SUN"
            case "Wednesday":
                dayPlusOne = "THU"
                dayPlusTwo = "FRI"
                dayPlusThree = "SAT"
                dayPlusFour = "SUN"
                dayPlusFive = "MON"
            case "Thursday":
                dayPlusOne = "FRI"
                dayPlusTwo = "SAT"
                dayPlusThree = "SUN"
                dayPlusFour = "MON"
                dayPlusFive = "TUE"
            case "Friday":
                dayPlusOne = "SAT"
                dayPlusTwo = "SUN"
                dayPlusThree = "MON"
                dayPlusFour = "TUE"
                dayPlusFive = "WED"
            case "Saturday":
                dayPlusOne = "SUN"
                dayPlusTwo = "MON"
                dayPlusThree = "TUE"
                dayPlusFour = "WED"
                dayPlusFive = "THU"
            default:
                dayPlusOne = ""
                dayPlusTwo = ""
                dayPlusThree = ""
                dayPlusFour = ""
                dayPlusFive = ""
        }
    }
}

