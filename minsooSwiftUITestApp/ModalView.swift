//
//  FullModalView.swift
//  minsooSwiftUITestApp
//
//  Created by MinSoo Jeon on 2020/10/29.
//

import SwiftUI

struct ModalView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(content: {
                Color.pink
                VStack(content: {
                    Spacer().frame(height: 50 + geometry.safeAreaInsets.top)
                    Text("This is Modal View").onTapGesture(count: 1, perform: {
                        presentationMode.wrappedValue.dismiss()
                    }).foregroundColor(.white)
                    Spacer()
                })
            }).ignoresSafeArea()
        }
    }
}

struct ModalView_Previews: PreviewProvider {
    static var previews: some View {
        ModalView()
    }
}
