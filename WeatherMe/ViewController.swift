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
    @IBOutlet weak var dayFiveHighTempImg: UILabel!
    @IBOutlet weak var dayFiveLowTempImg: UILabel!
    
    var cityName: String!
    var weatherInstance: WeatherInstance!
    var currentTime: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cityName = "28173"
        weatherInstance = WeatherInstance.init(cityName: cityName)
        
        let styler = NSDateFormatter()
        styler.timeStyle = NSDateFormatterStyle.ShortStyle
        currentTime = styler.stringFromDate(NSDate())
        
        weatherInstance.downloadCurentWeatherDetails { () -> () in
            //this will be called after download is done
            self.uodateUI()
        }
        
        weatherInstance.downloadFutureWeatherDetails { () -> () in
            //this will be called after download is done
            self.uodateUI()
        }
    }
    
    func uodateUI() {
        cityNameLbl.text = weatherInstance.cityName
        currentWeatherImg.image = UIImage(named: weatherInstance.weatherType.rawValue)
        currentTempLbl.text = weatherInstance.temp
        currentDayLbl.text = getDayOfWeekString("2016-06-12")
        currentTimeLbl.text = currentTime
        todayHighTempLbl.text = weatherInstance.highTemp
        todayLowTempLbl.text = weatherInstance.lowTemp
        windSpeedLbl.text = weatherInstance.windSpeed
        humidityLbl.text = weatherInstance.humidity
        
    }
    
    @IBAction func didPressSunRiseSetBtn(sender: AnyObject) {
        
    }
    
    func getDayOfWeekString(today:String)->String? {
        let formatter  = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
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
}

