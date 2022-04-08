//
//  NNMapView.swift
//  iNaviNear
//
//  Created by 장은석 on 2022/04/07.
//

import SwiftUI
import iNaviMaps

struct NNMapView: UIViewRepresentable {
    
    let gpxParser = GPXParser()
    
    func updateUIView(_ uiView: InaviMapView, context: Context) {
        
    }
    
    func makeUIView(context: Context) -> InaviMapView {
        let view = InaviMapView()
        
        return view
    }
    
    init() {
        //let filepath = Bundle.main.path(forResource: "CafeLocation", ofType: "gpx")!
        let filepath = Bundle.main.path(forResource: "BaegUnLake", ofType: "gpx")!
        let cafeDic = gpxParser.parsingGpxFile(filepath: URL(fileURLWithPath: filepath), filename: .CafeLocation)
    }
}

struct NNMapView_Previews: PreviewProvider {
    static var previews: some View {
        PreViewDev(source: NNMapView())
    }
}
