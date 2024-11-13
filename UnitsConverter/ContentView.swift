//
//  ContentView.swift
//  UnitsConverter
//
//  Created by Anna Filin on 12/11/2024.
//

import SwiftUI

extension Color {
    static var darkBlue: Color {
        return Color(hue: 0.6, saturation: 0.7, brightness: 0.3, opacity: 0.9)
    }
}


enum TemperatureUnit: String, CaseIterable, Identifiable {
    case celsius = "Celsius"
    case fahrenheit = "Fahrenheit"
    case kelvin = "Kelvin"
    
    var id: String { self.rawValue }
    
    var unit: UnitTemperature {
        switch self {
        case .celsius: return .celsius
        case .fahrenheit: return .fahrenheit
        case .kelvin: return .kelvin
        }
    }
}

struct ContentView: View {
    @State private var convertFrom: TemperatureUnit = .celsius
    @State private var convertTo: TemperatureUnit = .fahrenheit
    @State private var inputVal = 15.0
    @State private var displayedConvertedValue: Double = 0.0
    
    var convertedValue: Double {
        let inputMeasurement = Measurement(value: inputVal, unit: convertFrom.unit)
        let outputMeasurement = inputMeasurement.converted(to: convertTo.unit)
        return outputMeasurement.value
    }
    
    var unitSymbolTo: String {
        switch convertTo {
        case .celsius:
            return "°C"
        case .fahrenheit:
            return "°F"
        case .kelvin:
            return "K"
        }
    }
    
    var unitSymbolFrom: String {
        switch convertFrom {
        case .celsius:
            return "°C"
        case .fahrenheit:
            return "°F"
        case .kelvin:
            return "K"
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Section {
                    HStack {
                        VStack {
                            Picker("From: ", selection: $convertFrom) {
                                ForEach(TemperatureUnit.allCases) { unit in
                                    Text(unit.rawValue).tag(unit)
                                }
                            }
                            .pickerStyle(.wheel)
                            
                            HStack {
                                TextField("\(unitSymbolFrom) Temperature", value: $inputVal, format: .number)
                                    .keyboardType(.decimalPad)
                                    .padding()
                                    .foregroundColor(.black)
                                    .background(Color.white)
                                    .cornerRadius(5)
                                    .frame(width: 80, height: 50)
                                
                                Text(unitSymbolFrom)
                                    .foregroundColor(.gray)
                                    .padding(.leading, 4)
                                    .frame(width: 30, height: 50, alignment: .leading)
                            }
                            .padding()
                        }
                        
                        VStack {
                            Picker("Convert to", selection: $convertTo) {
                                ForEach(TemperatureUnit.allCases) { unit in
                                    Text(unit.rawValue).tag(unit)
                                }
                            }
                            .pickerStyle(.wheel)
            
                            Text("\(convertedValue, specifier: "%.2f") \(unitSymbolTo)")
                                .padding()
                                .foregroundColor(.secondary)
                                .background(.secondary)
                                .cornerRadius(5)
                                .frame(width: 150, height: 50, alignment: .leading)
                        }
                    }
                }
                .fontWeight(.bold)
                .font(.title2)
                
                Spacer()
            }
            .padding()
            .navigationTitle("Temperature Converter")
            .background(Color.darkBlue)
            .onAppear {
                updateConvertedValue()
            }
        }
        .preferredColorScheme(.dark)
    }
    
    private func updateConvertedValue() {
        let inputMeasurement = Measurement(value: inputVal, unit: convertFrom.unit)
        let outputMeasurement = inputMeasurement.converted(to: convertTo.unit)
        displayedConvertedValue = outputMeasurement.value
    }
}

#Preview {
    ContentView()
}
