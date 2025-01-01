import Foundation

protocol WeatherRepositoryProtocol {
    func getWeather(city: String) async throws -> WeatherModel
    func getCurrentLocation(lon: Double, lat: Double) async throws -> WeatherModel
}
