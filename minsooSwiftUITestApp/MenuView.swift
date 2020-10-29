//
//  MenuView.swift
//  minsooSwiftUITestApp
//
//  Created by MinSoo Jeon on 2020/10/28.
//

import SwiftUI

struct MenuView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .center), content: {
            Color.orange
            VStack{
                List{
                    Text("1")
                    Text("2")
                    Text("3")
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
