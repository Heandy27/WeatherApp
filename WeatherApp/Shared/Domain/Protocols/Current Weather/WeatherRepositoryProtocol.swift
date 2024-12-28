import Foundation

protocol WeatherRepositoryProtocol {
    func getWeather(city: String) async throws -> WeatherModel
}
