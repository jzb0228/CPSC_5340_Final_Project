//
//  TickerDetailView.swift
//  Final Project
//
//  Created by Justin Baik on 7/3/24.
//

import SwiftUI

struct CompanyInfoView: View {
    
    @ObservedObject var companyInfoViewModel = CompanyInfoViewModel()
    var ticker: String
    
    init(ticker: String){
        self.ticker = ticker
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 10) {
//                Text(companyInfoViewModel.symbol)
//                    .bold()
//                Text(companyInfoViewModel.previousClose!.description)
                HStack {
                    Text("At open:")
//                    Text(companyInfoViewModel.open)
                }
//                if companyInfoViewModel.change! > 0 {
                    Image(systemName: "chart.line.uptrend.xyaxis")
                        .foregroundColor(.green)
//                } else {
//                    Image(systemName: "chart.line.downtrend.xyaxis")
//                        .foregroundColor(.red)
//                }
            }
            .imageScale(.large)
//            FilingsView()
        }
        .onAppear {
            companyInfoViewModel.fetchCompanyInfo(symbol: ticker)
        }
        .padding()
    }
    
}

#Preview {
    CompanyInfoView(ticker: "GME")
}
