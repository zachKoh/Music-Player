//
//  SwiftUIChart.swift
//  SimpleMusicPlayer
//
//  Created by Admin on 07/02/2024.
//

import SwiftUI
import Charts

/**
 struct artistObj {
     let name: String
     let plays: Int
 }
 */

struct SwiftUIChart: View {
    
    var artists: [artistObj]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Favorite Artists")
                .font(.title2)
                .fontWeight(.semibold)
            Text("By amount of plays...")
                .font(.footnote)
                .foregroundStyle(.gray)
            
            Chart(artists, id: \.name) { artistObj in
                BarMark(
                    x: .value("Macros", artistObj.plays),
                    stacking: .normalized
                )
                .foregroundStyle(by: .value("Name", artistObj.name))
            }
            .frame(height:90)
            .chartXAxis(.hidden)
        }
        .padding()
    }
}
