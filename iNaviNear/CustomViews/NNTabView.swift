//
//  NNTabView.swift
//  iNaviNear
//
//  Created by 장은석 on 2022/04/07.
//

import SwiftUI

struct NNTabView: View {
    @State var selection = 0
    @State var bookmarkList = UserDefaults.standard.array(forKey: "bookmark") as! [String]
    
    var body: some View {
        TabView(selection: $selection) {
            
            NNMapView(goIndex: $selection, bookmarkList: $bookmarkList)
                .tabItem {
                    Image(systemName: "map.fill")
                    Text("Map")
                }.tag(0)
            
            NNBookMarkView(goIndex: $selection, bookmarkList: $bookmarkList)
                .tabItem {
                    Image(systemName: "bookmark")
                    Text("BookMark")
                }.tag(1)
            
            NNSettingView(goIndex: $selection)
                .tabItem {
                    Image(systemName: "gear")
                    Text("Setting")
                }.tag(2)
        }
    }
}

struct NNTabView_Previews: PreviewProvider {
    static var previews: some View {
        NNTabView()
    }
}
