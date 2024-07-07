//
//  TickerDetailView.swift
//  Final Project
//
//  Created by Justin Baik on 7/3/24.
//

import SwiftUI

struct CompanyInfoView: View {
    
    @ObservedObject var submissionsViewModel = FilingsViewModel()
    @ObservedObject var companyInfoViewModel = CompanyInfoViewModel()
    var ticker: String
    var cik: String
    
    var body: some View {
        ScrollView {
            if companyInfoViewModel.companyInfo != nil {
                VStack(alignment: .center, spacing: 10) {
                    HStack {
                        
                        Text(companyInfoViewModel.companyInfo!.symbol!)
                            .bold()
                        if companyInfoViewModel.companyInfo!.changes! > 0 {
                            Image(systemName: "chart.line.uptrend.xyaxis")
                                .foregroundColor(.green)
                        } else {
                            Image(systemName: "chart.line.downtrend.xyaxis")
                                .foregroundColor(.red)
                        }
                    }
                    HStack {
                        Text("Current price: ")
                            .italic()
                            .foregroundStyle(.gray)
                        Text("$\(String(describing: companyInfoViewModel.companyInfo!.price!))")
                            .bold()
                    }
                    .font(.system(size: 15))
                    HStack {
                        Text("Year Range: ")
                            .italic()
                            .foregroundStyle(.gray)
                        Text(String(describing: companyInfoViewModel.companyInfo!.range!))
                            .bold()
                    }
                    .font(.system(size: 15))

                }
                
                Spacer()
                Spacer()
                
                VStack(alignment: .leading) {
                        
                        Text(companyInfoViewModel.companyInfo!.description!)
                        Text("Filings: \(submissionsViewModel.filings.description)")
                    }
                List(submissionsViewModel.filings, id: \.accession) { filing in
                    NavigationLink(destination: FilingsView()) {
                        Text(filing.form ?? "Unknown Form")
                    }
                }
                
            } else {
                Text("No company information available")
            }
        }
        .onAppear {
            companyInfoViewModel.fetchCompanyInfo(ticker: self.ticker)
            submissionsViewModel.fetchSubmissions(cik: self.cik)
        }
        .padding()
    }
    
}

//#Preview {
//    CompanyInfoView(ticker: "GME")
//}
