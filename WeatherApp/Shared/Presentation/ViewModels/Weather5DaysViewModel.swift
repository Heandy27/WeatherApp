import Foundation

final class Weather5DaysViewModel: ObservableObject {
    
    var useCase: Weather5DaysUseCaseProtocol
    @Published var weatherData: [ListResponse] = []
    
    init(useCase: Weather5DaysUseCaseProtocol = Weather5DaysUseCase()) {
        self.useCase = useCase
    }
    @MainActor
    func getWeather5Days(lat: Double, lon: Double) async {
        do {
            let data = try await useCase.getWeather5Days(lat: lat, lon: lon)
            self.weatherData = data
        } catch {
            print("Error en getWeather5Days View Model")
        }
    }
    
    func idStringIcon(_ idIcon: Int) -> String {
        
        switch idIcon {
            
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
    
    func tempString(_ tempString: Double) -> String {
        return String(format: "%.0f°C", tempString)
    }
    
    func formatDate(_ dateString: String) -> String {
        let DateFormatter = DateFormatter()
        DateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if let date = DateFormatter.date(from: dateString) {
            DateFormatter.dateFormat = "dd MMM, hh:mm a"
            return DateFormatter.string(from: date)
        } else {
            return "Fecha no válida"
        }
    }
    
}
