import Foundation

protocol NetworkWeather5DaysProtocol {
    func getWeather5Days(lat: Double, lon: Double) async throws -> [ListResponse]
}

final class NetworkWeather5Days: NetworkWeather5DaysProtocol {
    func getWeather5Days(lat: Double, lon: Double) async throws -> [ListResponse] {
        var resultData: [ListResponse] = []
        let urlString = "\(ConstantsApp.CONS_API_URL_5DAYS)?lat=\(lat)&lon=\(lon)&appid=\(ConstantsApp.API_KEY)&units=metric"
        
        guard let url = URL(string: urlString) else {
            throw ErrorApp.badUrl
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethods.get
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let res = response as? HTTPURLResponse,
                  res.statusCode == HttpResponseCode.SUCCESS else {
                throw ErrorApp.errorFromApi(statuscode: "Error from statusCode Weather 5 days")
            }
            
            let result = try JSONDecoder().decode(Weather5DaysModel.self, from: data)
            
            resultData = result.list
            
            
        } catch {
            throw ErrorApp.errorParsingData
        }
        
        return resultData
    }
}
