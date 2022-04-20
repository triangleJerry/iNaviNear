//
//  NNBookMarkView.swift
//  iNaviNear
//
//  Created by 장은석 on 2022/04/07.
//

import SwiftUI

struct NNBookMarkView: View {
    
    @Binding var goIndex: Int
    
    var body: some View {
        List {
            Text("bookmark 1")
            Text("bookmark 2")
            Text("bookmark 3")
            Text("bookmark 4")
            Text("bookmark 5")
        }
        .listStyle(InsetGroupedListStyle())
    }
}

struct NNBookMarkView_Previews: PreviewProvider {
    static var previews: some View {
        NNBookMarkView(goIndex: .constant(1))
    }
}
