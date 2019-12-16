//
//  WeatherManager.swift
//  Weather
//
//  Created by Dwi Bonggo Pribadi on 12/12/19.
//  Copyright © 2019 Dwi Bonggo Pribadi. All rights reserved.
//

import Foundation

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=0822d427cd4025607c7c26bfd718db4b&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(urlString: urlString)
    }
    
    func fetchWeather(latitude: Double, longitude: Double) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(urlString: urlString)
    }
    
    func performRequest (urlString: String){
        //1. Create a URL
        if let url = URL(string: urlString) {
            
            //Create URL String
            let session = URLSession(configuration: .default)
            
            //Give session task
            let task = session.dataTask(with: url, completionHandler: handle(data: reponse:  error: ))
            
            //Start the task
            task.resume()
        }
        
    }
    
    func handle(data: Data?, reponse: URLResponse?, error: Error?){
        if error != nil {
            print(error!)
            return
        }
        
        if let safeData = data{
           // let dataString = String(data: safeData, encoding: .utf8)
            //print(dataString)
            if let weather = parseJSON(weatherData: safeData) {
                delegate?.didUpdateWeather(weather: weather)
            }
        }
    }
    
    func parseJSON(weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodeData.weather[0].id
            let temp = decodeData.main.temp
            let cityName = decodeData.name
            
            let weather = WeatherModel (conditionId: id, cityName: cityName, temperatur: temp)
            
            return weather
        }catch {
            return nil
        }
    }

}

protocol WeatherManagerDelegate {
    func didUpdateWeather (weather: WeatherModel)
}
