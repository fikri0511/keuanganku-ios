import SwiftUI
import Charts

struct WeeklyReportView: View {
    @State private var animatedExpenses: [WeeklyExpense] = []
    @State private var selectedExpense: WeeklyExpense?
    @State private var selectedDay: String?



    let expenses: [WeeklyExpense] = [
        WeeklyExpense(day: "Rab", amount: 340_500),
        WeeklyExpense(day: "Kam", amount: 50_000),
        WeeklyExpense(day: "Jum", amount: 0),
        WeeklyExpense(day: "Sab", amount: 0),
        WeeklyExpense(day: "Min", amount: 0),
        WeeklyExpense(day: "Sen", amount: 0),
        WeeklyExpense(day : "Sel", amount: 0)
    ]

    var total: Double {
        expenses.reduce(0) { $0 + $1.amount }
    }

    var body: some View {
        VStack(spacing: 20) {

            VStack(alignment: .leading, spacing: 12) {
                Text("Pengeluaran 7 Hari Terakhir")
                    .font(.headline)

                Text("Total: Rp \(Int(total))")
                    .font(.subheadline)
                    .foregroundColor(.gray)

                Chart(animatedExpenses) { item in
                    BarMark(
                        x: .value("Hari", item.day),
                        y: .value("Jumlah", item.amount)
                    )
                    .foregroundStyle(Color.red.gradient)
                    .opacity(
                        selectedDay == nil || selectedDay == item.day
                        ? 1
                        : 0.3
                    )
                    .cornerRadius(8)

                }
                .frame(height: 280)
                
                .chartOverlay { proxy in
                    GeometryReader { geo in
                        Rectangle()
                            .fill(Color.clear)
                            .contentShape(Rectangle())
                            .gesture(
                                DragGesture(minimumDistance: 0)
                                    .onChanged { value in
                                        guard let plotFrame = proxy.plotFrame else { return }
                                        let x = value.location.x - geo[plotFrame].origin.x

                                        if let day: String = proxy.value(atX: x) {
                                            selectedDay = day
                                            selectedExpense = expenses.first { $0.day == day }
                                        }
                                    }
                                    .onEnded { _ in
                                        selectedDay = nil
                                        selectedExpense = nil
                                    }
                            )
                    }
                }
                .overlay(alignment: .topLeading) {
                    if let selectedExpense {
                        tooltipView(expense: selectedExpense)
                            .offset(x: 12, y: 12)
                    }
                }
            }
            .padding()
            .background(Color(.systemBackground))
            .cornerRadius(16)
            .shadow(color: .black.opacity(0.1), radius: 15, x: 0, y: 10)
            .shadow(color: .black.opacity(0.08), radius: 6, x: 0, y: 4)
            .onAppear{
                animateChart()
            }


            // MARK: - Export Card
            VStack(alignment: .leading, spacing: 8) {
                let exportGradient = LinearGradient(
                    colors: [
                        Color(red: 0.05, green: 0.55, blue: 0.45),
                        Color(red: 0.02, green: 0.35, blue: 0.30)
                    ],
                    startPoint: .leading,
                    endPoint: .trailing
                )
                Label("Export Data Bulan Ini", systemImage: "doc.text")
                    .font(.headline)
                    .foregroundStyle(exportGradient)

                Text("Unduh laporan lengkap bulan Januari 2026 dalam format Excel.")
                    .font(.caption)
                    .foregroundColor(.gray)

                Button {
                    print("Download tapped")
                } label: {
                    Text("Download Laporan Bulanan")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            LinearGradient(
                                colors: [
                                    Color(red: 0.05, green: 0.55, blue: 0.45),
                                    Color(red: 0.02, green: 0.35, blue:0.30)
                                ],
                                startPoint: .leading,
                                endPoint: .trailing
                                )
                            )
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
            }
            .padding()
            .background(Color(.systemBackground))
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(
                        LinearGradient(
                            colors: [
                                Color(red: 0.05, green: 0.55, blue: 0.45).opacity(0.35),
                                Color(red: 0.02, green: 0.35, blue: 0.30).opacity(0.15)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 1
                    )
            )
            .cornerRadius(16)
            .shadow(color: .black.opacity(0.08), radius: 12, x: 0, y: 6)

        }
    }

    private func animateChart(){
        animatedExpenses = expenses.map{
            WeeklyExpense(day: $0.day, amount: 0)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
            withAnimation(.easeOut(duration: 0.8)){
                animatedExpenses = expenses
            }
        }
    }
    // MARK: - Tooltip
    private func tooltipView(expense: WeeklyExpense) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(expense.day)
                .font(.caption)
                .foregroundColor(.gray)

            Text("Rp \(Int(expense.amount))")
                .font(.headline)
                .foregroundColor(.red)
        }
        .padding(10)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 5)
    }
}
