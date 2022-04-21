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
    
    @ViewBuilder
    var body: some View {
        if bookmarkList.count == 0 {
            
            Text("즐겨찾기를 등록해 주세요.")
                .foregroundColor(.gray)
                .font(.system(size: 20))
                .fontWeight(.medium)
        } else {
            NavigationView { // onMove를 사용하기 위해서는 List를 NavigationView가 감싸줘야 한다.
                List {
                    ForEach(bookmarkList, id: \.self) {
                        Text($0)
                    }
                    .onDelete(perform: delete)
                    .onMove(perform: move)
                }
                .listStyle(InsetGroupedListStyle())
                .toolbar { EditButton() }
            }
            .navigationBarItems(trailing: EditButton())
        }
    }
    
    private func delete(at offsets: IndexSet) {
        
        bookmarkList.remove(atOffsets: offsets)
        UserDefaults.standard.set(bookmarkList, forKey: "bookmark")
    }
    
    private func move(from source: IndexSet, to destination: Int) {
        
        bookmarkList.move(fromOffsets: source, toOffset: destination)
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
