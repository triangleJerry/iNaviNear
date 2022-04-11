//
//  CommonMapView.swift
//  iNaviNear
//
//  Created by 장은석 on 2022/04/11.
//

import SwiftUI
import iNaviMaps

struct CommonMapView: UIViewRepresentable {
    
    func updateUIView(_ uiView: InaviMapView, context: Context) {
        
    }
    
    func makeUIView(context: Context) -> InaviMapView {
        let view = InaviMapView()
        return view
    }
}

struct CommonMapView_Previews: PreviewProvider {
    static var previews: some View {
        NNMapView()
    }
}
