import Foundation

protocol NetworkWeatherProtocol {
    func getWeather(city: String) async throws -> WeatherModel
}

final class NetworkWeather: NetworkWeatherProtocol {
    func getWeather(city: String) async throws -> WeatherModel {

        let urlString = "\(ConstantsApp.CONS_API_URL)?q=\(city)&appid=\(ConstantsApp.API_KEY)&units=metric"
        
        guard let url = URL(string: urlString) else {
            throw ErrorApp.badUrl
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethods.get
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let res = response as? HTTPURLResponse,
                  res.statusCode == HttpResponseCode.SUCCESS else {
                throw ErrorApp.errorFromApi(statuscode: "Error en el statuscodeResponse")
            }
            
            let result = try JSONDecoder().decode(WeatherModel.self, from: data)
            return result
            
        } catch {
            throw ErrorApp.errorParsingData
        }
        
       
    }
    
    
}
