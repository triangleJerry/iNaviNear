//
//  INVMyItem.swift
//  iNaviNear
//
//  Created by 장은석 on 2022/04/19.
//

import Foundation
import iNaviMaps

class INVMyItem: NSObject, INVClusterItem {
    
    var position: INVLatLng
    var title: String
    
    init(position: INVLatLng, title: String) {
        
        self.position = position
        self.title = title
    }
}
