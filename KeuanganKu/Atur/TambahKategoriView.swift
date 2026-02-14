//
//  TambahKategoriView.swift
//  KeuanganKu
//
//  Created by Nabil Alviro on 11/02/26.
//


import SwiftUI

struct TambahKategoriView: View {

    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var categoryVM: CategoryViewModel
    @State private var selectedColor = Color.green


    @State private var nama = ""
    @State private var type: CategoryType = .income
    @State private var selectedIcon: String? = "briefcase"
    @State private var isLoading = false

    enum CategoryType {
        case income, expense
    }

    private let icons = [
        "Briefcase",
        "Laptop",
        "TrendingUp",
        "Gift",
        "UtensilsCrossed",
        "Car",
        "ShoppingCart",
        "FileText",
        "Film",
        "Heart",
        "Home",
        "Zap",
        "Coffee",
        "ShoppingBag"
    ]


    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .ignoresSafeArea()
                .onTapGesture { dismiss() }

            VStack(alignment: .leading, spacing: 20) {

                header
                nameField
                typeSelector
                iconGrid
                buttons
            }
            .padding(24)
            .background(
                RoundedRectangle(cornerRadius: 28)
                    .fill(Color(.systemBackground))
            )
            .shadow(color: .black.opacity(0.08), radius: 20, y: 10)
            .padding(.horizontal, 24)
        }
    }

    // MARK: - Header
    private var header: some View {
        HStack {
            Text("Tambah Kategori")
                .font(.system(size: 20, weight: .semibold))

            Spacer()

            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark")
                    .foregroundColor(.gray)
            }
        }
    }

    // MARK: - Name Field
    private var nameField: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Nama Kategori")
                .font(.system(size: 13))
                .foregroundColor(.secondary)

            TextField("Contoh: Transportasi", text: $nama)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray.opacity(0.3))
                )
        }
    }

    // MARK: - Type Selector
    private var typeSelector: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Tipe")
                .font(.system(size: 13))
                .foregroundColor(.secondary)

            HStack {
                typeButton("Pemasukan", .income, .green)
                typeButton("Pengeluaran", .expense, .red)
            }
        }
    }

    private func typeButton(
        _ title: String,
        _ value: CategoryType,
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
                        .fill(type == value ? color.opacity(0.85) : Color.gray.opacity(0.1))
                )
                .foregroundColor(type == value ? .white : .primary)
        }
        .buttonStyle(SoftButtonStyle())
    }

    // MARK: - Icon Grid
    private var iconGrid: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Pilih Ikon")
                .font(.system(size: 13))
                .foregroundColor(.secondary)

            LazyVGrid(
                columns: [GridItem(.adaptive(minimum: 60), spacing: 16)],
                spacing: 16
            ) {
                ForEach(icons, id: \.self) { icon in
                    iconItem(icon)
                }
            }
        }
    }

    private func iconItem(_ icon: String) -> some View {
        let isSelected = selectedIcon == icon

        return Button {
            if selectedIcon == icon {
                selectedIcon = nil          // 🔥 klik 2x = cancel
            } else {
                selectedIcon = icon
            }
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(.systemGray6))

                RoundedRectangle(cornerRadius: 16)
                    .stroke(
                        isSelected
                        ? AnyShapeStyle(LinearGradient.appPrimary)
                        : AnyShapeStyle(Color.gray.opacity(0.25)),
                        lineWidth: isSelected ? 2 : 1
                    )

                Image(systemName: SFSymbolMapper.map(icon))
                    .font(.system(size: 22, weight: .medium))
                    .foregroundStyle(
                        isSelected
                        ? AnyShapeStyle(LinearGradient.appPrimary)
                        : AnyShapeStyle(Color.gray.opacity(0.7))
                    )
            }
            .frame(height: 60)
            .scaleEffect(isSelected ? 1.05 : 1)
            .animation(.spring(response: 0.3), value: selectedIcon)
        }
        .buttonStyle(SoftButtonStyle())
    }

    // MARK: - Buttons
    private var buttons: some View {
        HStack {
            Spacer()

            Button("Batal") {
                dismiss()
            }
            .padding(.horizontal, 18)
            .padding(.vertical, 10)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.gray.opacity(0.15))
            )
            .foregroundColor(.gray)

            Button {
                Task { await createCategory() }
            } label: {
                if isLoading {
                    ProgressView().tint(.white)
                } else {
                    Text("Tambah Kategori")
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(LinearGradient.appPrimary)
            )
            .foregroundColor(.white)
            .disabled(isLoading)
            .buttonStyle(SoftButtonStyle())
        }
    }

    // MARK: - Create Category
    private func createCategory() async {
        guard
            !nama.isEmpty,
            let icon = selectedIcon
        else { return }

        isLoading = true

        do {
            try await CategoryService.shared.createCategory(
                name: nama,
                icon: icon,
                color: selectedColor.toHex(),
                type: type == .income ? "income" : "expense"
            )


            await categoryVM.loadCategories()
            dismiss()
        } catch {
            print("❌ CREATE CATEGORY ERROR:", error)
        }

        isLoading = false
    }
}
