//
//  MenuView.swift
//  minsooSwiftUITestApp
//
//  Created by MinSoo Jeon on 2020/10/28.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .center), content: {
            VStack{
                List{
                    NavigationLink(destination: CustomWebView(url: "https://www.apple.co.kr")){
                        Text("Apple")
                    }
                    NavigationLink(destination: CustomWebView(url: "https://www.google.co.kr")){
                        Text("Google")
                    }
                    NavigationLink(destination: CustomWebView(url: "https://m.naver.com")){
                        Text("Naver")
                    }
                    NavigationLink(destination: CustomWebView(url: "https://www.qxpress.net")){
                        Text("Qxpress")
                    }
                }.colorMultiply(.orange)
            }
        })
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
