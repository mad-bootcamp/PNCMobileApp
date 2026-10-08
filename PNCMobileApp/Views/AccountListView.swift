//
//  AccountListView.swift
//  PNCMobileApp
//
//  Created by user303027 on 9/9/26.
//

//
//  AccountListView_Starter.swift
//  PNCMobileApp
//
//  Module 6 — Building iOS User Interfaces
//  Lab Exercise: PNC Mobile — Accounts List Screen
//
//  SCENARIO
//  Build the accounts list screen for PNC Mobile — the lab exercise screen for
//  Module 6. This exercise pulls together state management (Block 2),
//  navigation (Block 3), List (Block 4), and accessibility (Block 6).
//
//  REQUIREMENTS
//  1. Build AccountListView using List, NavigationStack, and NavigationLink.
//  2. Each row shows account name, masked account number, and balance
//     (currency-formatted).
//  3. Tapping a row navigates to an AccountDetailView showing the full
//     account.
//  4. Every row must be fully readable by VoiceOver as ONE combined
//     element, not three separate announcements.
//  5. The balance text must scale correctly under larger Dynamic Type
//     sizes — no fixed font sizes anywhere in the row.
//
//  The Account model below is complete. Implement the two TODOs.
//

import SwiftUI

// MARK: - Model (complete — no changes needed)

struct Account: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let maskedNumber: String
    let balance: Decimal
}

let sampleAccounts: [Account] = [
    Account(name: "Everyday Checking", maskedNumber: "1", balance: 4281.16),
    Account(name: "High Yield Savings", maskedNumber: "1", balance: 18_340.50),
    Account(name: "Rewards Credit Card", maskedNumber: "1", balance: -612.44)
]

// MARK: - TODO 1: AccountListView

struct AccountListView: View {
    var accounts: [Account] = [Account(name: "Everyday Checking", maskedNumber: "1", balance: 4281.16),
                               Account(name: "High Yield Savings", maskedNumber: "1", balance: 18_340.50),
                               Account(name: "Rewards Credit Card", maskedNumber: "1", balance: -612.44)]

    var body: some View {
        // TODO: Wrap a List of `accounts` in a NavigationStack.
        // Each row should be a NavigationLink(value:) wrapping an
        // AccountRow. Add a .navigationDestination(for: Account.self)
        // that presents AccountDetailView. Set a navigationTitle.
        NavigationStack{
            List{
                
                ForEach(accounts) { acc in
                    AccountRow(account: acc)
                    
                }
            }
            .navigationTitle("Accounts")
            .navigationDestination(for: Account.self){
                selectedAccount in
                AccountDetailView(account: selectedAccount)
            }
        }
    }
}

// MARK: - TODO 2: AccountRow

struct AccountRow: View {
    let account: Account

    var body: some View {
        // TODO: Lay out account.name, account.maskedNumber, and
        // account.balance (currency-formatted) in an HStack/VStack
        // combination. Use Dynamic-Type-aware font styles only — no
        // .font(.system(size:)). Add accessibilityElement(children: .combine)
        // and a single, readable accessibilityLabel for the whole row.
        VStack {
            Image(systemName: "person.fill")
            NavigationLink(value: account){
                Text(account.name)
                Text(account.maskedNumber)
                Text(account.balance, format: .currency(code: "USD"))
            }
        }
    }
}

// MARK: - AccountDetailView (provided — no changes needed)

struct AccountDetailView: View {
    let account: Account

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(account.name).font(.largeTitle.bold())
            Text(account.maskedNumber).font(.subheadline).foregroundStyle(.secondary)
            Text(account.balance, format: .currency(code: "USD"))
                .font(.title.monospacedDigit())
            Spacer()
        }
        .padding()
        .navigationTitle(account.name)
    }
}

#Preview {
    AccountListView(accounts: sampleAccounts)
}
