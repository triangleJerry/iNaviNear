//
//  ConvertXY.swift
//  iNaviNear
//
//  Created by 장은석 on 2022/04/25.
//

import SwiftUI
import Darwin

class ConvertXY {
    
    static func convertMap(lon: Double, lat: Double) -> (mapX: Int, mapY: Int) {
        
        var x: Float = 0.0, y: Float = 0.0
        var map: LamcParameter = LamcParameter()
        var defaultValue = Double(UserDefaults.standard.integer(forKey: "area"))
        
        map.grid = Float( defaultValue / 1000.0 )
        
        var PI: Double, DEGRAD: Double
        var re: Double, olon: Double, olat: Double, sn: Double, sf: Double, ro: Double
        var slat1: Double, slat2: Double, ra: Double, theta: Double
        
        PI = asin(1.0) * 2.0
        DEGRAD = PI / 180.0
        
        re = Double(map.Re / map.grid)
        slat1 = Double(map.slat1) * DEGRAD
        slat2 = Double(map.slat2) * DEGRAD
        olon = Double(map.olon) * DEGRAD
        olat = Double(map.olat) * DEGRAD
        
        sn = tan(PI * 0.25 + slat2 * 0.5) / tan(PI * 0.25 + slat1 * 0.5)
        sn = log(cos(slat1) / cos(slat2)) / log(sn)
        sf = tan(PI * 0.25 + slat1 * 0.5)
        sf = pow(sf, sn) * cos(slat1) / sn
        ro = tan(PI * 0.25 + olat * 0.5)
        ro = re * sf / pow(ro, sn)
        
        ra = tan(PI * 0.25 + lat * DEGRAD * 0.5)
        ra = re * sf / pow(ra, sn)
        theta = lon * DEGRAD - olon
        
        if theta > PI { theta -= 2.0 * PI }
        if theta < -PI { theta += 2.0 * PI }
        theta *= sn

        x = Float(ra * sin(theta)) + map.xo
        y = Float(ro - ra * cos(theta)) + map.yo
        
        return (mapX: Int(x + 1.5), mapY: Int(y + 1.5))
     }
}
