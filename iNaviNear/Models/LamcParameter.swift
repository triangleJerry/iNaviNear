//
//  LamcParameter.swift
//  iNaviNear
//
//  Created by 장은석 on 2022/04/25.
//

struct LamcParameter {
    var Re: Float // 사용할 지구반경 [Km]
    var grid: Float // 격자간격
    var slat1: Float // 표준위도 [Degree]
    var slat2: Float // 표준위도 [Degree]
    var olon: Float // 기준점의 경도 [Degree]
    var olat: Float // 기준점의 위도 [Degree]
    var xo: Float // 기준점의 X좌표 [격자거리]
    var yo: Float // 기준점의 Y좌표 [격자거리]
    
    init() {
        self.Re = 6371.00877 // 지도변경
        self.grid = 0.555 // 격자간격 (km)
        self.slat1 = 30.0 // 표준위도 1
        self.slat2 = 60 // 표준위도 2
        self.olon = 126.0 // 기준점 경도
        self.olat = 38.0 // 기준점 위도
        self.xo = 210/self.grid // 기준점 X좌표
        self.yo = 675/self.grid // 기준점 Y좌표
    }
}


