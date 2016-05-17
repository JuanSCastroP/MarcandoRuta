//
//  ViewController.swift
//  MarcandoRuta
//
//  Created by mac on 5/16/16.
//  Copyright © 2016 Juan Sebastian Castro. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var latitud : String = ""
    var longitud : String = ""
    var exacHoriz : String = ""
    var distancia : Int = 0
    let radioRegion: CLLocationDistance = 500
    
    @IBOutlet weak var mostrarLatitud: UILabel!
    @IBOutlet weak var mostrarLongitud: UILabel!
    
    
    
    @IBOutlet weak var mapa: MKMapView!
    private var mapavista : MKMapView!
    
    private let manejador = CLLocationManager() //definir manejador

    override func viewDidLoad() {
        super.viewDidLoad()

        manejador.delegate = self
        manejador.desiredAccuracy = kCLLocationAccuracyBest
        manejador.requestWhenInUseAuthorization()
        manejador.startUpdatingLocation()
        manejador.distanceFilter = 50
        
        
        let coordinateRegion = MKCoordinateRegionMakeWithDistance((manejador.location?.coordinate)!, radioRegion, radioRegion)
        mapa.setRegion(coordinateRegion, animated: true)
        
    }

    //implementar funciones del protocolo
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) { // solicitar autorizacion
        if status == .AuthorizedWhenInUse{
            manejador.startUpdatingLocation() // GPS
            mapa.showsUserLocation = true // muestra ubicacion del usuario en el mapa---
            
        }else{
            manejador.stopUpdatingLocation() // GPS
            mapa.showsUserLocation = false
            
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) { // metodo que recibe las lecturas del GPS

        let miCoordenada = locations[locations.count - 1] // obtiene mas reciente coordenada
        let latitud = miCoordenada.coordinate.latitude
        let longitud = miCoordenada.coordinate.longitude
        let coord2D = CLLocationCoordinate2D(latitude: latitud, longitude: longitud)
        
        
        // amplitud
        let myLatDelta = 0.05
        let myLongDelta = 0.05
        let myAmplitud = MKCoordinateSpan(latitudeDelta: myLatDelta, longitudeDelta: myLongDelta)
        
        let myRegion = MKCoordinateRegion(center: coord2D, span: myAmplitud)
        
        //centrar mapa en esta region
        
        mapa.setRegion(myRegion, animated: true)
        
        //poner PIN
        
        let pin = MKPointAnnotation()
        pin.coordinate = coord2D
        mapa.addAnnotation(pin)
        pin.title = "Latitud: \(latitud), Longitud \(longitud)" //titulo
        pin.subtitle="Distancia Recorrida: \(distancia)" //subtitulo
        distancia += 50
        
        
    }
    
    
    
    // se lanza si hay error en lectura
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        let alerta = UIAlertController(title: "ERROR", message: "error \(error.code)", preferredStyle: .Alert)
        let accionOK = UIAlertAction(title: "OK", style: .Default, handler:
            { accion in
        })
        alerta.addAction(accionOK)
        self.presentViewController(alerta, animated: true, completion: nil)
    }

    

    @IBAction func cambiarVistaMapa(sender: AnyObject, forEvent event: UIEvent) { // Cambiar tipo de vista de mapa
        
        if sender.selectedSegmentIndex == 0{
            mapa.mapType = .Standard // vista de mapa normal
        }
        else if sender.selectedSegmentIndex == 1{
            mapa.mapType = .Satellite //vista de mapa Satelite
        }
        else if sender.selectedSegmentIndex == 2{
            mapa.mapType = .Hybrid // vista de mapa hibrido
        }
    }
    

    
    @IBAction func zoomFuncion(sender: AnyObject, forEvent event: UIEvent) {
            mapa.zoomEnabled = true
              
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

