//
//  ContentView.swift
//  WeSplit
//
//  Created by Esben Viskum on 21/02/2021.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var noPeople = ""
    @State private var tipAmount = 2
    let tips = [10, 15, 20, 25, 0]
    
    var grandTotal: Double {
        let tipSelection = Double(tips[tipAmount])
        let orderAmount = Double(checkAmount) ?? 0

        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        
        return grandTotal
    }
    
    var totalPerPerson: Double? {
        let peopleCount = Double(noPeople) ?? 0
        if peopleCount > 0 {
            let amountPerPerson = grandTotal / peopleCount
            return amountPerPerson
        }
        return nil
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Beløb", text: $checkAmount)
                        .keyboardType(.decimalPad)
                    
                    TextField("Antal personer", text: $noPeople)
                        .keyboardType(.decimalPad)
                    
                }
                
                Section(header: Text("Hvor meget i drikkepenge?")) {
                    Picker("Drikkepenge", selection: $tipAmount) {
                        ForEach(0..<tips.count) { i in
                            Text("\(tips[i])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Total beløb")) {
                    Text("kr. \(grandTotal, specifier: "%.2f")")
                        .foregroundColor(tipAmount == 4 ? .red : .primary
                        )
                }
                
                Section(header: Text("Beløb per person")) {
                    if let totalPerPerson = totalPerPerson {
                        Text("kr. \(totalPerPerson, specifier: "%.2f")")
                    } else {
                        Text("kr.")
                    }
                }
            }
            .navigationBarTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
