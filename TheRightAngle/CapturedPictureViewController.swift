//
//  CapturedPictureViewController.swift
//  TheRightAngle
//
//  Created by Abdulaziz Ismail on 09/09/2017.
//  Copyright © 2017 Abdulaziz Ismail. All rights reserved.
//

import UIKit

class CapturedPictureViewController: UIViewController {
    
    var capturedPicture: UIImage!

    @IBOutlet weak var saveButton_TouchUpInside: UIButton!
    @IBOutlet weak var cancelButton_TouchUpInside: UIButton!
    @IBOutlet weak var capturedPhoto: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            capturedPhoto.image = capturedPicture
        
    }
    @IBAction func savePhoto(_ sender: Any) {
        //UIImageWriteToSavedPhotosAlbum(capturedPicture, nil, nil, nil)
        //dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelPhoto(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
