//
//  ContentView.swift
//  minsooSwiftUITestApp
//
//  Created by MinSoo Jeon on 2020/10/27.
//

import SwiftUI

enum MainTabType: Int{
    case home = 1
    case tracking = 2
    case delivery = 3
    case notice = 4
}

struct ContentView: View {
    let homePageView = HomePageView()
    @State private var homePageZIndex = 2.0
    let trackingView = TrackingView()
    @State private var trackingPageZIndex = 1.0
    let deliveryView = DeliveryView()
    @State private var deliveryPageZIndex = 1.0
    let noticeView = NoticeView()
    @State private var noticePageZIndex = 1.0
    @State private var currentTab = MainTabType.home
    let menuView = MenuView()
    @State private var isMenuViewShown = false
    @State private var menuViewWidth : CGFloat = UIScreen.main.bounds.size.width
    
    func getStatusBarColor(selectTag : MainTabType) -> Color {
        switch selectTag {
        case .home:
            return Color.red
        case .tracking:
            return Color.blue
        case .delivery:
            return Color.green
        case .notice:
            return Color.purple
        }
    }
    
    func changeTab(selectTag : MainTabType){
        homePageZIndex = (selectTag == .home) ? 2.0 : 1.0
        trackingPageZIndex = (selectTag == .tracking) ? 2.0 : 1.0
        deliveryPageZIndex = (selectTag == .delivery) ? 2.0 : 1.0
        noticePageZIndex = (selectTag == .notice) ? 2.0 : 1.0
        currentTab = selectTag
    }
    
    func getCurrentView(selectTag : MainTabType) -> AnyView{
        switch selectTag {
        case .home:
            return AnyView(homePageView)
        case .tracking:
            return AnyView(trackingView)
        case .delivery:
            return AnyView(deliveryView)
        case .notice:
            return AnyView(noticeView)
        }
    }
    
    func tabBtn(actionBlock : @escaping () -> Void, image :  Image) -> AnyView{
        return AnyView(Button(action :  {
            actionBlock()
        }) { image.resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width:  UIScreen.main.bounds.size.width/5 - 40 , height: 50, alignment: .center)
        }.frame(width:  UIScreen.main.bounds.size.width/5, height: 60).foregroundColor(.gray) )
    }
    
    var body: some View {
       NavigationView{
            GeometryReader { geometry in
                ZStack(alignment: Alignment(horizontal: .leading, vertical: .center), content: {
                    VStack(spacing:0.0){
                        getStatusBarColor(selectTag: currentTab).frame(width: geometry.size.width, height: geometry.safeAreaInsets.top, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).edgesIgnoringSafeArea(.all)
                        ZStack(content: {
                            homePageView.zIndex(homePageZIndex);
                            trackingView.zIndex(trackingPageZIndex);
                            deliveryView.zIndex(deliveryPageZIndex);
                            noticeView.zIndex(noticePageZIndex);
                        }).frame(width: UIScreen.main.bounds.size.width, height:UIScreen.main.bounds.size.height - 60 - geometry.safeAreaInsets.top - geometry.safeAreaInsets.bottom, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        HStack(spacing: 0.0){
                            tabBtn(actionBlock: {
                                withAnimation{
                                    self.isMenuViewShown.toggle()
                                }
                            }, image: Image(systemName: "list.star"))
                            
                            tabBtn(actionBlock: {
                                changeTab(selectTag: .home)
                            }, image: currentTab == .home ?  Image(systemName: "house.fill") :  Image(systemName: "house"))
                            
                            tabBtn(actionBlock: {
                                changeTab(selectTag: .tracking)
                            }, image: currentTab == .tracking ?  Image(systemName: "magnifyingglass.circle.fill") :  Image(systemName: "magnifyingglass.circle"))
                            
                            tabBtn(actionBlock: {
                                changeTab(selectTag: .delivery)
                            }, image: currentTab == .delivery ?  Image(systemName: "bus.fill") :  Image(systemName: "bus"))
                            
                            tabBtn(actionBlock: {
                                changeTab(selectTag: .notice)
                            }, image: currentTab == .notice ?  Image(systemName: "megaphone.fill") :  Image(systemName: "megaphone"))
                            
                        }.frame(width: UIScreen.main.bounds.size.width, height: 60, alignment: .center).background(Color.white).edgesIgnoringSafeArea(.all)
                        Color.white.frame(width: UIScreen.main.bounds.size.width, height: geometry.safeAreaInsets.bottom, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    }
                    if isMenuViewShown {
                        menuView.frame(width: menuViewWidth, height:  UIScreen.main.bounds.size.height, alignment: .leading).transition(.asymmetric(insertion: .slide, removal: .slide)).onTapGesture(count: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/, perform: {
                            withAnimation{
                                self.menuViewWidth = 0
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25, execute: {
                                self.isMenuViewShown.toggle()
                                self.menuViewWidth = UIScreen.main.bounds.size.width
                            })
                        })
                    }
                   
                }).navigationBarHidden(true).edgesIgnoringSafeArea(.all).background(Color.blue)
            }
       }.navigationViewStyle(StackNavigationViewStyle())
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
