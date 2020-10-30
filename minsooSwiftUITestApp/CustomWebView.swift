//
//  CustomWebView.swift
//  minsooSwiftUITestApp
//
//  Created by MinSoo Jeon on 2020/10/30.
//

import SwiftUI

struct CustomWebView: View {
    var url:String
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack(alignment: .leading, spacing: 0.0){
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }){
                HStack(spacing:10.0){
                    Image(systemName: "chevron.backward")
                    Text("Back")
                }
            }.frame(height:40).padding(.leading)
            WebView(url: url)
        }.foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/).navigationBarHidden(true)
    }
}

struct CustomWebView_Previews: PreviewProvider {
    static var previews: some View {
        CustomWebView(url:"https://www.google.com")
    }
}
