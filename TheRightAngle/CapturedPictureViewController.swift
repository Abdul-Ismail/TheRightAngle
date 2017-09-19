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
    
    var bounds = UIScreen.main.bounds
    var widthMiddle: CGFloat!
    var heightMidle: CGFloat!
    var touchedAt: CGPoint!

    @IBOutlet weak var saveButton_TouchUpInside: UIButton!
    @IBOutlet weak var cancelButton_TouchUpInside: UIButton!
    @IBOutlet weak var capturedPhoto: UIImageView!
    
    @IBOutlet weak var transparentPhotoView: UIImageView!
    
    var touching = false
    var started = false
    var changeToTransparent = true
    var i: CGFloat = 0.1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        widthMiddle = bounds.size.width/2
        heightMidle = bounds.size.height/2
        
        capturedPhoto.image = capturedPicture
        transparentPhotoView.image = transparentPhoto
        capturedPhoto.alpha = 1
        transparentPhotoView.alpha = 0

    }
    
    func test() {

       transition(fromPhoto: self.capturedPhoto, toTransparent: self.transparentPhoto, toCaptured: self.capturedPicture)
    }

    //transitions between the two photos
    func transition(fromPhoto: UIImageView, toTransparent: UIImage?, toCaptured: UIImage? ) {

    if !started {
            started = true

           if changeToTransparent {
           UIView.transition(with: fromPhoto,
                          duration: 1, options:
                        .transitionCrossDissolve,
                          animations: { fromPhoto.image = toTransparent
        }, completion: { (value: Bool) in
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
        
        //get points of where was touched first
        if let touch = touches.first {
            touchedAt = touch.location(in: view)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //reseting alpha value once not touching anymore
        capturedPhoto.alpha = 1
        transparentPhotoView.alpha = 0

    }
    
    func updateViewAlpha(distance: Float) {
        capturedPhoto.alpha = 1 - CGFloat(distance * 0.0030)
        transparentPhotoView.alpha = CGFloat(distance * 0.0035)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        //getting distance from touched point and dragged point and using that for alpha value
        if let touch = touches.first {
            let position = touch.location(in: view)
            print(position)
            var distance = hypotf(Float(touchedAt.x - position.x), Float(touchedAt.y - position.y));
            updateViewAlpha(distance: distance)
            
          }

    }

    

    @IBAction func savePhoto(_ sender: Any) {
        //UIImageWriteToSavedPhotosAlbum(capturedPicture, nil, nil, nil)
        //dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelPhoto(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
