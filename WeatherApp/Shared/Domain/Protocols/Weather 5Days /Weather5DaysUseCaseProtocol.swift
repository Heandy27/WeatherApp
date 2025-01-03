import Foundation

protocol Weather5DaysUseCaseProtocol {
    var repo: Weather5DaysRepositoryProtocol { get set }
    func getWeather5Days(lat: Double, lon: Double) async throws -> [ListResponse]
}
