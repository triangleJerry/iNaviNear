//
//  CommonMapView.swift
//  iNaviNear
//
//  Created by 장은석 on 2022/04/11.
//

import SwiftUI
import iNaviMaps

struct CommonMapView: UIViewRepresentable {
    
    let gpxParser = GPXParser()
    
    var mapInstance: InaviMapView = InaviMapView() // 맵 뷰의 맵 인스턴스.
    
    var circleArray: [INVCircle] = []
    
    func updateUIView(_ uiView: InaviMapView, context: Context) {

    }
    
    func makeUIView(context: Context) -> InaviMapView {

        return mapInstance
    }
    
    init() {
        var filepath = Bundle.main.path(forResource: "LakeLocation", ofType: "gpx")!
        let trkArray = gpxParser.parsingLakeLocationGPX(filepath: URL(fileURLWithPath: filepath))

        filepath = Bundle.main.path(forResource: "CafeLocation", ofType: "gpx")!
        let cafeDic = gpxParser.parsingCafeLocationGPX(filepath: URL(fileURLWithPath: filepath))

        ShapeUtils.shapeINVRoute(trkDataArray: trkArray!, mapView: mapInstance)
        ShapeUtils.shapeCircleRange(trkDataArray: trkArray!, mapView: mapInstance, circleArray: &circleArray)
        ShapeUtils.shapeINVMarker(markerDictionary: cafeDic!, mapView: mapInstance, circleArray: &circleArray)
    }
}

struct CommonMapView_Previews: PreviewProvider {
    static var previews: some View {
        NNMapView()
    }
}
