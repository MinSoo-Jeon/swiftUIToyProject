//
//  PushedView.swift
//  minsooSwiftUITestApp
//
//  Created by MinSoo Jeon on 2020/10/29.
//

import SwiftUI

struct PushedView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(content: {
                Color.blue
                VStack(content: {
                    Spacer().frame(height: 50 + geometry.safeAreaInsets.top)
                    Text("This is Pushed View").onTapGesture(count: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/, perform: {
                        presentationMode.wrappedValue.dismiss()
                    })
                    Spacer()
                })
            }).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/).navigationBarHidden(true)
        }
    }
}

struct PushedView_Previews: PreviewProvider {
    static var previews: some View {
        PushedView()
    }
}
