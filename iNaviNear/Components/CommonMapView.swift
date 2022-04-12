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
        let trkArray = gpxParser.parsingGpxFile(filepath: URL(fileURLWithPath: filepath), filename: .LakeLocation)

        filepath = Bundle.main.path(forResource: "CafeLocation", ofType: "gpx")!
        let cafeDic = gpxParser.parsingGpxFile(filepath: URL(fileURLWithPath: filepath), filename: .CafeLocation)

        ShapUtils.shapeINVRoute(trkDataArray: trkArray as! [TrkData], mapview: &mapInstance)
        ShapUtils.shapeINVMarker(markerDictionary: cafeDic as! [String : CafeData], mapview: &mapInstance)
        ShapUtils.shapeCircleRange(trkDataArray: trkArray as! [TrkData], mapview: &mapInstance)
    }
}

struct CommonMapView_Previews: PreviewProvider {
    static var previews: some View {
        NNMapView()
    }
}
