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
    
    var body: some View {
        ZStack(content: {
            Color.red
            VStack(content: {
                Spacer().frame(height : 50)
                Text("FullScreen Modal").foregroundColor(.white)
                    .onTapGesture(count: 1, perform: {
                        isFullPresented.toggle()
                    }).fullScreenCover(isPresented: $isFullPresented, content: {
                        ModalView()
                    })
                Spacer().frame(height : 50)
                NavigationLink(destination: PushedView()){
                    Text("Navigation Link (Push)").foregroundColor(.white)
                }
                Spacer().frame(height : 50)
                Text("Sheet (Present)").foregroundColor(.white).sheet(isPresented: $isSheetPresented, content: {
                    ModalView()
                }).onTapGesture(count: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/, perform: {
                    isSheetPresented.toggle()
                })
                Spacer().frame(height : 50)
                
                if UIDevice.current.userInterfaceIdiom == .pad{
                    Text("PopOver").foregroundColor(.white).onTapGesture(count: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/, perform: {
                        isPopOverPresented.toggle()
                    }).popover(isPresented: $isPopOverPresented) {
                        VStack{
                            Text("A").frame(width: 100, height: 100, alignment: .center).onTapGesture(count: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/, perform: {
                                isPopOverPresented.toggle()
                            })
                        }
                    }
                }
                
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
