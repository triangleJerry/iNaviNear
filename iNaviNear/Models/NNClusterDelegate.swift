//
//  test.swift
//  iNaviNear
//
//  Created by 장은석 on 2022/04/26.
//

import iNaviMaps

class NNClusterDelegate: NSObject, INVClusterManagerDelegate {
    
    // 델리게이트 함수 구현
    // '클러스터'가 그려지는 시점에 호출되는 델리게이트 함수
    func clusterManager(_ clusterManager: INVClusterManager, willRenderCluster cluster: INVCluster, with markerOptions: INVMarkerOptions) {
        
        markerOptions.position = cluster.position
    }
    
    // '아이템'이 그려지는 시점에 호출되는 델리게이트 함수
    func clusterManager(_ clusterManager: INVClusterManager, willRenderClusterItem clusterItem: INVClusterItem, with markerOptions: INVMarkerOptions) {
        if let item = clusterItem as? INVMyItem {
            markerOptions.title = item.title
        }
        
        markerOptions.position = clusterItem.position
        for (_, item) in ShapeObjectsBundle.shared.markerArray.enumerated() {
            if item.position == clusterItem.position {
                markerOptions.iconImage = item.iconImage
                return
            }
        }
        markerOptions.iconImage = INV_MARKER_IMAGE_GRAY
    }
    
    // '클러스터'가 클릭된 시점에 호출되는 델리게이트 함수
    func clusterManager(_ clusterManager: INVClusterManager, didTap cluster: INVCluster, with markerOptions: INVMarkerOptions) -> Bool {
        print("클러스터 클릭")
        return true // 이벤트 소비 여부. false이면 지도로 이벤트가 전달됨
    }
    
    // '아이템'이 클릭된 시점에 호출되는 델리게이트 함수
    func clusterManager(_ clusterManager: INVClusterManager, didTap clusterItem: INVClusterItem, with markerOptions: INVMarkerOptions) -> Bool {
        print("아이템 클릭")
        HapticManager.instance.impact(style: .medium)
        if let item = clusterItem as? INVMyItem {
            NotificationCenter.default.post(name: Notification.Name.markerInfoWindowEvent, object: item.title)
        }
        return true // 이벤트 소비 여부. false이면 지도로 이벤트가 전달됨
    }
}
