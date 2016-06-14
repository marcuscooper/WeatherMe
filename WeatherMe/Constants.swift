//
//  Constants.swift
//  WeatherMe
//
//  Created by Marcus Cooper on 6/12/16.
//  Copyright © 2016 SZLSoft. All rights reserved.
//

import Foundation

let URL_CURRENT_BASE_ZIP = "http://api.openweathermap.org/data/2.5/weather?zip="
let URL_CURRENT_BASE_CITY = "http://api.openweathermap.org/data/2.5/weather?q="
let URL_FORECAST_BASE_ZIP = "http://api.openweathermap.org/data/2.5/forecast?zip="
let URL_FORECAST_BASE_CITY = "http://api.openweathermap.org/data/2.5/forecast?q="
let URL_UNITS = "&units=imperial"
let URL_OPTIONS = "&type=like"
let URL_KEY = "&APPID=4a081c940a798616d41fc7d1b7a9829d"

typealias DownloadComplete = () -> ()