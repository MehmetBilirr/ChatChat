//
//  LocationViewController.swift
//  ChatChat
//
//  Created by Mehmet Bilir on 4.12.2022.
//

import Foundation
import CoreLocation
import MapKit

class LocationViewController: UIViewController {
    
    public var completion:((CLLocationCoordinate2D)->Void)?
    private var coordinates:CLLocationCoordinate2D?
    private var locationManager = CLLocationManager()
    private let map = MKMapView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureMapView()
        configureNavigationItem()
        configureLocationManager()
        
        
    }
    
    private func configureMapView(){
        view.addSubview(map)
        
        let tabGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(didTabGesture(_:)))
        tabGesture.numberOfTouchesRequired = 1
        tabGesture.numberOfTapsRequired = 1
        map.addGestureRecognizer(tabGesture)
    }
    private func configureNavigationItem(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Send",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTabSendButton))
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        map.frame = view.bounds
    }
    
    @objc func  didTabSendButton() {
        guard let coordinates = coordinates else {return}
        navigationController?.popViewController(animated: true)
        completion?(coordinates)
    }
    @objc func  didTabGesture(_ gesture:UITapGestureRecognizer) {
        let locationInView = gesture.location(in: map)
        let coordinate = map.convert(locationInView, toCoordinateFrom: map)
        self.coordinates = coordinate
        
        for annotation in map.annotations {
            map.removeAnnotation(annotation)
        }
        pinLocation(location: coordinate)
        
    }
    
    private func pinLocation(location:CLLocationCoordinate2D){
        let pin = MKPointAnnotation()
        pin.coordinate = location
        map.addAnnotation(pin)
    }
}

extension LocationViewController:CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        let span = MKCoordinateSpan.init(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: location, span: span)
        pinLocation(location: location)
        self.coordinates = location
        map.setRegion(region, animated: true)
        
    }
    
    private func configureLocationManager(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
}
