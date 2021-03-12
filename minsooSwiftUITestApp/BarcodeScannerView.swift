//
//  BarcodeScannerView.swift
//  minsooSwiftUITestApp
//
//  Created by MinSoo Jeon on 2021/03/12.
//

import Foundation
import UIKit
import SwiftUI

final class BarcodeScannerView: UIView, BarcodeScannerDelegate{
    
    var scanner:BarcodeScanner?
    var videoPreview: UIView {
        return self
    }
    
    var rectOfInterest: CGRect{
        let mainBound = UIScreen.main.bounds
        return CGRect(x: (mainBound.size.width - 213) / 2, y: (mainBound.size.height - 193) / 2, width: 213, height: 193)
    }
    
    func scanner(_ scanner: BarcodeScanner, didCaptureString str: String) {
        print(str)
    }
    
    func scannerReady(_ scanner: BarcodeScanner) {
        print("ready")
        scanner.startCapturing()
    }
    
    func scannerEndScanning(_ scanner: BarcodeScanner) {
        print("end")
        scanner.startCapturing()
    }
    
    func setup(){
        scanner = BarcodeScanner.init(self)
    }
}

struct RepresentableBarcodeScanner: UIViewRepresentable{
    
    func makeUIView(context: Context) -> BarcodeScannerView {
        let scanner = BarcodeScannerView()
        scanner.setup()
        return scanner
    }
    
    func updateUIView(_ uiView: BarcodeScannerView, context: Context) {
    }
}

struct BarcodeView: View{
    var body: some View{
        ZStack{
            RepresentableBarcodeScanner()
            Image("scanArea")
        }.edgesIgnoringSafeArea(.all)
        .onAppear{
            print("onAppear")
        }
    }
}
