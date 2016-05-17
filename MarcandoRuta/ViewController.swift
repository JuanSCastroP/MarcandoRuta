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
    
    
    @IBOutlet weak var mostrarLatitud: UILabel!
    @IBOutlet weak var mostrarLongitud: UILabel!
    
    
    
    @IBOutlet weak var mapa: MKMapView!
    
    private let manejador = CLLocationManager() //definir manejador

    override func viewDidLoad() {
        super.viewDidLoad()

        manejador.delegate = self
        manejador.desiredAccuracy = kCLLocationAccuracyBest
        manejador.requestWhenInUseAuthorization()
        
    }

    //implementar funciones del protocolo
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) { // solicitar autorizacion
        if status == .AuthorizedWhenInUse{
            manejador.startUpdatingLocation() // GPS
            //manejador.startUpdatingHeading() // Brujula
        }else{
            manejador.stopUpdatingLocation() // GPS
            //manejador.stopUpdatingHeading() // brujula
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) { // metodo que recibe las lecturas del GPS
        mostrarLatitud.text =  "\(manager.location!.coordinate.latitude)" // latitud
        mostrarLongitud.text = "\(manager.location!.coordinate.longitude)" // longitud
        exacHoriz = "\(manager.location!.horizontalAccuracy)" // exactitud horizontal
    }
    
    /*
    func locationManager(manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) { // recibe las lecturas de la brujula
        nteMagEtiqueta.text = "\(newHeading.magneticHeading)"
        nteGeoEtiqueta.text = "\(newHeading.trueHeading)"
        
    }*/
    
    
    // se lanza si hay error en lectura
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        let alerta = UIAlertController(title: "ERROR", message: "error \(error.code)", preferredStyle: .Alert)
        let accionOK = UIAlertAction(title: "OK", style: .Default, handler:
            { accion in
        })
        alerta.addAction(accionOK)
        self.presentViewController(alerta, animated: true, completion: nil)
    }
    
    
    

    
    
    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

