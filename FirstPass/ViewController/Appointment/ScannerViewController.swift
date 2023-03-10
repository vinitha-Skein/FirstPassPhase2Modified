//
//  ScannerViewController.swift
//  FirstPass
//
//  Created by SkeinTechnologies on 21/09/20.
//  Copyright © 2020 SkeinTechnologies. All rights reserved.
//

import UIKit
import AVFoundation

class ScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate
{
    @IBOutlet weak var box: UIImageView!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var bottomHiderView: UIView!
    
    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var appointmentID: UITextField!
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    var delegate:ScanFinishedDelegate?
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupUI()
        
        view.backgroundColor = UIColor.black
        captureSession = AVCaptureSession()
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        
        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            failed()
            return
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            failed()
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        cameraView.layer.addSublayer(previewLayer)
        
        DispatchQueue.global(qos: .utility).async {
            self.captureSession.startRunning()
        }
    }
    func setupUI(){
        box.createBorderForView(cornerRadius: 0, borderWidth: 1, borderColor: UIColor(hexString: "#E98600"))
        container.createBorderForView(cornerRadius: 30, borderWidth: 0, borderColor: .clear)
        container.clipsToBounds = true
        addButton.createBorderForButton(cornerRadius: 8, borderWidth: 0, borderColor: .clear)
        appointmentID.layer.cornerRadius = 10
        
    }
    @IBAction func backAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func popupClose(_ sender: Any)
    {
        container.isHidden = true
        bottomHiderView.isHidden = true
//        delegate?.scanFinished(code: "Code")
    }
    @IBAction func getDetailsAction(_ sender: Any)
    {
//        let storyboard = UIStoryboard(name: "Main", bundle: .main)
//          let vc = storyboard.instantiateViewController(withIdentifier: "NewTokenViewController") as! NewTokenViewController
//          vc.modalPresentationStyle = .fullScreen
//        self.present(vc, animated: true, completion: nil)
    }
    
    func failed() {
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        captureSession = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if (captureSession?.isRunning == false) {
            captureSession.startRunning()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()
        }
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession.stopRunning()
        
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            found(code: stringValue)
        }
        
    }
    
    func found(code: String) {
        print(code)
        
        appointmentID.text = code
       // delegate?.scanFinished(code: code)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}


protocol ScanFinishedDelegate{
    func scanFinished(code:String)
}
