//
//  SwiftUIChart.swift
//  SimpleMusicPlayer
//
//  Created by Admin on 07/02/2024.
//

import SwiftUI
import Charts

struct MacroData {
    let name: String
    let value: Int
}

struct SwiftUIChart: View {
    
    @State private var macros: [MacroData] = [
        .init(name: "Protein", value: 180),
        .init(name: "Carbs", value: 250),
        .init(name: "Fats", value: 55)
    ]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Macros")
                .font(.title2)
                .fontWeight(.semibold)
            Text("Daily breakdown")
                .font(.footnote)
                .foregroundStyle(.gray)
            
            Chart(macros, id: \.name) { macro in
                BarMark(
                    x: .value("Macros", macro.value),
                    stacking: .normalized
                )
                .foregroundStyle(by: .value("Name", macro.name))
            }
            .frame(height:48)
            .chartXAxis(.hidden)
        }
        .padding()
    }
}
