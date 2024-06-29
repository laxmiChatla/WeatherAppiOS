//
//  ViewController.swift
//  WeatherApp
//
//  Created by Laxmi Chandrashekhar Chatla on 29/06/24.
//

import UIKit

class ViewController: UIViewController {
    var timer:Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //homePage
        timer=Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(getDataHome), userInfo: nil, repeats: false)
        
    }

    @objc func getDataHome(){
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "homePage", sender: self)
        }
    }

   
}

