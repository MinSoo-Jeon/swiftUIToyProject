//
//  MenuView.swift
//  minsooSwiftUITestApp
//
//  Created by MinSoo Jeon on 2020/10/28.
//

import SwiftUI

struct MenuView: View {
    @State private var menuViewWidth : CGFloat = UIScreen.main.bounds.size.width * 0.6
    @State var orientation = UIDevice.current.orientation
    let orientationChanged = NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)
        .makeConnectable()
        .autoconnect()
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .center), content: {
            Color.orange
            VStack{
                List{
                    NavigationLink(destination: PushedView()){
                        Text("Push")
                    }
                    Text("2")
                    Text("3")
                    Text("4")
                }.colorMultiply(.orange)
            }
        }) .onReceive(orientationChanged) { _ in
            menuViewWidth = UIScreen.main.bounds.size.width * 0.6
           }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
