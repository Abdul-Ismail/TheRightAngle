//
//  ViewController.swift
//  TheRightAngle
//
//  Created by Abdulaziz Ismail on 09/09/2017.
//  Copyright © 2017 Abdulaziz Ismail. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var capturePhoto_TouchUpInside: UIButton!
    
    @IBAction func capturePhotoButton(_ sender: Any) {
        performSegue(withIdentifier: "capturePhoto_Segue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

