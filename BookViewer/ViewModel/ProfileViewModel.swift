import Combine
import CoreLocation
import SwiftUI

class ProfileViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var latitude: Double
    @Published var longitude: Double
    @Published var cityName: String = "Unknown Location"
    @Published var savedBookCount: Int = 0
    @Published var totalBooks: Int = 0
    @Published var currentLocation: CLLocationCoordinate2D?
    @Published var isLoadingLocation: Bool = false
    
    private var temporaryLatitude: Double = 0.0
    private var temporaryLongitude: Double = 0.0
    
    
    private var cancellables = Set<AnyCancellable>()
    private let locationManager = CLLocationManager()

    var bookStatusData: [BookStatus] {
        let unreadBooks = totalBooks - savedBookCount
        return [
            BookStatus(status: "Read", count: savedBookCount),
            BookStatus(status: "Unread", count: unreadBooks)
        ]
    }

    init(latitude: Double = 37.7749, longitude: Double = -122.4194) {
        self.latitude = latitude
        self.longitude = longitude

        super.init()

        self.fetchTotalBooks()

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest

        $latitude
            .combineLatest($longitude)
            .debounce(for: .seconds(1), scheduler: RunLoop.main)
            .sink { [weak self] lat, lon in
                self?.fetchCityName(latitude: lat, longitude: lon)
            }
            .store(in: &cancellables)

        requestLocationPermissions()
    }
    
    func getTemporaryLatitude() -> Double {
        return temporaryLatitude
    }
    
    func getTemporaryLongitude() -> Double {
        return temporaryLongitude
    }

    private func fetchCityName(latitude: Double, longitude: Double) {
        let geocoder = CLGeocoder()
        let location = CLLocation(latitude: latitude, longitude: longitude)
        
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if let error = error {
                print("Error getting city name: \(error.localizedDescription)")
                self.cityName = "Unknown Location"
                return
            }
            
            if let placemark = placemarks?.first {
                let city = placemark.locality ?? "Unknown City"
                let country = placemark.country ?? "Unknown Country"
                self.cityName = "\(city), \(country)"
            } else {
                self.cityName = "Unknown Location"
            }
        }
    }

    func fetchSavedBookCount(for user: User) async {
        do {
            if let count = try await DataManager.shared.getUserBooks(for: user)?.count {
                DispatchQueue.main.async {
                    self.savedBookCount = count
                }
            }
        } catch {
            print("Failed to fetch saved books count: \(error)")
        }
    }

    private func requestLocationPermissions() {
        DispatchQueue.global().async {
            
            if CLLocationManager.locationServicesEnabled() {
                switch self.locationManager.authorizationStatus {
                case .notDetermined:
                    self.locationManager.requestWhenInUseAuthorization()
                case .restricted, .denied:
                    print("Location access denied or restricted.")
                case .authorizedWhenInUse, .authorizedAlways:
                    self.locationManager.requestLocation()
                @unknown default:
                    print("Unknown location authorization status.")
                }
            } else {
                print("Location services are not enabled.")
            }
        }
    }

    func requestCurrentLocation() {
        isLoadingLocation = true
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.requestLocation()
        case .denied, .restricted:
            print("Location access denied or restricted.")
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        @unknown default:
            print("Unknown authorization status.")
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        latitude = location.coordinate.latitude
        longitude = location.coordinate.longitude
        currentLocation = location.coordinate
        isLoadingLocation = false

    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get user location: \(error.localizedDescription)")
        isLoadingLocation = false
    }

    func fetchTotalBooks() {
        Task {
            do {
                let count = try await DataManager.shared.getAllBooks().count
                DispatchQueue.main.async {
                    self.totalBooks = count
                }
            } catch {
                print("Failed to fetch total books: \(error.localizedDescription)")
            }
        }
    }
    
    func saveTemporaryLocation(latitude: Double, longitude: Double) {
        temporaryLatitude = latitude
        temporaryLongitude = longitude
    }
    
    func resetCity() {
        fetchCityName(latitude: temporaryLatitude, longitude: temporaryLongitude)
    }
}
