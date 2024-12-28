import Foundation

final class WeatherUseCase: WeatherUseCaseProtocol {
    var repo: WeatherRepositoryProtocol
    
    init(repo: WeatherRepositoryProtocol = WeatherRepository()) {
        self.repo = repo
    }
    
    func getWeather(city: String) async throws -> WeatherModel {
        return try await repo.getWeather(city: city)
    }  
}

