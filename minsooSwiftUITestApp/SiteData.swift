//
//  SiteData.swift
//  minsooSwiftUITestApp
//
//  Created by MinSoo Jeon on 2020/10/30.
//

import SwiftUI
import Combine

struct SiteData: Identifiable{
    var id: Int
    var siteName = "";
    var siteUrl = "";
}

final class SiteDataArray: ObservableObject{
    @Published var siteData : [SiteData] = [SiteData(id: 0, siteName: "Apple", siteUrl: "https://www.apple.co.kr"),
                               SiteData(id: 1, siteName: "Google", siteUrl: "https://www.google.co.kr"),
                               SiteData(id: 2, siteName: "Naver", siteUrl: "https://m.naver.com"),
                               SiteData(id: 3, siteName: "Daum", siteUrl: "https://m.daum.net"),
                               SiteData(id: 4, siteName: "Qxpress", siteUrl: "https://www.qxpress.net")]
}
