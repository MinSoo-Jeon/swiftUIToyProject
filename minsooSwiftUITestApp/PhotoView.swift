//
//  photoView.swift
//  minsooSwiftUITestApp
//
//  Created by MinSoo Jeon on 2020/11/03.
//

import SwiftUI
import Photos

class PhotoModel: NSObject, ObservableObject, PHPhotoLibraryChangeObserver{
    @Published var imageArray:Array<UIImage> = []
    
    override init(){
        super.init()
        PHPhotoLibrary.shared().register(self)
        self.requestImage()
    }
    
    func requestImage(){
        let permisssion = PHPhotoLibrary.authorizationStatus(for: .readWrite)
        switch permisssion {
        case .authorized, .limited:
            getLocalImage()
            break
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization(for: .readWrite, handler: { status in
                switch status{
                case .authorized, .limited:
                    self.getLocalImage()
                    break
                default:
                    print("did not auth")
                    break
                }
            })
            break
        default:
            print("did not auth")
            break
        }
    }
    
    func getLocalImage() {
        let option = PHFetchOptions()
        option.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        let asset = PHAsset.fetchAssets(with: .image, options: option)
        asset.enumerateObjects{PHAsset,Int,Bool in
            let option = PHImageRequestOptions()
            option.isSynchronous = true
            PHImageManager().requestImage(for: PHAsset, targetSize: CGSize(width: 100, height: 100), contentMode: .default, options: option, resultHandler: {UIImage,info  in
                DispatchQueue.main.async {
                    self.imageArray.append(UIImage!)
                }
            })
        }
    }
    
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        DispatchQueue.main.async {
            self.imageArray.removeAll()
            self.getLocalImage()
        }
    }
}

struct PhotoView: View {
    @ObservedObject var photoModel: PhotoModel = PhotoModel()
    var body: some View {
        ZStack{
            List(photoModel.imageArray, id: \.self){image in
                Image(uiImage: image).resizable().frame(width: 100, height:100)
            }
        }.edgesIgnoringSafeArea(.all)
    }
}

struct PhotoView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoView()
    }
}
