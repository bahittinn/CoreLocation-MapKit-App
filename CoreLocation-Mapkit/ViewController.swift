//
//  ViewController.swift
//  CoreLocation-Mapkit
//
//  Created by Bahittin on 14.09.2023.
//

import UIKit
import CoreLocation
import MapKit
class ViewController: UIViewController {

    var locationManager: CLLocationManager  = CLLocationManager()
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var enlemLabel: UILabel!
    @IBOutlet weak var boylamLabel: UILabel!
    @IBOutlet weak var hizLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        locationManager.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
        
        locationManager.startUpdatingLocation()
        
        
        let konum = CLLocationCoordinate2D(latitude: 37.0139023, longitude: 35.2945878)
        
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        
        let bolge = MKCoordinateRegion(center: konum, span: span)
        
        mapView.setRegion(bolge, animated: true)
        
        let pin = MKPointAnnotation()
        
        pin.coordinate = konum
        pin.title = "Adana Ev"
        pin.subtitle = "Altaşlık"
        mapView.addAnnotation(pin)
        
    }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let sonKonum:CLLocation = locations[locations.count - 1]
        
        enlemLabel.text = "Enlem: \(sonKonum.coordinate.latitude)"
        boylamLabel.text = "Boylam: \(sonKonum.coordinate.longitude)"
        hizLabel.text = "Hiz: \(sonKonum.speed)"
        
        
        
        
    }
}

