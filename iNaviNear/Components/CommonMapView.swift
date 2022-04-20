//
//  CommonMapView.swift
//  iNaviNear
//
//  Created by 장은석 on 2022/04/11.
//

import SwiftUI
import iNaviMaps

struct CommonMapView: UIViewRepresentable {
    
    var mapInstance: InaviMapView = InaviMapView() // 맵 뷰의 맵 인스턴스.
    
    func updateUIView(_ uiView: InaviMapView, context: Context) {
    }
    
    func makeUIView(context: Context) -> InaviMapView {
        return mapInstance
    }
    
    init() {
        mapInstance.showLocationButton = true // 현위치 버튼 표출
        mapInstance.showZoomControl = true // 줌 컨트롤러를 표출
    }
}

struct CommonMapView_Previews: PreviewProvider {
    static var previews: some View {
        CommonMapView()
    }
}
