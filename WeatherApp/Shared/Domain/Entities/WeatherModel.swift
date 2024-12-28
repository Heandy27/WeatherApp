import Foundation

struct WeatherModel: Codable {
    let weather: [Weather]
    let main: MainResult
    let name: String
    let sys: Sys
}

struct Weather: Codable, Identifiable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct MainResult: Codable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let humidity: Double
}

struct Sys: Codable {
    let country: String
}