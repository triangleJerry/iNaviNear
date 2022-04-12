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
    
    func updateUIView(_ uiView: InaviMapView, context: Context) {
        
    }
    
    func makeUIView(context: Context) -> InaviMapView {
        var view = InaviMapView()
        
        var filepath = Bundle.main.path(forResource: "LakeLocation", ofType: "gpx")!
        let trkArray = gpxParser.parsingGpxFile(filepath: URL(fileURLWithPath: filepath), filename: .LakeLocation)
        
        filepath = Bundle.main.path(forResource: "CafeLocation", ofType: "gpx")!
        let cafeDic = gpxParser.parsingGpxFile(filepath: URL(fileURLWithPath: filepath), filename: .CafeLocation)
        
        ShapUtils.shapeINVRoute(trkDataArray: trkArray as! [TrkData], mapview: &view)
        ShapUtils.shapeINVMarker(markerDictionary: cafeDic as! [String : CafeData], mapview: &view)
        ShapUtils.shapeCircleRange(trkDataArray: trkArray as! [TrkData], mapview: &view)
        
        return view
    }
}

struct CommonMapView_Previews: PreviewProvider {
    static var previews: some View {
        NNMapView()
    }
}
