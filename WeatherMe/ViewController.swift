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
    @IBOutlet weak var percipitationChanceLbl: UILabel!
    
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
    
    let degree = "\u{00B0}" // degree symbol
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func didPressSunRiseSetBtn(sender: AnyObject) {
    }
}

