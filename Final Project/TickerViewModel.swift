//
//  File.swift
//  Final Project
//
//  Created by Justin Baik on 6/30/24.
//

import Foundation

class TickerViewModel : ObservableObject {
    
    private let url = "https://www.sec.gov/files/company_tickers.json"
    
    @Published private(set) var tickerData = [TickerModel]()
    
    func fetchData() {
        if let url = URL(string: url) {
            URLSession
                .shared
                .dataTask(with: url) { (data, response, error) in
                    if let error = error {
                        print(error)
                    } else {
                        if let data = data {
                            do {
                                // Decode the JSON response
                                let decodedData = try JSONDecoder().decode([String: TickerModel].self, from: data)
                                // Map dictionary values to array
                                let tickers = decodedData.sorted { $0.key < $1.key }.map { $0.value }
                                DispatchQueue.main.async {
                                    // Update the published property on the main queue
                                    self.tickerData = tickers
                                }
                            } catch {
                                print(error)
                            }
                        }
                    }
                }
                .resume()
        }
    }
}

class CompanyInfoViewModel : ObservableObject {
    
    @Published private(set) var companyInfo : CompanyInfoModel?
    
    
    func fetchCompanyInfo(symbol: String) {
        
        let url2 = "https://financialmodelingprep.com/api/v3/profile/\(symbol)"
        
        if let url2 = URL(string: url2) {
            URLSession
                .shared
                .dataTask(with: url2) { (data, response, error) in
                    if let error = error {
                        print(error)
                    } else {
                        if let data = data {
                            do {
                                // Decode the JSON response
                                let decodedData = try JSONDecoder().decode(CompanyInfoModel.self, from: data)
                                
                                DispatchQueue.main.async {
                                    // Update the published property on the main queue
                                    self.companyInfo = decodedData
                                }
                            } catch {
                                print(error)
                            }
                        }
                    }
                }
                .resume()
        }
    }
}
