//
//  CafeData.swift
//  iNaviNear
//
//  Created by 장은석 on 2022/04/07.
//

import Foundation
import iNaviMaps

struct CafeData: GPXDataProtocol {

     var name: String = ""  // 카페 이름
     var star: String = ""  // 카페의 별점, 간단한 구현을 위해 1~5점 사이를 랜덤으로 생성해 줍니다
     var location: INVLatLng = INVLatLng(lat: 0.00, lng: 0.00)  // 위치 정보
 }
