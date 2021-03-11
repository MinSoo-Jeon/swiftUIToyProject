//
//  photoView.swift
//  minsooSwiftUITestApp
//
//  Created by MinSoo Jeon on 2020/11/03.
//

import SwiftUI
import Photos

struct PhotoData: Hashable, Identifiable {
    var id = UUID()
    var image:UIImage
    var title:String
}

class PhotoModel: NSObject, ObservableObject, PHPhotoLibraryChangeObserver{
    @Published var data: [PhotoData] = []
    
    override init(){
        super.init()
        PHPhotoLibrary.shared().register(self)
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
        var tempData:[PhotoData] = []
        let option = PHFetchOptions()
        option.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        let asset = PHAsset.fetchAssets(with: .image, options: option)
        asset.enumerateObjects{PHAsset,Int,Bool in
            let title = PHAsset.localIdentifier
            let option = PHImageRequestOptions()
            option.isSynchronous = true
            PHImageManager().requestImage(for: PHAsset, targetSize: CGSize(width: 100, height: 100), contentMode: .aspectFill, options: option, resultHandler: {UIImage,info  in
                    tempData.append(PhotoData(image: UIImage!, title: title))
            })
        }
        self.data = tempData
    }
    
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        DispatchQueue.main.async {
            self.getLocalImage()
        }
    }
}

struct RowView: View {
    var data: PhotoData
    var body: some View{
        HStack{
            Image(uiImage: data.image).resizable().aspectRatio(contentMode: .fit).frame(width: 100, height: 100)
            Text(data.title)
        }.frame(height: 100)
    }
}

struct PhotoView: View {
    @ObservedObject var photoModel: PhotoModel = PhotoModel()
    var body: some View {
        ZStack{
            List{
                ForEach(photoModel.data) { data in
                    RowView(data: data)
                }
            }
        }.edgesIgnoringSafeArea(.all)
        .onAppear{
            print("onAppear")
            DispatchQueue.main.async {
                photoModel.requestImage()
            }
        }
    }
}

struct PhotoView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoView()
    }
}
