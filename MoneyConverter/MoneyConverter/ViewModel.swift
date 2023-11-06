//
//  ViewModel.swift
//  MoneyConverter
//
//  Created by alumno on 20/10/23.
//

import Foundation
import SwiftUI

struct ExchangeRatesResponse: Codable{
    let conversion_rates: [String:Double]
    let base_code: String
    let time_last_update_utc: String
}

class CurrencyViewModel: ObservableObject{
    @Published var amount: String = ""
    @Published var baseCurrency: String = "USD"
    @Published var targetCurrency: String = "EUR"
    @Published var rate: Double = 0.0
    @Published var result: String = "El resultado de la conversión aparecerá aquí."
    
    let apiKey = "b127309cdffc2bdc4a8633b2"
    
    func fetchRate(){
        guard let url = URL(string: "https://v6.exchangerate-api.com/v6/\(apiKey)/latest/\(baseCurrency)") else{
            return
        }
        
        URLSession.shared.dataTask(with: url){ data, response, error in
            if let data = data{
                let decoder = JSONDecoder()
                do{
                    let response = try decoder.decode(ExchangeRatesResponse.self, from: data)
                    DispatchQueue.main.async{
                        self.rate = response.conversion_rates[self.targetCurrency] ?? 0.0
                        self.convert()
                    }
                }catch{
                    print("Error decoding JSON: \(error)")
                }
            }
            
        }.resume()
    }
    
    func convert(){
        guard let amountValue = Double(amount)else{
            result = "Cantidad no válida."
            return
        }
        
        let convertedAmount = amountValue * rate
        let formattedNumber = String(format: "%.2f", convertedAmount)
        result = "\(amountValue) \(baseCurrency) = \(formattedNumber) \(targetCurrency)"
    }
}
