//
//  TransferDateCard.swift
//  KeuanganKu
//
//  Created by Nabil Alviro on 31/01/26.
//

import SwiftUI
struct TransferDateCard: View {

    @Binding var date: Date
    @State private var showPicker = false

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {

            Text("Tanggal")
                .font(.subheadline.weight(.semibold))

            Button {
                showPicker = true
            } label: {
                HStack {
                    Image(systemName: "calendar")
                        .foregroundColor(.gray)

                    Text(formattedDate)
                    Spacer()
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
            }
        }
        .padding()
        .background(.white)
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.05), radius: 8, y: 4)
        .sheet(isPresented: $showPicker) {
            DatePicker(
                "Pilih Tanggal",
                selection: $date,
                displayedComponents: .date
            )
            .datePickerStyle(.graphical)
            .presentationDetents([.medium])
        }
    }

    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "id_ID")
        formatter.dateStyle = .long
        return formatter.string(from: date)
    }
}
