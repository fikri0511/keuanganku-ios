import Supabase
import Foundation
final class WalletService {
    static let shared = WalletService()

    func fetchWallets() async throws -> [Wallet] {
        let client = SupabaseConfig.shared.client
        let userId = try await AuthService.shared.currentUserId()

        let response = try await client
            .from("wallets")
            .select()
            .eq("user_id", value: userId)
            .order("created_at", ascending: true)
            .execute()

        return try JSONDecoder().decode([Wallet].self, from: response.data)
    }
}
