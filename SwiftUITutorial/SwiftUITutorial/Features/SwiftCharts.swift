//
//  SwiftCharts.swift
//  SwiftUITutorial
//
//  Created by Nap Works on 02/09/23.
//

import SwiftUI
import Charts

struct SwiftCharts: View {
    var body: some View {
        let barColors: [Color] = [.red, .black, .blue, .green, .yellow, .purple, .teal]
        Chart(sampleDownloads) { item in
            AreaMark (
                x: .value("Day", item.day),
                y: .value("Downloads", item.downloads)
            )
//            .symbol(by: .value("Day", item.day))
//            .foregroundStyle(.red)
//            .interpolationMethod(.catmullRom)
//            .lineStyle(StrokeStyle(lineWidth: 6))
//            .foregroundStyle(by: .value("Day", item.day))
            RuleMark(
                y: .value("Mid", 250)
            )
            .foregroundStyle(.red)
        }
//        .chartForegroundStyleScale(
//            domain: sampleDownloads.compactMap({ download-> String? in
//                download.day
//            }),
//             range: barColors
//        )
        .frame(height: 300)
    }
}

struct SwiftCharts_Previews: PreviewProvider {
    static var previews: some View {
        SwiftCharts()
    }
}

//MARK: - Sample Model and Data

struct Download: Identifiable {
    var id = UUID().uuidString
    var day: String
    var downloads: Double
}

var sampleDownloads: [Download] = [
  Download(day: "Mon", downloads: 100),
  Download(day: "Tue", downloads: 200),
  Download(day: "Wed", downloads: 350),
  Download(day: "Thu", downloads: 420),
  Download(day: "Fri", downloads: 580),
  Download(day: "Sat", downloads: 90),
  Download(day: "Sun", downloads: 900),
]
