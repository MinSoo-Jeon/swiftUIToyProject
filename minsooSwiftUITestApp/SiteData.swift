//
//  SiteData.swift
//  minsooSwiftUITestApp
//
//  Created by MinSoo Jeon on 2020/10/30.
//

import SwiftUI
import Combine

struct SiteData: Identifiable{
    var id = UUID()
    var siteName = ""
    var siteUrl = ""
}

final class SiteDataArray: ObservableObject{
    @Published var siteData : [SiteData] = [SiteData(siteName: "Apple", siteUrl: "https://www.apple.co.kr"),
                               SiteData(siteName: "Google", siteUrl: "https://www.google.co.kr"),
                               SiteData(siteName: "Naver", siteUrl: "https://m.naver.com"),
                               SiteData(siteName: "Daum", siteUrl: "https://m.daum.net"),
                               SiteData(siteName: "Qoo10", siteUrl: "http://m.qoo10.com"),
                               SiteData(siteName: "Qxpress", siteUrl: "http://www.qxpress.net")]
}
