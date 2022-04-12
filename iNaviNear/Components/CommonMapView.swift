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
    
    var mapInstance: InaviMapView = InaviMapView()
    
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

        ShapUtils.shapeINVRoute(trkDataArray: trkArray!, mapView: mapInstance)
        ShapUtils.shapeINVMarker(markerDictionary: cafeDic!, mapView: mapInstance)
        ShapUtils.shapeCircleRange(trkDataArray: trkArray!, mapView: mapInstance)
    }
}

struct CommonMapView_Previews: PreviewProvider {
    static var previews: some View {
        NNMapView()
    }
}
