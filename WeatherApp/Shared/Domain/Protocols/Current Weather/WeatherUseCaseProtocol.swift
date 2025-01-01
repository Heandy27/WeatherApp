import Foundation

protocol WeatherUseCaseProtocol {
    var repo: WeatherRepositoryProtocol { get set }
    func getWeather(city: String) async throws -> WeatherModel
    func getCurrentLocation(lon: Double, lat: Double) async throws -> WeatherModel
}
