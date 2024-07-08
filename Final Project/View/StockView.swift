//
//  ContentView.swift
//  Final Project
//

import SwiftUI
import FirebaseAuth

struct StockView: View {
    
    @AppStorage("uid") var userID : String = ""
    @ObservedObject var tickerViewModel = TickerViewModel()
    
    var body: some View {
        
        if userID == "" {
            AuthView()
        } else {
            
            Button(action: {
                let firebaseAuth = Auth.auth()
                do {
                    try firebaseAuth.signOut()
                    userID = ""
                } catch let signOutError as NSError {
                    print("Error signingout: %@", signOutError)
                }
            }) {
                Text("Sign Out")
            }
            
            NavigationStack {
                List {
                    ForEach(tickerViewModel.tickerData) { company in
                        NavigationLink {
                            CompanyInfoView(ticker: company.ticker, cik: String(company.cik_str))
                        } label: {
                            Text(company.title)
                        }
                    }
                }
                .onAppear {
                    tickerViewModel.fetchData()
                }
                .navigationTitle("Public Companies")
            }
        }
    }
}


#Preview {
    StockView()
}
