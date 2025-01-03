import Foundation

final class WeatherRepository: WeatherRepositoryProtocol {
    
    var network: NetworkWeatherProtocol
    
    init(network: NetworkWeatherProtocol = NetworkWeather()) {
        self.network = network
    }
    
    func getWeather(city: String) async throws -> WeatherModel {
        return try await network.getWeather(city: city)
    }
    
    func getCurrentLocation(lon: Double, lat: Double) async throws -> WeatherModel {
        return try await network.getCurrentLocation(lon: lon, lat: lat)
    }
    
    
}
