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
     var include: Bool = false  // 해당 카페가 탐색 범위에 포함되는지, 포함되지 않는지의 여부
     var bookmark: Bool = false  // 사용자의 즐겨찾기 여부
 }
