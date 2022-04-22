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
    
    // bookmarkList.count를 통해 직접적으로 참조해 뷰를 전환하게 되면 삭제 이후 Binding을 통해 객체가 바뀔 때, 앱이 크래시 되기 때문에 간접적으로 참조한다.
    @State private var bookmarkCount: Int = 0
    
    var body: some View {
        NavigationView { // onMove를 사용하기 위해서는 List를 NavigationView가 감싸줘야 한다.
            if bookmarkCount == 0 {
                Text("즐겨찾기를 등록해 주세요.")
                    .foregroundColor(.gray)
                    .font(.system(size: 20))
                    .fontWeight(.medium)
            } else {
                List {
                    ForEach(bookmarkList, id: \.self) { bookmark in
                        Text(bookmark)
                            .onTapGesture() {
                                HapticManager.instance.impact(style: .medium)
                                withAnimation {
                                    self.goIndex = 0
                                }
                                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
                                    NotificationCenter.default.post(name: Notification.Name.bookMarkClickEvent, object: bookmark)
                                }
                            }
                    }
                    .onDelete(perform: delete)
                    .onMove(perform: move)
                }
                .listStyle(InsetGroupedListStyle())
                .toolbar { EditButton() }
            }
        }
        .navigationBarItems(trailing: EditButton())
        .onAppear() {
            bookmarkCount = bookmarkList.count
        }
    }
    
    private func delete(at offsets: IndexSet) {
        
        bookmarkList.remove(atOffsets: offsets)
        bookmarkCount -= 1
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
