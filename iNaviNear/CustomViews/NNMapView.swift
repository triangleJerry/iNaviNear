//
//  NNMapView.swift
//  iNaviNear
//
//  Created by 장은석 on 2022/04/07.
//

import SwiftUI
import iNaviMaps

struct NNMapView: View {
    
    @Binding var goIndex: Int
    @Binding var bookmarkList: [String]
    
    @State private var showingAlert: Bool = false
    @State private var newDrawingMap: Bool = false
    @State private var showToast: Bool = false
    @State private var toastMessage: String = ""
    @State private var notiMarkerTitle: String = ""
    
    var mapView: CommonMapView = CommonMapView()
    var clusterManager: INVClusterManager? = nil
    
    // 아이나비 맵뷰에서 마커 -> 정보창을 클릭했을 때, 북마크 등록을 위해 이벤트를 감지해주는 notification.
    let markerInfoWindowEvent = NotificationCenter.default.publisher(for: NSNotification.Name.markerInfoWindowEvent)
    // 북마크뷰에서 리스트 셀을 클릭했을 때, 맵 뷰 이동 후 카메라를 해당 마커에 맞춰주기 위해 이벤트를 감지해주는 notification.
    let bookMarkClickEvent = NotificationCenter.default.publisher(for: NSNotification.Name.bookMarkClickEvent)
    
    var body: some View {
        
        ZStack(alignment: .bottomTrailing) {
            mapView
                .edgesIgnoringSafeArea([.top]) // 상단 노치부분까지 지도가 덮을 수 있도록
            
            SelfPositionButton(mapView: mapView.mapInstance)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 40, trailing: 40))
        }
        .onReceive(bookMarkClickEvent) { postData in
            let markerTitle: String = postData.object as! String
            self.focusingBookMarkMarker(markerTitle: markerTitle)
        }
        .onReceive(markerInfoWindowEvent) { postData in
            
            let marker = postData.object as! INVMarker
            notiMarkerTitle = marker.title
            
            showingAlert.toggle()
        }
        .alert(isPresented: $showingAlert) {
            
            Alert(title: Text("카페를 북마크에 등록하시겠습니까?"),
                  message: Text("북마크에 등록을 통해, 손쉽게 지도에서 해당 카페를 찾을 수 있습니다"),
                  primaryButton: .cancel(Text("취소"), action: {
                //some Action
                
            }),
                  secondaryButton: .default(Text("등록"), action: {
                // some Action
                
                let check = bookmarkList.contains(notiMarkerTitle)
                if check { // 해당 마커(카페)가 이미 즐겨찾기에 등록이 되어 있는 상태
                    
                    toastMessage = "이미 등록된 카페입니다."
                } else {
                    
                    bookmarkList.append(notiMarkerTitle)
                    UserDefaults.standard.set(bookmarkList, forKey: "bookmark")

                    toastMessage = "해당 카페가 즐겨찾기에 등록되었습니다."
                }
                showToast.toggle()
            }))
        }
        .onAppear(perform: {
            
            ShapeObjectsBundle.shared.removeAllMapShapeObjects()
            ShapeObjectsBundle.shared.drawMapShapeObjects(mapView: mapView.mapInstance)
        })
        .onDisappear(perform: {
          showToast = false
        })
        .toast(message: toastMessage, isShowing: $showToast, duration: Toast.short)
    }
    
    // 북마크뷰에서 리스트 셀을 클릭했을 때, 맵 뷰 이동 후 카메라를 해당 마커에 맞춰주는 메소드.
    private func focusingBookMarkMarker(markerTitle: String) {

        for item in ShapeObjectsBundle.shared.markerArray.enumerated() {
            if item.element.title == markerTitle {
                
                let cameraUpdate = INVCameraUpdate.init(
                    targetTo: INVLatLng(lat: item.element.position.lat, lng: item.element.position.lng), zoomTo: 16.5)
                cameraUpdate.animation = .fly
                cameraUpdate.animationDuration = 1.5
                mapView.mapInstance.moveCamera(cameraUpdate)
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.6) {
                    toastMessage = "\(markerTitle)로 이동했습니다."
                    showToast.toggle()
                }
            }
        }
    }
}

struct NNMapView_Previews: PreviewProvider {
    static var previews: some View {
        NNMapView(goIndex: .constant(0), bookmarkList: .constant([""]))
    }
}
