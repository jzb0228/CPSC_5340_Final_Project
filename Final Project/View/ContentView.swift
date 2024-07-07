//
//  ContentView.swift
//  Final Project
//
//  Created by Justin Baik on 6/30/24.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var tickerViewModel = TickerViewModel()

    var body: some View {
        
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


#Preview {
    ContentView()
}
