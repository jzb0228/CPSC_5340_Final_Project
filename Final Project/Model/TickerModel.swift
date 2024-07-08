//
//  TickerModel.swift
//  Final Project
//

import Foundation

struct TickerModel: Decodable, Comparable, Identifiable, Equatable {
    
    let id = UUID()
    let cik_str: Int
    let ticker: String
    let title: String
    
    // Implement Comparable protocol to compare by ticker
    static func < (lhs: TickerModel, rhs: TickerModel) -> Bool {
        return lhs.title < rhs.title
    }
}

struct CompanyInfoModel : Codable {
    
    let symbol: String?
    let price: Decimal?
    let beta: Decimal?
    let volAvg: Decimal?
    let mktCap: Decimal?
    let lastDiv: Decimal?
    let range: String?
    let changes: Decimal?
    let companyName: String?
    let currency: String?
    let cik: String?
    let isin: String?
    let cusip: String?
    let exchange: String?
    let exchangeShortName: String?
    let industry: String?
    let website: String?
    let description: String?
    let ceo: String?
    let dcfDiff: Decimal?
    let dcf: Decimal?
    let image: String?
    let ipoDate: String?
    let defaultImage: Bool?
    let isEtf: Bool?
    let isActivelyTrading: Bool?
    let isAdr: Bool?
    let isFund: Bool?
    
}
