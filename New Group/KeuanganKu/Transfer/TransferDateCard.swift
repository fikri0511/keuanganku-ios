//
//  TransferDateCard.swift
//  KeuanganKu
//
//  Created by Nabil Alviro on 31/01/26.
//

import SwiftUI
struct TransferDateCard: View {

    @State private var selectedDate = Date()
    @State private var showPicker = false

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {

            Text("Tanggal")
                .font(.subheadline)
                .fontWeight(.semibold)

            Button {
                showPicker = true
            } label: {
                HStack {
                    Image(systemName: "calendar")
                        .foregroundColor(.gray)

                    Text(formattedDate)
                        .foregroundColor(.primary)

                    Spacer()
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.05), radius: 8, y: 4)
        .sheet(isPresented: $showPicker) {
            VStack {
                DatePicker(
                    "Pilih Tanggal",
                    selection: $selectedDate,
                    displayedComponents: .date
                )
                .datePickerStyle(.graphical)
                .padding()

                Button("Selesai") {
                    showPicker = false
                }
                .padding()
            }
            .presentationDetents([.medium])
        }
    }

    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "id_ID")
        formatter.dateStyle = .long
        return formatter.string(from: selectedDate)
    }
}
