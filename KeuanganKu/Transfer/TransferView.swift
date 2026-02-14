//
//  TransferView.swift
//  KeuanganKu
//
//  Created by Nabil Alviro on 27/01/26.
//

import SwiftUI

struct TransferView: View {

    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var walletVM: WalletViewModel
    @EnvironmentObject var dashboardVM: DashboardViewModel

    @State private var fromWallet: Wallet?
    @State private var toWallet: Wallet?
    @State private var amount: String = ""
    @State private var selectedDate = Date()
    @State private var isLoading = false
    @State private var errorMessage: String?
    @State private var showDatePicker = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {

                ScrollView {
                    VStack(spacing: 24) {
                        walletSection
                        amountField
                        dateSection
                    }
                    .padding(20)
                    .padding(.bottom, 120)
                }

                bottomButton
            }
            .navigationTitle("Transfer Antar Dompet")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
            }
        }
        .sheet(isPresented: $showDatePicker) {
            VStack {
                DatePicker(
                    "Pilih Tanggal",
                    selection: $selectedDate,
                    displayedComponents: .date
                )
                .datePickerStyle(.graphical)
                .padding()

                Button("Selesai") {
                    showDatePicker = false
                }
                .padding()
            }
            .presentationDetents([.medium])
        }
        .task {
            await walletVM.loadWallets()
        }
    }



    // MARK: WALLET SECTION

    private var walletSection: some View {
        VStack(alignment: .leading, spacing: 12) {

            Text("Dari Dompet")
                .font(.caption)
                .foregroundColor(.secondary)

            walletGrid(selection: $fromWallet, oppositeWallet: toWallet)

            Text("Ke Dompet")
                .font(.caption)
                .foregroundColor(.secondary)

            walletGrid(selection: $toWallet, oppositeWallet: fromWallet)
        }
    }

    private func walletGrid(
        selection: Binding<Wallet?>,
        oppositeWallet: Wallet?
    ) -> some View {

        LazyVGrid(
            columns: [GridItem(.flexible()), GridItem(.flexible())],
            spacing: 12
        ) {
            ForEach(walletVM.wallets) { wallet in
                walletCard(
                    wallet,
                    selection: selection,
                    isDisabled: wallet.id == oppositeWallet?.id
                )
            }
        }
    }

    private func walletCard(
        _ wallet: Wallet,
        selection: Binding<Wallet?>,
        isDisabled: Bool
    ) -> some View {

        let isSelected = selection.wrappedValue?.id == wallet.id

        return Button {
            if !isDisabled {
                selection.wrappedValue = isSelected ? nil : wallet
            }
        } label: {

            VStack(spacing: 6) {

                Image(systemName: SFSymbolMapper.map(wallet.icon))
                    .font(.title3)
                    .foregroundStyle(
                        isSelected
                        ? AnyShapeStyle(LinearGradient.appPrimary)
                        : AnyShapeStyle(Color.gray.opacity(0.7))
                    )

                Text(wallet.name)
                    .font(.caption)
                    .foregroundColor(.primary)

                Text(wallet.balance.toRupiah())
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(.systemGray6))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(
                        isSelected
                        ? AnyShapeStyle(LinearGradient.appPrimary)
                        : AnyShapeStyle(Color.gray.opacity(0.2)),
                        lineWidth: isSelected ? 2 : 1
                    )
            )
            .opacity(isDisabled ? 0.4 : 1)
        }
        .disabled(isDisabled)
    }

    // MARK: AMOUNT

    private var amountField: some View {
        VStack(alignment: .leading, spacing: 6) {

            Text("Jumlah")
                .font(.caption)
                .foregroundColor(.secondary)

            VStack(alignment: .trailing, spacing: 6) {

                HStack {
                    Text("Rp")
                        .foregroundColor(.secondary)

                    TextField("0", text: Binding(
                        get: { amount },
                        set: { newValue in
                            amount = formatRupiah(newValue)
                        }
                    ))
                    .keyboardType(.numberPad)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 14)
                        .fill(Color(.systemGray6))
                )

                // 🔥 PREVIEW NOMINAL (kaya di web)
                if let intValue = Int(amount.replacingOccurrences(of: ".", with: "")),
                   intValue > 0 {

                    Text("Rp \(formatRupiah(amount))")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .padding(.trailing, 4)
                }
            }
        }
    }

    // MARK: DATE

    private var dateSection: some View {
        VStack(alignment: .leading, spacing: 6) {

            Text("Tanggal")
                .font(.caption)
                .foregroundColor(.secondary)

            Button {
                showDatePicker = true
            } label: {
                HStack {
                    Image(systemName: "calendar")
                        .foregroundColor(.secondary)

                    Text(
                        selectedDate.formatted(
                            .dateTime
                                .day()
                                .month(.wide)
                                .year()
                        )
                    )
                    .foregroundColor(.primary)

                    Spacer()
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 14)
                        .fill(Color(.systemGray6))
                )
            }
        }
    }

    // MARK: BUTTON

    private var bottomButton: some View {

        Button {
            Task { await performTransfer() }
        } label: {

            if isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity)
                    .padding()
            } else {
                Text("Transfer Sekarang")
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding()
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(
                    canTransfer
                    ? AnyShapeStyle(LinearGradient.appPrimary)
                    : AnyShapeStyle(Color.gray.opacity(0.4))
                )
        )
        .foregroundColor(.white)
        .padding()
        .disabled(!canTransfer || isLoading)
    }

    private var canTransfer: Bool {
        guard
            let from = fromWallet,
            let to = toWallet,
            from.id != to.id
        else { return false }

        let cleanAmount = amount.replacingOccurrences(of: ".", with: "")
        return Int(cleanAmount) ?? 0 > 0
    }

    private func performTransfer() async {

        guard let from = fromWallet,
              let to = toWallet
        else { return }

        let cleanAmount = amount.replacingOccurrences(of: ".", with: "")
        guard let amountDouble = Double(cleanAmount),
              amountDouble > 0
        else { return }

        isLoading = true

        do {
            try await TransferService.shared.createTransfer(
                amount: amountDouble,
                sourceWalletId: from.id,
                destinationWalletId: to.id,
                note: nil,
                date: selectedDate
            )

            await walletVM.loadWallets()

            fromWallet = nil
            toWallet = nil
            amount = ""

        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }
}
private func formatRupiah(_ value: String) -> String {

    let digits = value
        .replacingOccurrences(of: ".", with: "")
        .filter { "0123456789".contains($0) }

    guard let number = Int(digits) else { return "" }

    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.groupingSeparator = "."
    formatter.locale = Locale(identifier: "id_ID")

    return formatter.string(from: NSNumber(value: number)) ?? ""
}
