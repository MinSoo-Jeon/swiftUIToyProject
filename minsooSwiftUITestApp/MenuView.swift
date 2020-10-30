//
//  MenuView.swift
//  minsooSwiftUITestApp
//
//  Created by MinSoo Jeon on 2020/10/28.
//

import SwiftUI

struct MenuView: View {
    @EnvironmentObject var siteDataArray: SiteDataArray
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .center), content: {
            VStack{
                List{
                    ForEach(siteDataArray.siteData){ siteData in
                        NavigationLink(destination: CustomWebView(url: siteData.siteUrl)){
                            Text(siteData.siteName)
                        }.frame(height: 40)
                    }
                }.colorMultiply(.orange)
            }
        })
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView().environmentObject(SiteDataArray())
    }
}
