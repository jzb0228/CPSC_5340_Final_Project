//
//  Form8KModel.swift
//  Final Project
//
//  Created by Justin Baik on 7/6/24.
//

import Foundation

/**Form 8-K is filed with the SEC to report significant events that shareholders should be aware of promptly. The triggering events that typically require filing a Form 8-K include:
 
 Entry into a Material Definitive Agreement (Item 1.01):
 
 Signing agreements such as mergers, acquisitions, or contracts that are important to the company's operations.
 Termination of a Material Definitive Agreement (Item 1.02):
 
 Ending significant contracts or agreements.
 Bankruptcy or Receivership (Item 1.03):
 
 Filing for bankruptcy or entering receivership.
 Completion of Acquisition or Disposition of Assets (Item 2.01):
 
 Significant purchases or sales of assets.
 Results of Operations and Financial Condition (Item 2.02):
 
 Reporting significant financial results.
 Creation of a Direct Financial Obligation or an Obligation under an Off-Balance Sheet Arrangement (Item 2.03):
 
 Taking on significant debt or other financial obligations.
 Triggering Events That Accelerate or Increase a Direct Financial Obligation or an Obligation under an Off-Balance Sheet Arrangement (Item 2.04):
 
 Events that impact existing financial obligations.
 Costs Associated with Exit or Disposal Activities (Item 2.05):
 
 Costs related to restructuring or exiting certain activities.
 Material Impairments (Item 2.06):
 
 Impairment of assets.
 Notice of Delisting or Failure to Satisfy a Continued Listing Rule or Standard; Transfer of Listing (Item 3.01):
 
 Notification of delisting from a stock exchange.
 Unregistered Sales of Equity Securities (Item 3.02):
 
 Issuance of stock or other equity securities that are not registered.
 Material Modifications to Rights of Security Holders (Item 3.03):
 
 Changes in rights of shareholders.
 Changes in Registrant's Certifying Accountant (Item 4.01):
 
 Changes in auditors or accountants.
 Non-Reliance on Previously Issued Financial Statements or a Related Audit Report or Completed Interim Review (Item 4.02):
 
 Issues with financial statements that were previously issued.
 Changes in Control of Registrant (Item 5.01):
 
 Changes in control or ownership of the company.
 Departure of Directors or Certain Officers; Election of Directors; Appointment of Certain Officers; Compensatory Arrangements of Certain Officers (Item 5.02):
 
 Changes in management or executive compensation.
 Amendments to Articles of Incorporation or Bylaws; Change in Fiscal Year (Item 5.03):
 
 Changes to corporate governance documents or fiscal year.
 Temporary Suspension of Trading Under Registrant's Employee Benefit Plans (Item 5.04):
 
 Suspension of trading under employee benefit plans.
 Amendments to the Registrant's Code of Ethics, or Waiver of a Provision of the Code of Ethics (Item 5.05):
 
 Changes to the company's code of ethics.
 Change in Shell Company Status (Item 5.06):
 
 Transition from a shell company to an operating company.
 Submission of Matters to a Vote of Security Holders (Item 5.07):
 
 Results of shareholder voting.
 ABS Informational and Computational Material (Item 6.01):
 
 Information about asset-backed securities.
 Change of Servicer or Trustee (Item 6.02):
 
 Change in servicer or trustee for asset-backed securities.
 Change in Credit Enhancement or Other External Support (Item 6.03):
 
 Changes in credit enhancement for asset-backed securities.
 Failure to Make a Required Distribution (Item 6.04):
 
 Failure to make a required distribution for asset-backed securities.
 
 Regulation FD Disclosure (Item 7.01):
 
 Events required to be disclosed under Regulation FD (Fair Disclosure).
 Other Events (Item 8.01):
 
 Events that are not covered by other items but are of significance to shareholders.
 Financial Statements and Exhibits (Item 9.01):
 
 Filing of financial statements or exhibits that are not included in a periodic report or offering statement.
 Creation of a Direct Financial Obligation or an Obligation under an Off-Balance Sheet Arrangement (Item 9.02):
 
 Creation of direct financial obligations or off-balance sheet arrangements that do not meet the criteria for Item 2.03 or Item 2.04.
 Triggering Events That Accelerate or Increase a Direct Financial Obligation or an Obligation under an Off-Balance Sheet Arrangement (Item 9.03):
 
 Events that accelerate or increase existing financial obligations that do not meet the criteria for Item 2.04.
 Material Modifications to Rights of Security Holders (Item 9.01):
 
 Amendments to the rights of security holders that are not covered by Item 3.03.*/

struct Submissions : Decodable {
    
    let cik: String
    let tickers: [String]
    let filings : Filings
    
    struct Filings : Decodable {
        
        let recent : Recent
        
        struct Recent : Decodable {
            
            var accessionNumber: [String]
            var filingDate: [String]
            var reportDate: [String]
            var form: [String]
            var items: [String]
            var primaryDocument: [String]
            var primaryDocDescription: [String]
            
        }
    }
}

struct Filing : Identifiable, Hashable {
    let id = UUID()
    let accession: String
    let filingDate: String
    let reportDate: String?
    let form: String?
    let items: [String]?
    let primaryDocument: String?
    let primaryDocDescription: String?
}
