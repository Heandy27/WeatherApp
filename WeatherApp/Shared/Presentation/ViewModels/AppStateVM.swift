import Foundation

@Observable
final class AppStateVM {
    var status: StatusModel = .loading
    @ObservationIgnored
    var locationManager = LocationViewModel()
    @ObservationIgnored
    var useCase: WeatherUseCaseProtocol
    
    init(useCase: WeatherUseCaseProtocol = WeatherUseCase()) {
        self.useCase = useCase
        statusApp()
    }
    
    @MainActor
    func getWeather() {
        Task {
            do {
                let weather = try await useCase.getCurrentLocation(lon: locationManager.longitude, lat: locationManager.latitude)
                
                if weather.weather.isEmpty {
                    self.status = .errorApp
                } else {
                    self.status = .success
                }
            } catch {
                self.status = .errorApp
            }
        }
    }
    
    func statusApp() {
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            DispatchQueue.main.async {
                self.getWeather()
            }
        }
    }
    
}
