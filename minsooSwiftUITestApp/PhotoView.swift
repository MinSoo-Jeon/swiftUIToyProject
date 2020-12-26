//
//  photoView.swift
//  minsooSwiftUITestApp
//
//  Created by MinSoo Jeon on 2020/11/03.
//

import SwiftUI
import Photos

struct PhotoView: View {
    @State var imageArray = Array<UIImage>()
    
    var body: some View {
        ZStack{
            Color.blue
            List(imageArray, id: \.self){image in
                Image(uiImage: image)
            }
        }.edgesIgnoringSafeArea(.all)
        .onAppear(){
            requestImage().enumerateObjects{PHAsset,Int,Bool in
                let option = PHImageRequestOptions()
                option.isSynchronous = true;
                PHImageManager().requestImage(for: PHAsset, targetSize: CGSize(width: 100, height: 100), contentMode: .aspectFit, options: option, resultHandler: {UIImage,info  in
                    imageArray.append(UIImage!)
                })
            }
        }
    }
}

private func requestImage() -> PHFetchResult<PHAsset> {
    let permisssion = PHPhotoLibrary.authorizationStatus(for: .readWrite)
    
    switch permisssion {
    case .authorized, .limited:
        return getLocalImage()
    case .notDetermined:
        let semaphore = DispatchSemaphore(value: 0)
        var isAceess = false
        PHPhotoLibrary.requestAuthorization(for: .readWrite) { (status) in
            switch status{
            case .authorized, .limited:
                isAceess = true
            case .denied:
                isAceess = false
            default:
                isAceess = false
            }
            
            semaphore.signal();
        }
        
        semaphore.wait();
        
        if isAceess{
            return getLocalImage()
        }else{
            return PHFetchResult<PHAsset>()
        }
        
    case .denied:
        return PHFetchResult<PHAsset>()
    default:
        return PHFetchResult<PHAsset>()
    }
}

private func getLocalImage() -> PHFetchResult<PHAsset> {
    let option = PHFetchOptions()
    option.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
    return PHAsset.fetchAssets(with: .image, options: option)
}


struct PhotoView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoView()
    }
}
