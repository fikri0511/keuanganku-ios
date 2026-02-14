//
//  TambahTransaksiView.swift
//  KeuanganKu
//
//  Created by Nabil Alviro on 11/02/26.
//


import SwiftUI

struct TambahTransaksiView: View {

    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var walletVM: WalletViewModel
    @EnvironmentObject var dashboardVM: DashboardViewModel
    @EnvironmentObject var categoryVM: CategoryViewModel


    enum TransactionType {
        case income, expense
    }

    @State private var type: TransactionType = .expense
    @State private var amount: String = ""
    @State private var selectedWallet: Wallet?
    @State private var selectedCategory: UUID?
    @State private var note: String = ""
    @State private var date = Date()
    @State private var isLoading = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {

                ScrollView {
                    VStack(spacing: 24) {
                        typeSelector
                        amountField
                        walletSection
                        categorySection
                        noteField
                        datePicker
                    }
                    .padding(20)
                    .padding(.bottom, 120)
                }

                bottomButton
            }
            .navigationTitle("Transaksi Baru")
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
    }

    // MARK: - TYPE SELECTOR

    private var typeSelector: some View {
        HStack(spacing: 12) {
            typeButton("Pemasukan", .income, .green)
            typeButton("Pengeluaran", .expense, .red)
        }
    }

    private func typeButton(
        _ title: String,
        _ value: TransactionType,
        _ color: Color
    ) -> some View {

        Button {
            type = value
        } label: {
            Text(title)
                .frame(maxWidth: .infinity)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 14)
                        .fill(type == value ? color.opacity(0.9) : Color.gray.opacity(0.1))
                )
                .foregroundColor(type == value ? .white : .primary)
        }
    }

    // MARK: - AMOUNT

    private var amountField: some View {
        VStack(alignment: .leading, spacing: 6) {

            Text("Jumlah")
                .font(.caption)
                .foregroundColor(.secondary)

            HStack {
                Text("Rp")
                    .foregroundColor(.secondary)

                TextField("0", text: $amount)
                    .keyboardType(.decimalPad)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 14)
                    .fill(Color(.systemGray6))
            )
        }
    }

    // MARK: - WALLET

    private var walletSection: some View {
        VStack(alignment: .leading, spacing: 12) {

            Text("Dompet")
                .font(.caption)
                .foregroundColor(.secondary)

            LazyVGrid(
                columns: [GridItem(.flexible()), GridItem(.flexible())],
                spacing: 12
            ) {
                ForEach(walletVM.wallets) { wallet in
                    walletCard(wallet)
                }
            }
        }
    }

    private func walletCard(_ wallet: Wallet) -> some View {

        let isSelected = selectedWallet?.id == wallet.id

        return Button {
            selectedWallet = (isSelected ? nil : wallet)
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
        }
    }

    // MARK: - CATEGORY

    private var categorySection: some View {
        VStack(alignment: .leading, spacing: 12) {

            Text("Kategori")
                .font(.caption)
                .foregroundColor(.secondary)

            LazyVGrid(
                columns: [GridItem(.flexible()), GridItem(.flexible())],
                spacing: 12
            ) {
                ForEach(filteredCategories) { category in
                    categoryCard(category)
                }
            }
        }
    }

    private func categoryCard(_ category: Category) -> some View {

        let isSelected = selectedCategory == category.id

        return Button {
            selectedCategory = isSelected ? nil : category.id
        } label: {

            VStack(spacing: 6) {

                Image(systemName: SFSymbolMapper.map(category.icon))
                    .font(.title3)
                    .foregroundStyle(
                        isSelected
                        ? AnyShapeStyle(LinearGradient.appPrimary)
                        : AnyShapeStyle(Color.gray.opacity(0.7))
                    )

                Text(category.name)
                    .font(.caption)
                    .foregroundColor(.primary)
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
        }
    }

    // MARK: - NOTE

    private var noteField: some View {
        VStack(alignment: .leading, spacing: 6) {

            Text("Catatan (Opsional)")
                .font(.caption)
                .foregroundColor(.secondary)

            TextField("Tambahkan catatan...", text: $note)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 14)
                        .fill(Color(.systemGray6))
                )
        }
    }

    // MARK: - DATE

    private var datePicker: some View {
        VStack(alignment: .leading, spacing: 6) {

            Text("Tanggal")
                .font(.caption)
                .foregroundColor(.secondary)

            DatePicker("", selection: $date, displayedComponents: .date)
                .datePickerStyle(.compact)
        }
    }

    // MARK: - BUTTON

    private var bottomButton: some View {

        Button {

            Task { await createTransaction() }

        } label: {

            if isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity)
                    .padding()
            } else {
                Text("Simpan Transaksi")
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding()
            }
        }
        .background(type == .expense ? Color.red : Color.green)
        .foregroundColor(.white)
        .cornerRadius(14)
        .padding()
        .disabled(!isFormValid || isLoading)
    }

    private var isFormValid: Bool {
        selectedWallet != nil &&
        selectedCategory != nil &&
        Double(amount) != nil
    }

    // MARK: - CREATE

    private func createTransaction() async {

        guard
            let wallet = selectedWallet,
            let categoryId = selectedCategory,
            let amountDouble = Double(amount)
        else { return }

        isLoading = true

        do {

            try await TransactionService.shared.createTransaction(
                amount: amountDouble,
                type: type == .income ? "income" : "expense",
                walletId: wallet.id,
                categoryId: categoryId,
                note: note.isEmpty ? nil : note,
                date: date
            )

            print("✅ TRANSACTION INSERTED")

            await dashboardVM.loadData()
            await walletVM.loadWallets()

            dismiss()

        } catch {
            print("❌ CREATE TRANSACTION ERROR:", error)
        }

        isLoading = false
    }
    private var filteredCategories: [Category] {
        categoryVM.categories.filter { category in
            category.type == (type == .income ? "income" : "expense")
        }
    }

}
