import Foundation

struct Weather5DaysModel: Codable {
    let list: [ListResponse]
}

struct ListResponse: Codable {
    let dt: Int
    let main: Main
    let weather: [WeatherResponse]
    let dt_txt: String
    
    enum CondingKeys: String, CodingKey {
        case id = "dt"
        case main
        case weather
    }
}

struct WeatherResponse: Codable {
    let id: Int
    let main: String
}

struct Main: Codable {
    let temp: Double
}
