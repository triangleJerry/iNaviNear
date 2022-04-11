//
//  NNSettingView.swift
//  iNaviNear
//
//  Created by 장은석 on 2022/04/07.
//

import SwiftUI

struct NNSettingView: View {
    
    @State private var soundsToggle = true
    @State private var markersToggle = true
    @State private var stepperAmount = 10
    
    var body: some View {
        List {
            Section(header: Text("Options")) {
                
                Toggle(isOn: $soundsToggle, label: {
                    HStack {
                        Image(systemName: "bell")
                        Text("Sounds")
                        
                    }
                })
                
                Stepper(value: $stepperAmount, label: {
                    HStack {
                        Image(systemName: "magnifyingglass")
                        Text("Search radius")
                        
                    }
                    Text("\(stepperAmount) x")
                        .fontWeight(.bold)
                })
                
                Toggle(isOn: $markersToggle, label: {
                    HStack {
                        Image(systemName: "flag.slash")
                        Text("Markers Out of Zone")
                    }
                })
            }
        }
        .listStyle(InsetGroupedListStyle())
    }
}

struct NNSettingView_Previews: PreviewProvider {
    static var previews: some View {
        NNSettingView()
    }
}
