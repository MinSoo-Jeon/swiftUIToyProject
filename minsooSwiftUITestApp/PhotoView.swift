//
//  photoView.swift
//  minsooSwiftUITestApp
//
//  Created by MinSoo Jeon on 2020/11/03.
//

import SwiftUI
import Photos

struct PhotoView: View {
    @State private var imageArray = Array<PHAsset>()
    
    var body: some View {
        ZStack{
            Color.blue
            VStack{
                Text("Photo")
            }
        }.edgesIgnoringSafeArea(.all)
        .onAppear(){
            requestImage();
        }
    }
}

func requestImage() -> Void {
    let permisssion = PHPhotoLibrary.authorizationStatus(for: .readWrite)
    
    switch permisssion {
    case .authorized, .limited:
        print("grant")
        break
    case .notDetermined:
        PHPhotoLibrary.requestAuthorization(for: .readWrite) { (status) in
            switch status{
            case .authorized, .limited:
                break
            case .denied:
                break
            default:
                break
            }
        }
        break
    case .denied:
        print("denied");
        break
    default:
        print("default");
        break
    }
}


struct PhotoView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoView()
    }
}
