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
    @State private var showingAlert: Bool = false
    @State private var newDrawingMap: Bool = false
    
    var mapView: CommonMapView = CommonMapView()
    var clusterManager: INVClusterManager? = nil
    
    // 아이나비 맵뷰에서 마커 -> 정보창을 클릭했을 때, 북마크 등록을 위해 이벤트를 감지해주는 notification.
    let markerInfoWindowEvent = NotificationCenter.default.publisher(for: NSNotification.Name.markerInfoWindowEvent)
    
    var body: some View {
        
        ZStack(alignment: .bottomTrailing) {
            mapView
                .edgesIgnoringSafeArea([.top]) // 상단 노치부분까지 지도가 덮을 수 있도록
            
            SelfPositionButton(mapView: mapView.mapInstance)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 40, trailing: 40))
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("카페를 북마크에 등록하시겠습니까?"),
                  message: Text("북마크에 등록을 통해, 손쉽게 지도에서 해당 카페를 찾을 수 있습니다"),
                  primaryButton: .cancel(Text("취소"), action: {
                //some Action
            }),
                  secondaryButton: .default(Text("등록"), action: {
                // some Action
                print("go")

                withAnimation {
                    self.goIndex = 1
                }
                
            }))
        }
        .onReceive(markerInfoWindowEvent) { postData in
            let marker = postData.object as! INVMarker
            let path = Bundle.main.path(forResource: "MyBookMark", ofType: "plist")!
            let dic = NSDictionary(contentsOfFile: path)!
            //print(dic)
            showingAlert.toggle()
        }
        .onAppear(perform: {
            ShapeObjectsBundle.shared.removeAllMapShapeObjects()
            ShapeObjectsBundle.shared.drawMapShapeObjects(mapView: mapView.mapInstance)
        })
    }
}

struct NNMapView_Previews: PreviewProvider {
    static var previews: some View {
        NNMapView(goIndex: .constant(0))
    }
}
