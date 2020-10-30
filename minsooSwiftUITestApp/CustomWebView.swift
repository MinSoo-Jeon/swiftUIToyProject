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
            Button("back", action: {
                presentationMode.wrappedValue.dismiss()
            }).frame(width: 100,height:40)
            WebView(url: url)
        }.foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/).navigationBarHidden(true)
    }
}

struct CustomWebView_Previews: PreviewProvider {
    static var previews: some View {
        CustomWebView(url:"https://www.google.com")
    }
}
