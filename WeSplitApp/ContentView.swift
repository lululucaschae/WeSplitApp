//
//  ContentView.swift
//  WeSplitApp
//
//  Created by Lucas Chae on 4/27/22.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 0
    @State private var tipPercentage = 20
    @FocusState private var checkIsFocused: Bool
    
    let listOfTips = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount * tipSelection / 100
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        
        return amountPerPerson
    }
    
    var grandTotal: Double {
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount * tipSelection / 100
        return checkAmount + tipValue
    }
    
    var dollarFormat: FloatingPointFormatStyle<Double>.Currency {
        let currencyCode = Locale.current.currencyCode ?? "USD"
        return FloatingPointFormatStyle<Double>.Currency(code: currencyCode)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: dollarFormat)
                        .keyboardType(.decimalPad)
                        .focused($checkIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<20) {number in
                            Text("\(number) people")
                        }
                    }
                }
                
                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(listOfTips, id: \.self) {percentage in
                            Text(percentage, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Choose your tip percentage")
                }
                
                
                Section {
                    HStack {
                        Text("Grand total")
                        Spacer()
                        Text(grandTotal, format: dollarFormat)
                            .bold()
                    }
                    HStack {
                        Text("Check per person")
                        Spacer()
                        Text(totalPerPerson, format: dollarFormat)
                            .bold()
                    }
                } header: {
                    Text("Final payments")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        checkIsFocused = false
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

