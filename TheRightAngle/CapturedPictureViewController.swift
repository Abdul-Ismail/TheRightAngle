//
//  CapturedPictureViewController.swift
//  TheRightAngle
//
//  Created by Abdulaziz Ismail on 09/09/2017.
//  Copyright © 2017 Abdulaziz Ismail. All rights reserved.
//

import UIKit

class CapturedPictureViewController: UIViewController {

    @IBOutlet weak var saveButton_TouchUpInside: UIButton!
    @IBOutlet weak var cancelButton_TouchUpInside: UIButton!
    @IBOutlet weak var capturedPhoto: UIImageView!
    
    var takenPhoto:UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let availableImage = takenPhoto {
            capturedPhoto.image = availableImage
        }
        
    }

}
