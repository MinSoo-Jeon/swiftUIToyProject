//
//  BarcodeScanner.swift
//  minsooSwiftUITestApp
//
//  Created by MinSoo Jeon on 2021/03/12.
//

import UIKit
import AVFoundation

protocol BarcodeScannerDelegate:AnyObject {
    var videoPreview: UIView { get }
    // scanning area rect
    var rectOfInterest: CGRect { get }
    func scanner(_ scanner: BarcodeScanner, didCaptureString str:String)
    func scannerReady(_ scanner: BarcodeScanner)
    func scannerEndScanning(_ scanner: BarcodeScanner)
}

class BarcodeScanner: NSObject {
    
    weak var delegate: BarcodeScannerDelegate?
    private let scannerQueue = DispatchQueue(label: "Scanner Queue")
    private let metadataScannerQueue = DispatchQueue(label: "Metadata Scanner Queue")
    let tempView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))

    private var captureSession = AVCaptureSession()
    private var captureDevice: AVCaptureDevice?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    private var output: AVCaptureMetadataOutput?
    
    private let types: [AVMetadataObject.ObjectType] = [
    .aztec,
    .code128,
    .code39,
    .code39Mod43,
    .code93,
    .dataMatrix,
    .ean13,
    .ean8,
    .interleaved2of5,
    .itf14,
    .pdf417,
    .qr,
    .upce]
    
    private var roiBounds: CGRect {
        guard let roi = delegate?.rectOfInterest, let videoPreview = delegate?.videoPreview else {
            return CGRect.zero
        }
        return tempView.convert(roi, to: videoPreview)
    }
    
    public init(_ delegate:BarcodeScannerDelegate) {
        super.init()
        self.delegate = delegate
        self.prepareCamera()
    }
    
    deinit {
        captureSession.stopRunning()
    }
    
    private func prepareCamera(){
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        
        self.setupSessionInput()
        self.setupSessionOutput()
        
        DispatchQueue.main.async {
            self.delegate?.videoPreview.layer.insertSublayer(self.videoPreviewLayer, at: 0)
            self.videoPreviewLayer.frame = self.delegate?.videoPreview.bounds ?? .zero
            self.delegate?.videoPreview.setNeedsLayout()
            self.delegate?.scannerReady(self)
        }
    }
    
    private func setupSessionInput() {
        guard let device = AVCaptureDevice.default(for: .video) else {
            // delegate error
            return
        }
        do {
            let input = try AVCaptureDeviceInput(device: device)
            try device.lockForConfiguration()
            captureSession.beginConfiguration()
            
            // autofocus settings and focus on middle point
            device.autoFocusRangeRestriction = .near
            device.focusMode = .continuousAutoFocus
            device.exposureMode = .continuousAutoExposure
            
            if let currentInput = captureSession.inputs.filter({$0 is AVCaptureDeviceInput}).first {
                captureSession.removeInput(currentInput)
            }
            
            // Set the input device on the capture session.
            
            if device.supportsSessionPreset(.hd1920x1080) == true {
                captureSession.sessionPreset = .hd1920x1080
            } else if device.supportsSessionPreset(.high) == true {
                captureSession.sessionPreset = .high
            }
            
            captureSession.usesApplicationAudioSession = false
            captureSession.addInput(input)
            captureSession.commitConfiguration()
            captureSession.automaticallyConfiguresCaptureDeviceForWideColor = true
            if device.isLowLightBoostSupported == true {
                device.automaticallyEnablesLowLightBoostWhenAvailable = true
            }
            device.unlockForConfiguration()
            captureDevice = device
            
        } catch(let error) {
            // delegate error
            print(error.localizedDescription)
            return
        }
        
    }
    
    private func setupSessionOutput() {
        guard let _ = AVCaptureDevice.default(for: .video) else {
            // delegate error
            return
        }
        
        let captureOutput = AVCaptureMetadataOutput()
        captureSession.addOutput(captureOutput)
        captureOutput.setMetadataObjectsDelegate(self, queue: metadataScannerQueue)
        captureOutput.metadataObjectTypes = self.types
        output = captureOutput
    }
    
    private func configurePointOfInterests() {
        guard let device = self.captureDevice else { return }
        guard let videoPreviewLayer = self.videoPreviewLayer else { return }

        do {
            try device.lockForConfiguration()
            let point = CGPoint(x: roiBounds.midX, y: roiBounds.midY)
            let convPoint = videoPreviewLayer.captureDevicePointConverted(fromLayerPoint: point)

            device.exposurePointOfInterest = convPoint
            device.focusPointOfInterest = convPoint
            device.unlockForConfiguration()
        } catch {
            // error
        }
    }

    private func configureRectOfInterest() {
        let roi = videoPreviewLayer.metadataOutputRectConverted(fromLayerRect: roiBounds)
        output?.rectOfInterest = roi
    }
    
    public func startCapturing() {
        self.scannerQueue.async {
            self.captureSession.startRunning()
            DispatchQueue.main.async {
                // UI
                self.configurePointOfInterests()
                self.configureRectOfInterest()
            }
        }
    }
    
    
    public func stopCapturing() {
        self.scannerQueue.async {
            self.captureSession.stopRunning()
            DispatchQueue.main.async {
                self.delegate?.scannerEndScanning(self)
            }
        }
    }
}

extension BarcodeScanner: AVCaptureMetadataOutputObjectsDelegate{
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {

        for obj in metadataObjects {
            guard let text = (obj as? AVMetadataMachineReadableCodeObject)?.stringValue else { return }

            let myGroup = DispatchGroup()
            myGroup.enter()
            stopCapturing()
            myGroup.leave()
            myGroup.notify(queue: DispatchQueue.main) {
                AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate)) {}
                self.delegate?.scanner(self, didCaptureString: text)
            }
        }
    }
}

