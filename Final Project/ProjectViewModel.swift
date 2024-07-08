//
//  ProjectViewModel.swift
//  Final Project


import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import Foundation

class TickerViewModel : ObservableObject {
    
    private let url = "https://www.sec.gov/files/company_tickers.json"
    
    @Published private(set) var tickerData = [TickerModel]()
    
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
                            DispatchQueue.main.async {
                                // Update the published property on the main queue
                                let companies = decodedData.map {$0.value}
                                self.tickerData = companies.sorted{ $0.title < $1.title }
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
    
    @Published private(set) var filings = [Filing]()
    var paddedCik = ""
    
    func fetchSubmissions(cik: String) {
        
        print(cik)
        if cik.count < 10 {
            let numberOfZerosToPad = 10 - cik.count
            paddedCik = String(repeating: "0", count: numberOfZerosToPad) + cik
        } else {
            paddedCik = cik
        }
        print(paddedCik)
        
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
                                var fetchedFilings: [Filing] = []
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
                                    fetchedFilings.append(filing)
                                }
                                DispatchQueue.main.async{
                                    self.filings = fetchedFilings
                                    print(self.filings)
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
    


