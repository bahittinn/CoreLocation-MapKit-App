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
        
        mapView.delegate = self
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(addPin(_:)))
              mapView.addGestureRecognizer(longPressGesture)
        
//        let pin = MKPointAnnotation()
//
//        pin.coordinate = konum
//        pin.title = "Adana Ev"
//        pin.subtitle = "Altaşlık"
//        mapView.addAnnotation(pin)
        
    }
    @objc func addPin(_ gestureRecognizer: UIGestureRecognizer) {
            if gestureRecognizer.state == .began {
                // Dokunulan noktayı al
                let touchPoint = gestureRecognizer.location(in: mapView)
                
                // Dokunulan noktayı harita koordinatına dönüştür
                let coordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
                
                // Pin oluştur ve haritaya ekle
                let annotation = MKPointAnnotation()
                annotation.title = "deneme konum"
                annotation.subtitle = "deneme konum"
                annotation.coordinate = coordinate
                mapView.addAnnotation(annotation)
            }
        }
}

extension ViewController: CLLocationManagerDelegate, MKMapViewDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let sonKonum:CLLocation = locations[locations.count - 1]
        
        enlemLabel.text = "Enlem: \(sonKonum.coordinate.latitude)"
        boylamLabel.text = "Boylam: \(sonKonum.coordinate.longitude)"
        hizLabel.text = "Hiz: \(sonKonum.speed)"
        
        
        let konum = CLLocationCoordinate2D(latitude: sonKonum.coordinate.latitude, longitude: sonKonum.coordinate.longitude)
        
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        
        let bolge = MKCoordinateRegion(center: konum, span: span)
        
        mapView.setRegion(bolge, animated: true)
        mapView.showsUserLocation = true
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
         
    }
}

