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
    private var lastFetchDate: Date?
    private let cacheExpirationInterval: TimeInterval = 3600 // 1 hour cache expiration
    
    
    func fetchDataIfNeeded() {
        // Check if data needs to be fetched based on caching logic
        if shouldFetchData() {
            fetchData()
        } else {
            print("Using cached data for tickers")
        }
    }
    
    private func shouldFetchData() -> Bool {
        guard let lastFetchDate = lastFetchDate else {
            // Fetch data if it hasn't been fetched before
            return true
        }
        
        // Fetch data if cache is expired
        let currentTime = Date()
        return currentTime.timeIntervalSince(lastFetchDate) > cacheExpirationInterval
    }
    
    func fetchData() {
        if let url = URL(string: url) {
            URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
                guard let self = self else { return }
                if let error = error {
                    print(error)
                } else {
                    if let data = data {
                        do {
                            // Decode the JSON response
                            let decodedData = try JSONDecoder().decode([String: TickerModel].self, from: data)
                            
                            let companies = decodedData.values.sorted()
                            DispatchQueue.main.async {
                                // Update the published property on the main queue
                                self.tickerData = companies
                                self.lastFetchDate = Date() // Update last fetch date
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
    
    @Published private(set) var companyInfo: CompanyInfoModel?
    private var ticker = ""
    
    func fetchCompanyInfo(ticker: String) {
        
        let url2 = "https://financialmodelingprep.com/api/v3/profile/\(ticker)?apikey=Dr2e6ni1TdjNzqGPX7CEgmtmOPKaqWd7"
        
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
                                let decodedData = try JSONDecoder().decode([CompanyInfoModel].self, from: data)
                                if let firstCompanyInfo = decodedData.first {
                                    self.companyInfo = firstCompanyInfo
                                } else {
                                    print("No company info found")
                                    // Handle case where no company info is found
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

class FilingsViewModel : ObservableObject {
    
    @Published private(set) var submissions = [Filing]()
    var paddedCik = ""
    
    func fetchSubmissions(cik: String) {
        
        if cik.count < 10 {
            let numberOfZerosToPad = 10 - cik.count
            paddedCik = String(repeating: "0", count: numberOfZerosToPad) + cik
        } else {
            paddedCik = cik
        }
        
        let url = "https://data.sec.gov/submissions/CIK\(paddedCik).json"
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
                                let decodedData = try JSONDecoder().decode(Submissions.self, from: data)
                                for index in 0..<50 {
                                    
                                    let filing = Filing(
                                        accession: decodedData.filings.recent.accessionNumber[index],
                                        filingDate: decodedData.filings.recent.filingDate[index],
                                        reportDate: decodedData.filings.recent.reportDate[index],
                                        form: decodedData.filings.recent.form[index],
                                        items: decodedData.filings.recent.items[index].components(separatedBy: ","),
                                        primaryDocument: decodedData.filings.recent.primaryDocument[index],
                                        primaryDocDescription: decodedData.filings.recent.primaryDocDescription[index]
                                    )
                                    self.submissions.append(filing)
                                }
                                // Update the published property on the main queue
                                //                        DispatchQueue.main.async {
                                //                            submissions = decodedData
                                //                        }
                            } catch {
                                print(error)
                            }
                        }
                    }
                }
                .resume()
        }
    }
    
    func padStringWithLeadingZeros(_ input: String, desiredLength: Int) -> String {
        let currentLength = input.count
        guard currentLength < desiredLength else {
            return input // If input is already longer or equal to desired length, return input unchanged
        }
        
        let numberOfZerosToPad = desiredLength - currentLength
        let paddedString = String(repeating: "0", count: numberOfZerosToPad) + input
        return paddedString
    }
}

public extension Array where Element: Hashable {
    func uniqued() -> [Element] {
        var seen = Set<Element>()
        return filter { seen.insert($0).inserted }
    }
}
