import Foundation

final class Weather5DaysRepository: Weather5DaysRepositoryProtocol {
    
    var network: NetworkWeather5DaysProtocol
    
    init(network: NetworkWeather5DaysProtocol = NetworkWeather5Days()) {
        self.network = network
    }
    
    func getWeather5Days(lat: Double, lon: Double) async throws -> [ListResponse] {
        return try await network.getWeather5Days(lat: lat, lon: lon)
    }
}
