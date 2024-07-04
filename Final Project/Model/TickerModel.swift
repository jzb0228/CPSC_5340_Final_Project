//
//  TickerModel.swift
//  Final Project
//
//  Created by Justin Baik on 7/3/24.
//

import Foundation

struct TickerModel: Decodable, Identifiable {
    
    let id = UUID()
    let cik_str: Int
    let ticker: String
    let title: String
}

struct CompanyInfoResults : Codable {
    
    let data: [CompanyInfoModel]
}
struct CompanyInfoModel : Codable {
    
    let symbol: String
    let price: Decimal
    let beta: Decimal
    let volAvg: Decimal
    let mktCap: Decimal
    let lastDiv: Decimal
    let range: String
    let changes: Decimal
    let companyName: String
    let currency: String
    let cik: String
    let isin: String
    let cusip: String
    let exchange: String
    let exchangeShortName: String
    let industry: String
    let website: String
    let description: String
    let ceo: String
    let sector: String
    let country: String
    let fullTimeEmployees: String
    let phone: String
    let address: String
    let city: String
    let state: String
    let zip: String
    let dcfDiff: Decimal
    let dcf: Decimal
    let image: String
    let ipoDate: String
    let defaultImage: Bool
    let isEtf: Bool
    let isActivelyTrading: Bool
    let isAdr: Bool
    let isFund: Bool
}

