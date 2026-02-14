//
//  TambahDompetView.swift
//  KeuanganKu
//
//  Created by Nabil Alviro on 10/02/26.
//


import SwiftUI

struct TambahDompetView: View {

    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var walletVM: WalletViewModel
    
    @State private var walletName = ""
    @State private var saldoText = ""
    @State private var selectedIcon = "banknote"
    @State private var isLoading = false
    @FocusState private var isFocused: Bool
    
    private let icons = [
        "Wallet",
        "Landmark",
        "Smartphone",
        "CreditCard",
        "Banknote",
        "PiggyBank",
        "Building",
        "DollarSign"
    ]


    var body: some View {
        ZStack {
            
            Color.black.opacity(0.35)
                .ignoresSafeArea()
                .onTapGesture {
                    dismissKeyboard()
                }
            
            VStack(alignment: .leading, spacing: 22) {
                
                // HEADER
                HStack {
                    Text("Tambah Dompet")
                        .font(.system(size: 20, weight: .semibold))
                    
                    Spacer()
                    
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.gray)
                    }
                }
                
                // NAMA
                VStack(alignment: .leading, spacing: 6) {
                    Text("Nama Dompet")
                        .font(.system(size: 13))
                        .foregroundColor(.secondary)
                    
                    TextField("Contoh: Bank Mandiri", text: $walletName)
                        .focused($isFocused)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.gray.opacity(0.3))
                        )
                }
                
                // SALDO
                VStack(alignment: .leading, spacing: 6) {
                    Text("Saldo Awal")
                        .font(.system(size: 13))
                        .foregroundColor(.secondary)
                    
                    HStack {
                        Text("Rp")
                            .foregroundColor(.secondary)
                        
                        TextField("0", text: $saldoText)
                            .keyboardType(.numberPad)
                            .focused($isFocused)
                            .onChange(of: saldoText) { _, newValue in
                                saldoText = newValue.filter { $0.isNumber }
                            }
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.gray.opacity(0.08))
                    )
                }
                
                // ICON GRID
                VStack(alignment: .leading, spacing: 8) {
                    Text("Pilih Ikon")
                        .font(.system(size: 13))
                        .foregroundColor(.secondary)
                    
                    LazyVGrid(
                        columns: Array(repeating: GridItem(.flexible()), count: 4),
                        spacing: 12
                    ) {
                        ForEach(icons, id: \.self) { icon in
                            iconItem(icon)
                        }
                    }
                }
                
                // BUTTONS
                HStack {
                    Spacer()
                    
                    Button {
                        dismiss()
                    } label: {
                        Text("Batal")
                            .font(.system(size: 14, weight: .medium))
                            .frame(height: 48)
                            .frame(minWidth: 90)
                            .background(
                                RoundedRectangle(cornerRadius: 14)
                                    .fill(Color.gray.opacity(0.15))
                            )
                            .foregroundColor(.gray)
                    }
                    .buttonStyle(SoftButtonStyle())

                    
                    Button {
                        Task {
                            await createWallet()
                        }
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 14)
                                .fill(LinearGradient.appPrimary)
                                .frame(height: 48)

                            if isLoading {
                                ProgressView()
                                    .tint(.white)
                            } else {
                                Text("Tambah Dompet")
                                    .font(.system(size: 15, weight: .semibold))
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    .buttonStyle(SoftButtonStyle())
                    .disabled(isLoading)

                }
            }
            .padding(24)
            .background(
                RoundedRectangle(cornerRadius: 24)
                    .fill(Color.white)
            )
            .padding(.horizontal, 28)
            .animation(.easeInOut(duration: 0.2), value: selectedIcon)
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
        
    }
    private func createWallet() async {
        guard !walletName.isEmpty else { return }
        
        isLoading = true
        
        let saldo = Double(saldoText) ?? 0
        
        do {
            try await walletVM.addWallet(
                name: walletName,
                balance: saldo,
                icon: selectedIcon
            )
            dismiss()
        } catch {
            print("❌ Gagal tambah wallet:", error)
        }
        
        isLoading = false
    }
    private func iconItem(_ icon: String) -> some View {
        let isSelected = selectedIcon == icon
        
        return Button {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                selectedIcon = icon
            }
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 14)
                    .fill(isSelected ? AppColor.primary.opacity(0.12) : Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(
                                isSelected ? AppColor.primary : Color.gray.opacity(0.3),
                                lineWidth: isSelected ? 2 : 1
                            )
                    )
                
                Image(systemName: SFSymbolMapper.map(icon))
                    .font(.system(size: 22))
                    .foregroundColor(
                        isSelected ? AppColor.primary : .gray
                    )
            }
            .frame(height: 58)
        }
    }
    private func dismissKeyboard() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil
        )
    }

}
