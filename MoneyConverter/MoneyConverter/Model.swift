//
//  Model.swift
//  MoneyConverter
//
//  Created by alumno on 20/10/23.
//

import Foundation

struct Model: Codable{
    let money: Double
    let type: String
    let id: String
    
    init (money: Double, type:String, id:String = UUID().uuidString){
        self.money = money
        self.id = id
        self.type = type
    }
}
