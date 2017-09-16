//
//  ViewController.swift
//  TheRightAngle
//
//  Created by Abdulaziz Ismail on 09/09/2017.
//  Copyright © 2017 Abdulaziz Ismail. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var backgroundPhoto: UIImageView!
        @IBOutlet weak var pickTransparentPhoto: UIImageView!
    
    
    var captureSession = AVCaptureSession() //input and output
    var backCamera: AVCaptureDevice?
    var frontCamera: AVCaptureDevice?
    var currentCamera: AVCaptureDevice?
    
    var photoOutput: AVCapturePhotoOutput?
    
    var cameraPreviewLayer: AVCaptureVideoPreviewLayer?
    
    var capturedPicture: UIImage?
    
    
    @IBOutlet weak var capturePhoto_TouchUpInside: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCaptureSession()
        setupDevice()
        setupInputOutput()
        setupPreviewLayer()
        startRunningCaptureSession()
        
        //allowing the image view to recognize gestures to replicate a button functionality
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.handleSelectBackgroundImage))
        pickTransparentPhoto.addGestureRecognizer(tapGesture)
        pickTransparentPhoto.isUserInteractionEnabled = true
        
    }
    
    func handleSelectBackgroundImage() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        present(pickerController, animated: true, completion: nil)
    }
    
    
    @IBAction func switchCamera(_ sender: Any) {
        
    }
    
    func setupCaptureSession() {
        captureSession.sessionPreset = AVCaptureSessionPresetPhoto
    }
    
    func setupDevice() {
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: AVMediaTypeVideo, position: AVCaptureDevice.Position.unspecified)
        let devices = deviceDiscoverySession?.devices
        
        for device in devices! {
            if device.position == AVCaptureDevice.Position.back {
                backCamera = device
            } else if device.position == AVCaptureDevice.Position.front {
                frontCamera = device
            }
        }
        
        currentCamera = backCamera
    }
    
    func setupInputOutput() {
        do {
            let captureDeviceInput = try AVCaptureDeviceInput(device: currentCamera!)
            captureSession.addInput(captureDeviceInput)
            photoOutput = AVCapturePhotoOutput()
            photoOutput?.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])], completionHandler: nil)
            captureSession.addOutput(photoOutput!)
        } catch {
            print(error)
        }
    }
    
    func setupPreviewLayer() {
        cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        cameraPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        cameraPreviewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
        cameraPreviewLayer?.frame = self.view.frame
        self.view.layer.insertSublayer(cameraPreviewLayer!, at: 0)
    }
    
    func startRunningCaptureSession() {
        captureSession.startRunning()
    }
    
    @IBAction func capturePhotoButton(_ sender: Any) {
        let settings = AVCapturePhotoSettings()
        photoOutput?.capturePhoto(with: settings, delegate: self)
        // performSegue(withIdentifier: "showPhoto_Segue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "capturePhoto_Segue" {
            let previewVC = segue.destination as! CapturedPictureViewController
            previewVC.capturedPicture = self.capturedPicture
        }
    }

    
    
    
}

extension ViewController: AVCapturePhotoCaptureDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let imageData = photo.fileDataRepresentation() {
            capturedPicture = UIImage(data: imageData)
            performSegue(withIdentifier: "capturePhoto_Segue", sender: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {

        if let pickedBackground = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            backgroundPhoto.image = pickedBackground
            print("DASDASD")
        }
        
        dismiss(animated: true, completion: nil)
    }
}



