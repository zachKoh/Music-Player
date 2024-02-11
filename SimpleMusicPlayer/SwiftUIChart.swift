//
//  SwiftUIChart.swift
//  SimpleMusicPlayer
//
//  Created by Admin on 07/02/2024.
//

import SwiftUI
import Charts

struct artist {
    let name: String
    let plays: Int
}

struct SwiftUIChart: View {
    
    var artists: [artist]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Favorite Artists")
                .font(.title2)
                .fontWeight(.semibold)
            Text("By amount of plays...")
                .font(.footnote)
                .foregroundStyle(.gray)
            
            Chart(artists, id: \.name) { artist in
                BarMark(
                    x: .value("Macros", artist.plays),
                    stacking: .normalized
                )
                .foregroundStyle(by: .value("Name", artist.name))
            }
            .frame(height:48)
            .chartXAxis(.hidden)
        }
        .padding()
    }
}
