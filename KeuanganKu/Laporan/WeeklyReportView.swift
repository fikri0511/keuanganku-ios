import SwiftUI
import Charts

struct WeeklyReportView: View {
    @StateObject private var vm = ReportViewModel()
    @State private var animatedExpenses: [WeeklyExpense] = []

    var total: Double {
        animatedExpenses.reduce(0) { $0 + $1.amount }
    }

    var body: some View {
        VStack {
            Text("Total: Rp \(Int(total))")

            Chart(animatedExpenses) { item in
                BarMark(
                    x: .value("Hari", item.day),
                    y: .value("Jumlah", item.amount)
                )
                .foregroundStyle(Color.red.gradient)
                .cornerRadius(8)
            }
            .frame(height: 280)
        }
        .task {
            await vm.loadWeekly()
            animateChart(data: vm.weeklyExpenses)
        }
    }

    private func animateChart(data: [WeeklyExpense]) {
        animatedExpenses = data.map {
            WeeklyExpense(day: $0.day, amount: 0)
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            withAnimation(.easeOut(duration: 0.8)) {
                animatedExpenses = data
            }
        }
    }
}
