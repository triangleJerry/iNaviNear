//
//  NNMapView.swift
//  iNaviNear
//
//  Created by 장은석 on 2022/04/07.
//

import SwiftUI
import iNaviMaps

struct NNMapView: UIViewRepresentable {
    
    func updateUIView(_ uiView: InaviMapView, context: Context) {
        
    }
    
    func makeUIView(context: Context) -> InaviMapView {
        let view = InaviMapView()
        
        return view
    }
}

struct NNMapView_Previews: PreviewProvider {
    static var previews: some View {
        PreViewDev(source: NNMapView())
    }
}
