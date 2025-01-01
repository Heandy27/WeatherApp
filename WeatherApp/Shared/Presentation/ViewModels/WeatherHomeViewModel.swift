import Foundation
import Combine
import CoreLocation

final class WeatherHomeViewModel: ObservableObject {
    @Published var weatherResult: WeatherModel = WeatherModel(weather: [Weather(id: 0, main: "", description: "", icon: "")], main: MainResult(temp: 0, feels_like: 0, temp_min: 0, temp_max: 0, humidity: 0), name: "", sys: Sys(country: ""))
    @Published var cityText: String = ""
   
    var useCase: WeatherUseCaseProtocol
    var locationViewModel = LocationViewModel()
   
    init(useCase: WeatherUseCaseProtocol = WeatherUseCase()) {
        self.useCase = useCase
    }
    
    @MainActor
    func getWeather() async {
        do {
            // Añadimos un retraso artificial de 2 segundos
            //try await Task.sleep(nanoseconds: 2 * 1_000_000_000)
            
            let data = try await useCase.getWeather(city: cityText)
            self.weatherResult = data
           
          //  print("Weather data: \(data)") // Procesar el resultado aquí
        } catch {
            print("Error fetching weather: \(error)")
        }
    }
    
    
    @MainActor
    func getCurrentLocation() async {
        do {
            let data = try await useCase.getCurrentLocation(lon: locationViewModel.longitude, lat: locationViewModel.latitude)
            self.weatherResult = data
            //print(data)
        } catch {
            print("Error  fetching weather location \(error)")
        }
    }
    
    var idStringIcon: String {
        
        guard let id = weatherResult.weather.first?.id else {
            print("ID no disponible")
            return "Id no disponible"
        }
        
        switch id {
            
        case 200...232:
            return "cloud.bolt.fill"
        case 300...321:
            return "cloud.drizzle.fill"
        case 500...531:
            return "cloud.rain.fill"
        case 600...622:
            return "cloud.snow.fill"
        case 701...781:
            return "cloud.fog.fill"
        case 800:
            return "sun.max.fill"
        case 801...804:
            return "cloud.fill"
        default:
            return "cloud.fill"
        }
    }
    
    var tempString: String {
        return String(format: "%.0f°", weatherResult.main.temp)
    }
    
    var tempMaxString: String {
        return String(format: "%.0f°", weatherResult.main.temp_max)
    }
    
    var tempMinString: String {
        return String(format: "%.0f°", weatherResult.main.temp_min)
    }
    
    var tempFeelsLikeString: String {
        return String(format: "%.0f°", weatherResult.main.feels_like)
    }
    
    var cityCountryText: String {
        let city = weatherResult.name
        let country = weatherResult.sys.country
        var result = ""
        
        if !city.isEmpty && !country.isEmpty {
            result = String(format: "%@, %@", city, country)
            return result
        } else {
            result = "Type a city"
        }
        return result
    }
    
}


