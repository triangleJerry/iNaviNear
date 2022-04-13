//
//  NNMapView.swift
//  iNaviNear
//
//  Created by 장은석 on 2022/04/07.
//

import SwiftUI
import iNaviMaps

struct NNMapView: View {
    
    var mapView: CommonMapView = CommonMapView()
    
    let notiEvent = NotificationCenter.default.publisher(for: NSNotification.Name("notiEvent"))
    
    @State private var showingAlert: Bool = false
    
    var body: some View {
        
        ZStack {
            mapView
                .edgesIgnoringSafeArea([.top])
        }
        .overlay(SelfPositionButton(mapView: mapView.mapInstance)
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 40, trailing: 40))
                 , alignment: .bottomTrailing
        )
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Title"), message: Text("message"), dismissButton: .default(Text("Dismiss")))
        }
        .onReceive(notiEvent) { _ in
            showingAlert.toggle()
        }
    }
}

struct NNMapView_Previews: PreviewProvider {
    static var previews: some View {
        NNMapView()
    }
}
