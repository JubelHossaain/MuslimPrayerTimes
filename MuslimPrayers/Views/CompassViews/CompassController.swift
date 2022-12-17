//
//  CompassController.swift
//  CompassExample
//
//   Created by Appnap WS13 on 12/5/22.
//

import UIKit
import CoreLocation
import Contacts

/// CompassController
class CompassController: UIViewController {
    
    // MARK: - Lazy Loading View
    
    /// locationManager
    private lazy var locationManager : CLLocationManager = CLLocationManager()
    /// currLocation
    private lazy var currLocation: CLLocation = CLLocation()
    
    /// dScaView
    private lazy var dScaView: DegreeScaleView = {
        let viewF = CGRect(x: 0, y: 50, width: screenW, height: screenW)
        let scaleV = DegreeScaleView(frame: viewF)
        scaleV.backgroundColor = .black
        return scaleV
    }()
    
    /// geographyInfoView
    private lazy var geographyInfoView: GeographyInfoView = {
        let geo = GeographyInfoView.loadingGeographyInfoView()
        geo.frame = CGRect(x: 0, y: 480, width: screenW, height: 165)
        return geo
    }()
    
    // MARK: - Destroy
    // deinit() deinitialization
    deinit {
        locationManager.stopUpdatingHeading()
        locationManager.delegate = nil
    }
}

//MARK: - View Life Cycle
extension CompassController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        createLocationManager()
    }
}

//MARK: - Configure
extension CompassController {
    
    /// configUI
    private func configUI() {
        view.backgroundColor = .black
        view.addSubview(dScaView)
        view.addSubview(geographyInfoView)
    }
    
    /// createLocationManager
    private func createLocationManager() {
        
        
        locationManager.delegate = self
        
        
        locationManager.distanceFilter = 0
        
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        
        
        locationManager.requestWhenInUseAuthorization()
        
        
        locationManager.allowsBackgroundLocationUpdates = true
        
        
        if locationManager.authorizationStatus == .authorizedAlways || locationManager.authorizationStatus == .authorizedWhenInUse {
            if CLLocationManager.locationServicesEnabled() && CLLocationManager.headingAvailable() {
                locationManager.startUpdatingLocation()
                locationManager.startUpdatingHeading()
                
            }else {
                print("not getting location ")
            }
        }
    }
    
}

// MARK: - Update location information
extension CompassController {
    
    
    /// - Parameter newHeading: toward
    private func update(_ newHeading: CLHeading) {
        
        /// 朝向
        let theHeading: CLLocationDirection = newHeading.magneticHeading > 0 ? newHeading.magneticHeading : newHeading.trueHeading
        
        /// angle
        let angle = Int(theHeading)
        
        switch angle {
        case 0:
            geographyInfoView.directionLabel.text = "N"
        case 90:
            geographyInfoView.directionLabel.text = "E"
        case 180:
            geographyInfoView.directionLabel.text = "S"
        case 270:
            geographyInfoView.directionLabel.text = "W"
        default:
            break
        }
        
        if angle > 0 && angle < 90 {
            geographyInfoView.directionLabel.text = "NE"
        }else if angle > 90 && angle < 180 {
            geographyInfoView.directionLabel.text = "SE"
        }else if angle > 180 && angle < 270 {
            geographyInfoView.directionLabel.text = "SW"
        }else if angle > 270 {
            geographyInfoView.directionLabel.text = "NW"
        }
    }
    
    ///Get the current device orientation (magnetic north direction)
    ///
    /// - Parameters:
    ///   - heading: toward
    ///   - orientation: device orientation
    /// - Returns: Float
    private func heading(_ heading: Float, fromOrirntation orientation: UIDeviceOrientation) -> Float {
        
        var realHeading: Float = heading
        
        switch orientation {
        case .portrait:
            break
        case .portraitUpsideDown:
            realHeading = heading - 180
        case .landscapeLeft:
            realHeading = heading + 90
        case .landscapeRight:
            realHeading = heading - 90
        default:
            break
        }
        if realHeading > 360 {
            realHeading -= 360
        }else if realHeading < 0.0 {
            realHeading += 366
        }
        return realHeading
    }
}


// MARK: - CLLocationManagerDelegate
extension CompassController: CLLocationManagerDelegate {
    
    ///methods related to navigation
    
    /// The callback method after the positioning is successful, as long as the position changes, this method will be called
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // get the latest coordinate
        currLocation = locations.last!
        
        /// longitudeStr
        let longitudeStr = String(format: "%3.4f", currLocation.coordinate.longitude)
        
        /// latitudeStr
        let latitudeStr = String(format: "%3.4f", currLocation.coordinate.latitude)
        
        /// altitudeStr
        let altitudeStr = "\(Int(currLocation.altitude))"
        
        /// newLongitudeStr
        let newLongitudeStr = longitudeStr.DegreeToString(d: Double(longitudeStr)!)
        
        /// newlatitudeStr
        let newlatitudeStr = latitudeStr.DegreeToString(d: Double(latitudeStr)!)
        
        print("north latitude：\(newlatitudeStr)")
        print("east longitude：\(newLongitudeStr)")
        
        geographyInfoView.latitudeAndLongitudeLabel.text = "North latitude \(newlatitudeStr) East longitude \(newLongitudeStr)"
        geographyInfoView.altitudeLabel.text = "Altitude \(altitudeStr)Meter"
        
        
        /// geocoder initilization
        let geocoder = CLGeocoder()
        
        
        geocoder.reverseGeocodeLocation(currLocation) { (placemarks, error) in
            
            guard let placeM = placemarks else { return }
            
            guard placeM.count > 0 else { return }
            
            let placemark: CLPlacemark = placeM[0]
            
            
            let addressDictionary = placemark.postalAddress
            
            /// country
            guard let country = addressDictionary?.country else { return }
            
            /// city
            guard let city = addressDictionary?.city else { return }
            
            /// subLocality
            guard let subLocality = addressDictionary?.subLocality else { return }
            
            /// street
            guard let street = addressDictionary?.street else { return }
            
            //self.positionLabel.text = "\(country)\n\(city) \(subLocality) \(street)"
            self.geographyInfoView.positionLabel.text = "\(country)\(city) \(subLocality) \(street)"
        }
        
    }
    
    // locationManager delegate method
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        
        /// get current device
        let device = UIDevice.current
        
        
        if newHeading.headingAccuracy > 0 {
            
            
            let magneticHeading: Float = heading(Float(newHeading.magneticHeading), fromOrirntation: device.orientation)
            
            
            //let trueHeading: Float = heading(Float(newHeading.trueHeading), fromOrirntation: device.orientation)
            
            
            let headi: Float = -1.0 * Float.pi * Float(newHeading.magneticHeading) / 180.0
            
            geographyInfoView.angleLabel.text = "\(Int(magneticHeading))"
            
            
            dScaView.resetDirection(CGFloat(headi))
            
            
            update(newHeading)
        }
    }
    
    
    func locationManagerShouldDisplayHeadingCalibration(_ manager: CLLocationManager) -> Bool {
        return true
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("定位失败....\(error)")
    }
    
    /// description
    ///
    /// - Parameters:
    ///   - manager: location manager
    ///   - status: current authorization status
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status {
        case .notDetermined:
            print("not determinded")
        case .restricted:
            print("restricted")
        case .denied:
            
            if CLLocationManager.locationServicesEnabled() {
                print("locaion service enable ")
            }else {
                print("location service is not enable")
            }
        case .authorizedAlways:
            print("authorized")
        case .authorizedWhenInUse:
            print("authorized when in use")
        @unknown default:
            fatalError()
        }
    }
    
}
extension String {
    
    /// - Parameter d: need to converted 、latitude value
    func DegreeToString(d: Double) -> String {
        /// degree
        let degree = Int(d)
        print("degree：\(degree)°")
        /// tempMinute
        let tempMinute = Float(d - Double(degree)) * 60
        /// minutes
        let minutes = Int(tempMinute)
        print("minutes：\(minutes)‘")
        /// second
        let second = Int((tempMinute - Float(minutes)) * 60)
        print("second： \(second)\"")
        return "\(degree)°\(minutes)′\(second)″"
    }
}
