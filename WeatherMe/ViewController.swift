//
//  ViewController.swift
//  WeatherMe
//
//  Created by Marcus Cooper on 6/11/16.
//  Copyright © 2016 SZLSoft. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var backgroundImg: UIImageView!
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
    
    @IBOutlet weak var sunSetRiseView: UIView!
    @IBOutlet weak var sunSetRiseBtn: UIButton!
    @IBOutlet weak var sunriseTimeLbl: UILabel!
    @IBOutlet weak var sunsetTimeLbl: UILabel!
    
    @IBOutlet weak var locationChangeView: UIView!
    @IBOutlet weak var locationPinBtn: UIButton!
    @IBOutlet weak var locationNameBtn: UIButton!
    @IBOutlet weak var locationFieldTxtField: UITextField!

    var cityName: String!
    var weatherInstance: WeatherInstance!
    var currentTime: String!
    var dayPlusOne: String!
    var dayPlusTwo: String!
    var dayPlusThree: String!
    var dayPlusFour: String!
    var dayPlusFive: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationFieldTxtField.delegate = self;
    }
    
    override func viewWillAppear(animated: Bool) {
        cityName = "Charlotte"
        populateData()
    }
    
    func populateData() {
        weatherInstance = WeatherInstance.init(cityName: cityName)
        
        let timeStyler = NSDateFormatter()
        timeStyler.timeStyle = NSDateFormatterStyle.ShortStyle
        currentTime = timeStyler.stringFromDate(NSDate())
        
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
        findCorrectBackgroundImg()
        currentTempLbl.text = weatherInstance.temp
        currentDayLbl.text = getDayOfWeekString()
        currentTimeLbl.text = currentTime
        windSpeedLbl.text = weatherInstance.windSpeed
        humidityLbl.text = weatherInstance.humidity
        sunriseTimeLbl.text = weatherInstance.sunrise
        sunsetTimeLbl.text = weatherInstance.sunset
    }
    
    func updateBottomUI() {
        todayHighTempLbl.text = weatherInstance.highTemp
        todayLowTempLbl.text = weatherInstance.lowTemp

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
    
    func getDayOfWeekString()->String? {
        let todayDate = NSDate()
        let myCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        let myComponents = myCalendar?.components(.Weekday, fromDate: todayDate)
        let weekDay = myComponents?.weekday

        switch weekDay! {
            case 1:
                return "Sunday"
            case 2:
                return "Monday"
            case 3:
                return "Tuesday"
            case 4:
                return "Wednesday"
            case 5:
                return "Thursday"
            case 6:
                return "Friday"
            case 7:
                return "Saturday"
            default:
                print("Error fetching days")
                return "Day"
            }
    }
    
    func getNextFiveWeekdays() {
        let todayDay = getDayOfWeekString()!
        switch todayDay {
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

    @IBAction func didPressSunRiseSetBtn(sender: AnyObject) {
        if sunSetRiseView.hidden {
            sunSetRiseView.hidden = false
        } else {
            sunSetRiseView.hidden = true
        }
        locationPinBtn.enabled = false
        locationNameBtn.enabled = false
    }

    @IBAction func closeSunSetRiseBtnTapped(sender: AnyObject) {
        sunSetRiseView.hidden = true
        locationPinBtn.enabled = true
        locationNameBtn.enabled = true
    }
    
    @IBAction func locationPinBtnTapped(sender: AnyObject) {
        presentChangeLocationView()
    }
    
    @IBAction func locationNameBtnTapped(sender: AnyObject) {
        presentChangeLocationView()
    }
    
    func presentChangeLocationView() {
        self.locationFieldTxtField.becomeFirstResponder()
        disableButtons()
    }
    
    func disableButtons() {
        locationPinBtn.enabled = false
        locationNameBtn.enabled = false
        sunSetRiseBtn.enabled = false
        locationChangeView.hidden = false
    }
    
    func enableButtons() {
        locationPinBtn.enabled = true
        locationNameBtn.enabled = true
        sunSetRiseBtn.enabled = true
        locationChangeView.hidden = true
    }

    @IBAction func locationChangeCancelBtnTapped(sender: AnyObject) {
        enableButtons()
    }
    
    @IBAction func locationChangeSubmitBtnTapped(sender: AnyObject) {
        enableButtons()
        cityName = locationFieldTxtField.text
        view.endEditing(true)
        populateData()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        enableButtons()
        cityName = locationFieldTxtField.text
        view.endEditing(true)
        populateData()

        return false
    }
    
    func findCorrectBackgroundImg() {
        switch weatherInstance.weatherType {
            case WeatherInstance.weatherTypeEnum.ClearDay:
                backgroundImg.image = UIImage(named: "SkyClear.png")
        case WeatherInstance.weatherTypeEnum.Cloudy:
            backgroundImg.image = UIImage(named: "SkyCloudy.png")
        case WeatherInstance.weatherTypeEnum.Hail:
            backgroundImg.image = UIImage(named: "SkyHail.png")
        case WeatherInstance.weatherTypeEnum.Rain:
            backgroundImg.image = UIImage(named: "SkyRain.png")
        case WeatherInstance.weatherTypeEnum.Sleet:
            backgroundImg.image = UIImage(named: "SkySleet.png")
        case WeatherInstance.weatherTypeEnum.Snow:
            backgroundImg.image = UIImage(named: "SkySnow.png")
        case WeatherInstance.weatherTypeEnum.ThunderShowers:
            backgroundImg.image = UIImage(named: "SkyLightning.png")
        case WeatherInstance.weatherTypeEnum.Wind:
            backgroundImg.image = UIImage(named: "SkyWindy.png")
            default:
                backgroundImg.image = UIImage(named: "")
        }
    }
}

