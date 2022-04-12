//
//  SelfPositionButton.swift
//  iNaviNear
//
//  Created by 장은석 on 2022/04/11.
//

import SwiftUI
import iNaviMaps

struct SelfPositionButton: View {
    var mapView: InaviMapView
    
    var body: some View {
        Button(action: {
            HapticManager.instance.impact(style: .heavy)
            moveLakePosition(mapView: mapView)
        }) {
            Image(systemName: "scope")
                .resizable()
                .scaledToFill()
                .frame(width: 40.0, height: 40.0)
                .clipped() // 프레임을 벗어나는 이미지 제거
                .padding(8)
        }
        .background(Color.white)
        .cornerRadius(15)
        .onTapGesture {
            let impactHeavy = UIImpactFeedbackGenerator(style: .heavy)
            impactHeavy.impactOccurred()
        }
    }
    
    // 현재는 호수 위치로 이동하는 로직이지만, 추후 자기 자신의 위치로 이동하는 로직으로 변경 필요.
    private func moveLakePosition(mapView: InaviMapView) {
        // 대상 지점, 줌 레벨을 지정하여 INVCameraPosition 객체 생성
        // 기울기 각도와 베어링 각도는 0으로 설정된다.
        let cameraPosition = INVCameraPosition.init(
            INVLatLng(lat: 37.3792735, lng: 127.0054000),
            zoom: 14.0)
        
        // 카메라의 위치 설정
        mapView.cameraPosition = cameraPosition
    }
}

struct SelfPositionButton_Previews: PreviewProvider {
    static var previews: some View {
        SelfPositionButton(mapView: InaviMapView())
            .previewLayout(.fixed(width: 260, height: 220))
    }
}
