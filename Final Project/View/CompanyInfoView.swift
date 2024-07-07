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
                    
                    Text(String(describing: companyInfoViewModel.companyInfo!.price!))
                        .bold()
                    Text(String(describing: companyInfoViewModel.companyInfo!.range!))
                }
                
                Spacer()
                
                VStack(alignment: .leading) {
                    
                    Text("CEO: \(companyInfoViewModel.companyInfo!.ceo!)")
                    Text("Company Overview: \(companyInfoViewModel.companyInfo!.description!)")
                    Text("Filings: \(submissionsViewModel.submissions.description)")
                    
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
