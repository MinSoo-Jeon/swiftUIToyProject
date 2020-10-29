//
//  HomePageView.swift
//  minsooSwiftUITestApp
//
//  Created by MinSoo Jeon on 2020/10/27.
//

import SwiftUI

struct HomePageView: View {
    
    @State private var isPresented = false
    
    var body: some View {
        ZStack(content: {
            Color.red
            VStack(content: {
                Spacer().frame(height : 50)
                Text("Modal presentation").foregroundColor(.white)
                    .onTapGesture(count: 1, perform: {
                        isPresented.toggle()
                    }).fullScreenCover(isPresented: $isPresented, content: {
                        FullModalView()
                    })
                Spacer().frame(height : 50)
                NavigationLink(destination: PushedView()){
                    Text("Navigation Link (Push)").foregroundColor(.white)
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
