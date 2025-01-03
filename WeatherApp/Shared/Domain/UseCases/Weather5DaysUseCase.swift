import Foundation

final class Weather5DaysUseCase: Weather5DaysUseCaseProtocol {
    var repo: Weather5DaysRepositoryProtocol
    
    init(repo: Weather5DaysRepositoryProtocol = Weather5DaysRepository()) {
        self.repo = repo
    }
    
    func getWeather5Days(lat: Double, lon: Double) async throws -> [ListResponse] {
        return try await repo.getWeather5Days(lat: lat, lon: lon)
    } 
}
