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
    var transparentPhoto: UIImage!

    @IBOutlet weak var saveButton_TouchUpInside: UIButton!
    @IBOutlet weak var cancelButton_TouchUpInside: UIButton!
    @IBOutlet weak var capturedPhoto: UIImageView!
    
    @IBOutlet weak var transparentPhotoView: UIImageView!
    
    var touching = true
    var started = false
    var changeToTransparent = true
    var i: CGFloat = 0.1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        capturedPhoto.image = capturedPicture
        transparentPhotoView.image = transparentPhoto
        //capturedPhoto.alpha = 1
        transparentPhotoView.alpha = 0
        



    }
    
    func test() {
//
//        UIView.transition(with: self.capturedPhoto,
//                          duration:1,
//                          options: .transitionCrossDissolve,
//                          animations: { self.capturedPhoto.image = self.transparentPhoto },
//                          completion: nil)
       transition(fromPhoto: self.capturedPhoto, toTransparent: self.transparentPhoto, toCaptured: self.capturedPicture)
        

    }
    
    func transition(fromPhoto: UIImageView, toTransparent: UIImage?, toCaptured: UIImage? ) {

    if !started {
            started = true
        print("SSSSSSS")
           if changeToTransparent {
           UIView.transition(with: fromPhoto,
                          duration: 1, options:
                        .transitionCrossDissolve,
                          animations: { fromPhoto.image = toTransparent
        }, completion: { (value: Bool) in
                            print("changed to false")
            self.changeToTransparent = false
            self.started = false
                        })
        }else {
        UIView.transition(with: fromPhoto,
                          duration: 1, options:
            .transitionCrossDissolve,
                          animations: { fromPhoto.image = toCaptured
        }, completion: { (value: Bool) in
            print("HI")
            self.changeToTransparent = true
            self.started = false
        })
        }
        if !touching {
            return
        }
        
        }
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("START")
        test()
        touching = true
        //changePhoto()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("END")
        touching = false
    }
    

    @IBAction func savePhoto(_ sender: Any) {
        //UIImageWriteToSavedPhotosAlbum(capturedPicture, nil, nil, nil)
        //dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelPhoto(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
