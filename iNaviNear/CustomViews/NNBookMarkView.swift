//
//  NNBookMarkView.swift
//  iNaviNear
//
//  Created by 장은석 on 2022/04/07.
//

import SwiftUI

struct NNBookMarkView: View {
    
    @Binding var goIndex: Int
    @Binding var bookmarkList: [String]
    
    var body: some View {
        List {
            ForEach(bookmarkList, id: \.self) {
                Text($0)
            }
            .onDelete(perform: delete)
        }
        .listStyle(InsetGroupedListStyle())
    }
    
    private func delete(at offsets: IndexSet) {
        bookmarkList.remove(atOffsets: offsets)
        UserDefaults.standard.set(bookmarkList, forKey: "bookmark")
    }
}

struct NNBookMarkView_Previews: PreviewProvider {
    static var previews: some View {
        NNBookMarkView(goIndex: .constant(1), bookmarkList: .constant([""]))
    }
}

//                withAnimation {
//                    self.goIndex = 1
//                }
