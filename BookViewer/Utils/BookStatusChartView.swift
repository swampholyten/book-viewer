//
//  BookStatusChartView.swift
//  BookViewer
//
//  Created by junkai ji on 06/07/24.
//

import SwiftUI
import Charts

struct BookStatusChartView: View {
    @EnvironmentObject var viewModel: ProfileViewModel

    var body: some View {
        Chart(viewModel.bookStatusData) { data in
            SectorMark(
                angle: .value("Count", data.count),
                innerRadius: .ratio(0.5),
                outerRadius: .ratio(1.0)
            )
            .foregroundStyle(by: .value("Status", data.status))
        }
        .chartForegroundStyleScale([
            "Read" : .pink,
            "Unread": .gray])
        .frame(height: 220)
        .padding()
        .chartLegend(.visible)
        .chartLegend(position: .bottom)
        .padding(.top, 28)
    }
}
