//
//  GPXDataProtocol.swift
//  iNaviNear
//
//  Created by 장은석 on 2022/04/15.
//

import Foundation
import iNaviMaps

protocol GPXDataProtocol {
    
    var location: INVLatLng { get } // 위치 정보
}
