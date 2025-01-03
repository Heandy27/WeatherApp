import Foundation

protocol Weather5DaysRepositoryProtocol {
    func getWeather5Days(lat: Double, lon: Double) async throws -> [ListResponse]
}
