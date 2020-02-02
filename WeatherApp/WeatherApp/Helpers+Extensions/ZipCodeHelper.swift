import UIKit
import CoreLocation

enum LocationFetchingError: Error {
    case error(Error)
    case noErrorMessage
}

class ZipCodeHelper {
    private init() {}
    static func getLatLong(fromZipCode zipCode: String,
                           completionHandler: @escaping (Result<(lat: Double, long: Double, placeName: String), LocationFetchingError>) -> Void) {
        let geocoder = CLGeocoder()
        DispatchQueue.global(qos: .userInitiated).async {
            geocoder.geocodeAddressString(zipCode){(placemarks, error) -> Void in
                DispatchQueue.main.async {
                    if let placemark = placemarks?.first,
                        let coordinate = placemark.location?.coordinate,
                        let name = placemark.locality {
                        completionHandler(.success((lat: coordinate.latitude, long: coordinate.longitude, placeName: name)))
                    } else {
                        let locationError: LocationFetchingError
                        if let error = error {
                            locationError = .error(error)
                        } else {
                            locationError = .noErrorMessage
                        }
                        completionHandler(.failure(locationError))
                    }
                }
            }
        }
    }
    
    func getCoordinate( addressString : String,
            completionHandler: @escaping(CLLocationCoordinate2D, NSError?) -> Void ) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(addressString) { (placemarks, error) in
            if error == nil {
                if let placemark = placemarks?[0] {
                    let location = placemark.location!
                        
                    completionHandler(location.coordinate, nil)
                    return
                }
            }
                
            completionHandler(kCLLocationCoordinate2DInvalid, error as NSError?)
        }
    }
}

extension Double {
    func dateConverter() -> String {
        let date = Date(timeIntervalSince1970: self)
        let dateFormatter = DateFormatter()
        
        dateFormatter.timeStyle = DateFormatter.Style.medium
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeZone = .current
        dateFormatter.dateFormat = "EEEE, MMM d"//EEEE, MMM d, yyyy, hh:mm a"
        let localDate = dateFormatter.string(from: date)
        return localDate
    }
    
    func timeConverter() -> String {
        let date = Date(timeIntervalSince1970: self)
        let dateFormatter = DateFormatter()
        
        dateFormatter.timeStyle = DateFormatter.Style.medium
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeZone = .current
        dateFormatter.dateFormat = "hh:mm a"//EEEE, MMM d, yyyy, hh:mm a"
        let localDate = dateFormatter.string(from: date)
        return localDate
    }
}

extension UIViewController {
    func showAlert(title: String, message: String, completion: ((UIAlertAction) -> Void)? = nil) {
        
        
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: completion)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
//    func showBigAlert(title: String, message: String, completion: ((UIAlertAction) -> Void)? = nil) {
//        
//        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        
//        let okAction = UIAlertAction(title: "Ok", style: .default, handler: completion)
//        alertController.addAction(okAction)
//        present(alertController, animated: true, completion: nil)
//    }
}

