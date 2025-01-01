import Foundation
import CoreLocation

final class LocationViewModel: NSObject, CLLocationManagerDelegate, ObservableObject {
    
    let locationManager = CLLocationManager()
    @Published var longitude: Double = 0.0
    @Published var latitude: Double = 0.0
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.last {
            longitude = location.coordinate.longitude
            latitude = location.coordinate.latitude
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print(error)
    }
    
    
   
}
