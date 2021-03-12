//
//  HomePageView.swift
//  minsooSwiftUITestApp
//
//  Created by MinSoo Jeon on 2020/10/27.
//

import SwiftUI

struct HomePageView: View {
    
    @State private var isFullPresented = false
    @State private var isSheetPresented = false
    @State private var isPopOverPresented = false
    @State private var isPhotoViewPresented = false
    @State private var isBarcodeViewPresented = false
    
    var body: some View {
        ZStack(content: {
            Color.red
            VStack(spacing: 50,content: {
                Spacer().frame(height: 0)
                Text("FullScreen Modal").foregroundColor(.white)
                    .onTapGesture(count: 1, perform: {
                        isFullPresented.toggle()
                    }).fullScreenCover(isPresented: $isFullPresented, content: {
                        ModalView()
                    })
                NavigationLink(destination: PushedView()){
                    Text("Navigation Link (Push)").foregroundColor(.white)
                }
                Text("Sheet (Present)").foregroundColor(.white).sheet(isPresented: $isSheetPresented, content: {
                    ModalView()
                }).onTapGesture(count: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/, perform: {
                    isSheetPresented.toggle()
                })
                Text("Photo").foregroundColor(.white).sheet(isPresented: $isPhotoViewPresented, content: {
                    PhotoView()
                }).onTapGesture(count: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/, perform: {
                    isPhotoViewPresented.toggle()
                })
                Text("Barcode").foregroundColor(.white).sheet(isPresented: $isBarcodeViewPresented, content: {
                    BarcodeView()
                }).onTapGesture(count: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/, perform: {
                    isBarcodeViewPresented.toggle()
                })
                Spacer()
            })
        })
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}
