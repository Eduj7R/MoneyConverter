//
//  ContentView.swift
//  MoneyConverter
//
//  Created by alumno on 20/10/23.
//

import SwiftUI
import UIKit
import Kingfisher

struct ContentView: View {
    
    @State private var selectedType = ["USD", "EUR", "JPV", "GBP"]
    @ObservedObject var viewModel = CurrencyViewModel()
    var urlImage1: String?
    var urlImage2: String?
    
    var body: some View {
        ZStack{
            VStack{
                
                Text("Money Converter").font(.largeTitle).bold()
                if let urlImage1 = urlImage1, let image = URL(string: urlImage1){
                    KFImage.url(image).resizable().frame(width: 150.0, height: 150.0)
                }
                Spacer()
                    .frame(width: 0.0, height: 50.0)
                TextField("Introduzca el valor", text: $viewModel.amount).keyboardType(.decimalPad).padding().border(Color.blue, width: 2).bold()
                Spacer()
                    .frame(width: 0.0, height: 30.0)
                
                HStack{
                    Picker("ToConvert", selection: $viewModel.baseCurrency){
                        ForEach(selectedType, id: \.self){ type in
                            Text(type)
                        }
                    }.pickerStyle(MenuPickerStyle()).buttonStyle(.borderedProminent)
                    
                    Spacer().frame(width: 80.0)
                    
                    Picker("Converted",  selection: $viewModel.targetCurrency){
                        ForEach(selectedType, id: \.self){ type in
                            Text(type)
                        }
                    }.pickerStyle(MenuPickerStyle()).buttonStyle(.borderedProminent)
                }
                
                Button("Convert", systemImage: "info"){
                    viewModel.fetchRate() //Obtiene tasa de cambio y luego convierte
                    print(viewModel.amount)
                    
                }.padding(.vertical).buttonStyle(.borderedProminent).bold()
                
                
                Text(viewModel.result).textFieldStyle(.roundedBorder)
                
                
                if let urlImage2 = urlImage2, let image = URL(string:urlImage2){
                    KFImage.url(image).resizable().frame(width: 200.0, height: 200.0)
                }
                
            }.background().padding()
            
        }.background().padding(1)
            
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(urlImage1: "https://play-lh.googleusercontent.com/Bddip99b3uI3X3i2Z0M7NxBgcZ0q6jyjVHd7Q1zHEzvs_1jlVuNc_57dl-QsF3S-_Nw", urlImage2: "https://static.wikia.nocookie.net/pizzatower/images/3/38/Spr_player_taunt9.png/revision/latest?cb=20201122140134")
    }
}
