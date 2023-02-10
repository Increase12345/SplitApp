//
//  ContentView.swift
//  WeSplit
//
//  Created by Nick Pavlov on 2/8/23.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    // Define the total price for each person
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    // Define the total amount with tips
    var totalAmount: Double {
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        
        return grandTotal
    }
    
    // Converting currency to double
    var localCurrency: FloatingPointFormatStyle<Double>.Currency {
        .currency(code: Locale.current.identifier)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    
                    // TextField with amount $
                    TextField("", value: $checkAmount, format: localCurrency)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    // Choosing how many people
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                // Tip selection
                Section {
                    Picker("", selection: $tipPercentage) {
                        ForEach(0...100, id: \.self) {
                            Text("\($0, format: .percent)")
                        }
                    }
                    .pickerStyle(.wheel)
                } header: {
                    Text("How much tip do you want to leave?")
                }
                
                // Showing grand total (amount + tips)
                Section {
                    Text("$\(totalAmount, format: localCurrency)")
                } header: {
                    Text("Grand total")
                }
                
                // Showing the price for each person
                Section {
                    Text("$\(totalPerPerson, format: localCurrency)")
                } header: {
                    Text("Amount per person")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
