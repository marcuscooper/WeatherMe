//
//  InfoVC.swift
//  WeatherMe
//
//  Created by Marcus Cooper on 6/14/16.
//  Copyright © 2016 SZLSoft. All rights reserved.
//

import UIKit

class InfoVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func backBtnTapped(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func attributionOneBtnPressed(sender: AnyObject) {
        if let url = NSURL(string: "https://icons8.com") {
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
    @IBAction func attributionTwoBtnPressed(sender: AnyObject) {
        if let url = NSURL(string: "https://makeappicon.com/") {
            UIApplication.sharedApplication().openURL(url)
        }
    }
}

//http://openweathermap.org