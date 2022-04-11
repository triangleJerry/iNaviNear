//
//  GPXParser.swift
//  iNaviNear
//
//  Created by 장은석 on 2022/04/07.
//

import Foundation
import iNaviMaps

// iNaviNear -> Files
enum gpxfileName {
    case BacgUnLake
    case CafeLocation
}

class GPXParser: NSObject, XMLParserDelegate {
    
    // 태그 내부의 파싱한 정보를 전달해 주기 전까지 임시로 들고있는 객체.
    var foundCharacters: String = ""
    var location: INVLatLng = INVLatLng()
    var name: String = ""
    var time: String = ""
    var ele: String = ""
    
    var CafeDataDictionary: [String:CafeData] = [:]
    var TrkDataArray: [TrkeData] = []
    
    
    // MARK: Created function.
    
    // Any - 수정, success 부분 타입 정의 or 혹은 명칭 변경
    func parsingGpxFile(filepath: URL, filename: gpxfileName) -> Any? {
        
        let parser = XMLParser(contentsOf: filepath)!
        parser.delegate = self
        let success = parser.parse()
        if success {
            print("gpx file parsing is done.")
            switch filename {
            case .BacgUnLake:
                return TrkDataArray
            case .CafeLocation:
                return CafeDataDictionary
            }
        }
        else {
            print(parser.parserError.debugDescription)
        }
        return nil
    }
    
    func initMemberValue() {
        self.foundCharacters = ""
        self.location = INVLatLng()
        self.name = ""
        self.time = ""
        self.ele = ""
    }
    
    // MARK: XMLParserDelegate function.
    
    
    // XML 파싱을 시작하는 태그에서 이벤트 핸들링
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        foundCharacters = ""
        
        // ex: CafeLocation.gpx
        if elementName == "wpt" {
            
            guard let lat = attributeDict["lat"],
                  let lon = attributeDict["lon"] else {
                return
            }
            
            location = INVLatLng(lat: Double(lat)!, lng: Double(lon)!)
        }
        // ex: BaegUnLake.gpx
        else if elementName == "trkpt" {
            
            guard let lat = attributeDict["lat"],
                  let lon = attributeDict["lon"] else {
                return
            }
            
            location = INVLatLng(lat: Double(lat)!, lng: Double(lon)!)
        }
    }
    
    // 태그의 Data가 string으로 들어옴
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        foundCharacters += string // name, time, ele ...
    }
    
    // XML 파싱이 끝나는 태그에서 이벤트 핸들링
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if elementName == "name" {
            name = foundCharacters
        } else if elementName == "time" {
            time = foundCharacters
        } else if elementName == "ele" {
            ele = foundCharacters
        } else if elementName == "wpt" {
            var cafeData = CafeData()
            cafeData.name = name
            cafeData.location = location
            cafeData.star = String( Int.random(in: 1...5) )
            CafeDataDictionary[cafeData.name] = cafeData
        } else if elementName == "trkpt" {
            var trkData = TrkeData()
            trkData.ele = ele
            trkData.time = time
            trkData.location = location
            TrkDataArray.append(trkData)
        }
        
        foundCharacters = ""
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        
        for cafedata in CafeDataDictionary.values {
            print(cafedata.name, cafedata.location.lat, cafedata.location.lng)
        }
        
        for (item, index) in TrkDataArray.enumerated() {
            print(item, index)
        }
    }
}
