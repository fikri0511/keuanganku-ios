//
//  LaporanView.swift
//  KeuanganKu
//
//  Created by Nabil Alviro on 27/01/26.
//

import SwiftUI

struct LaporanView: View {
    @State private var selectedTab = 0
    
    var body: some View{
        ScrollView{
            VStack(spacing: 20){
                
                header
                
                HStack(spacing: 4){
                    segmentButton(title: "Mingguan", index:0)
                    segmentButton(title: "Bulanan", index:1)
                }
                .padding(4)
                .background(Color(.systemGray5))
                .cornerRadius(14)
                
                if selectedTab == 0{
                    WeeklyReportView()
                } else {
                    MonthlyReportView()
                    
                }
            }
            
            .padding()
            .padding(.bottom, 140)
        }
        .background(Color(.secondarySystemBackground))
    }
    @ViewBuilder
    private func segmentButton(title: String, index: Int) -> some View {
        let gradient = LinearGradient(
            colors: [
                Color(red: 0.05, green: 0.55, blue: 0.45),
                Color(red: 0.02, green: 0.35, blue: 0.30)
            ],
            startPoint: .leading,
            endPoint: .trailing
        )

        Button {
            withAnimation(.easeInOut) {
                selectedTab = index
            }
        } label: {
            Text(title)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(selectedTab == index ? .white : .gray)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 10)
                .background {
                    Group {
                        if selectedTab == index {
                            gradient
                        } else {
                            Color.clear
                        }
                    }
                }
                .cornerRadius(12)
        }
    }

    
    private var header: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("Laporan")
                    .font(.title2)
                    .bold()
                
                Text("Analisis keuangan anda")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Button {
                exportReport()
            } label: {
                Image(systemName: "arrow.down.doc")
                    .font(.title3)
                    .foregroundStyle(
                        LinearGradient(
                            colors: [
                                Color(red: 0.05, green: 0.55, blue: 0.45),
                                Color(red: 0.02, green: 0.35, blue: 0.30)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                            )
                        )
                    .padding(10)
                    .background(Color.white)
                    .overlay(
                        Circle()
                            .stroke(
                                LinearGradient(
                                    colors: [
                                        Color(red: 0.05, green: 0.55, blue: 0.45),
                                        Color(red: 0.02, green: 0.35, blue: 0.30)
                                    ],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: 1
                                )
                        )
                    .clipShape(Circle())
            }
        }
    }
    private func exportReport() {
        if selectedTab == 0 {
            print("Export Weekly Report")
        } else {
            print("Export Monthly Report")
        }
    }
}
