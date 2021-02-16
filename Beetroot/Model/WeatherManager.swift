//
//  WeatherManager.swift
//  Beetroot
//
//  Created by Zubair Nurie on 2020-07-15.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, _ weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager{
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=140a6e0d097c534e5a6cf1dd8942269d&units=metric"
    var delegate: WeatherManagerDelegate?
    
    func fetchURL(city: String){
        let url = "\(weatherURL)&q=\(city)"
        fetchWeather(with: url)
    }
    
    func fetchLocationWeather(location: (lat: CLLocationDegrees, lon: CLLocationDegrees)) {
        let url = "\(weatherURL)&lat=\(location.lat)&lon=\(location.lon)"
        fetchWeather(with: url)
    }
    
    func fetchWeather(with url: String){
        let session = URLSession(configuration: .default)
        if let url = URL(string: url) {
            let task = session.dataTask(with: url, completionHandler: { (data, URLResponse, error) in
                if let error = error {
                    delegate?.didFailWithError(error: error)
                    return
                }
                
                if let dataString = data {
                    if let weather = parseJSON(dataString) {
                        print(weather.name)
                        delegate?.didUpdateWeather(self, weather)
                    }
                }
            })
            task.resume()
        }
    }
    
    func parseJSON(_ data: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: data)
            let id = decodedData.weather[0].id
            let name = decodedData.name
            let temp = decodedData.main.temp
            
            let weather = WeatherModel(name: name, temp: temp, id: id)
            return weather
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    
    
}
