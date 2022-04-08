//
//  NNTabView.swift
//  iNaviNear
//
//  Created by 장은석 on 2022/04/07.
//

import SwiftUI

struct NNTabView: View {
    var body: some View {
        TabView {
            NNMapView()
                .tabItem {
                    Image(systemName: "map.fill")
                    Text("Map")
                }
            
            NNBookMarkView()
                .tabItem {
                    Image(systemName: "bookmark")
                    Text("BookMark")
                }
            
            NNSettingView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Setting")
                }
        }
    }
}

struct NNTabView_Previews: PreviewProvider {
    static var previews: some View {
        NNTabView()
    }
}
