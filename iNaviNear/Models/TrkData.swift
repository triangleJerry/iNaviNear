//
//  TrkData.swift
//  iNaviNear
//
//  Created by 장은석 on 2022/04/07.
//

import Foundation
import iNaviMaps

struct TrkData: GPXDataProtocol {

    var ele: String = "" // 위치 정보: 고도
    var time: String = "" // 시간
    var location: INVLatLng = INVLatLng(lat: 0.00, lng: 0.00)  // 위치 정보
}
