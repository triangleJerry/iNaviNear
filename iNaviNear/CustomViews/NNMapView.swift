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
    
    // 아이나비 맵뷰에서 마커 -> 정보창을 클릭했을 때, 북마크 등록을 위해 이벤트를 감지해주는 notification.
    let markerInfoWindowEvent = NotificationCenter.default.publisher(for: NSNotification.Name.markerInfoWindowEvent)
    
    @State private var showingAlert: Bool = false
    @State private var newDrawingMap: Bool = false
    
    
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
            Alert(title: Text("카페를 북마크에 등록하시겠습니까?"),
                  message: Text("북마크에 등록을 통해, 손쉽게 지도에서 해당 카페를 찾을 수 있습니다"),
                  primaryButton: .cancel(Text("취소"), action: {
                //some Action
            }),
                  secondaryButton: .default(Text("등록"), action: {
                // some Action
            }))
        }
        .onReceive(markerInfoWindowEvent) { _ in
            showingAlert.toggle()
        }
        .onAppear(perform: {
            ShapeObjectsBundle.shared.removeAllMapShapeObjects()
            ShapeObjectsBundle.shared.drawMapShapeObjects(mapView: mapView.mapInstance)
        })
    }
    
    init() {
        ShapeObjectsBundle.shared.drawMapShapeObjects(mapView: mapView.mapInstance)
    }
}

struct NNMapView_Previews: PreviewProvider {
    static var previews: some View {
        NNMapView()
    }
}
