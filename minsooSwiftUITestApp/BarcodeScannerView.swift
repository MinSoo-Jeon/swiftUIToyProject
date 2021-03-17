//
//  BarcodeScannerView.swift
//  minsooSwiftUITestApp
//
//  Created by MinSoo Jeon on 2021/03/12.
//

import Foundation
import UIKit
import SwiftUI

struct BarcodeScannerView: UIViewRepresentable{
    let scanner = BarcodeScanner()
    func makeUIView(context: Context) -> UIViewType {
        scanner.delegate = context.coordinator
        return scanner.preView
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(scanner)
    }
    
    class Coordinator: NSObject, BarcodeScannerDelegate{
        
        var scanner: BarcodeScanner
    
        init(_ parent : BarcodeScanner){
            scanner = parent
        }
        
        var rectOfInterest: CGRect {
            let mainBound = UIScreen.main.bounds
            return CGRect(x: (mainBound.size.width - 213) / 2, y: (mainBound.size.height - 193) / 2 , width: 213, height: 193)
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
    }
}

struct BarcodeView: View{
    var body: some View{
        ZStack{
            BarcodeScannerView()
            Image("scanArea")
        }.edgesIgnoringSafeArea(.all)
        .onAppear{
            print("onAppear")
        }
    }
}
