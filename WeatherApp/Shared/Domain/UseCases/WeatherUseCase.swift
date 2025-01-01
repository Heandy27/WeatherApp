import Foundation

final class WeatherUseCase: WeatherUseCaseProtocol {
  
    
    var repo: WeatherRepositoryProtocol
    
    init(repo: WeatherRepositoryProtocol = WeatherRepository()) {
        self.repo = repo
    }
    
    func getWeather(city: String) async throws -> WeatherModel {
        return try await repo.getWeather(city: city)
    }
    
    func getCurrentLocation(lon: Double, lat: Double) async throws -> WeatherModel {
        return try await repo.getCurrentLocation(lon: lon, lat: lat)
    }
}

