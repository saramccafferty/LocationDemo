//
//  ViewController.swift
//  LocationDemo
//
//  Created by Sara on 8/2/2023.
//

import UIKit

class ViewController: UIViewController {
    
    let manager = LocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func locationButtonTapped(_ sender: UIButton) {
        switch manager.authenticationStatus {
        case .allowed:
            manager.requestLocation()
            print("Your location - \(manager.currentLocation)")
        case .denied:
            handleDenied()
        case .notDetermined:
            manager.requestAuthorisation()
        }
    }
    
    private func handleDenied() {
        let alert = UIAlertController(title: "Location Services are disabled", message: "Enable location services to allow the app to determine your location", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let settings = UIAlertAction(title: "Settings", style: .default, handler: nil)
        
        alert.addAction(cancel)
        alert.addAction(settings)
        
        present(alert, animated: true, completion: nil)
    }
    
}

