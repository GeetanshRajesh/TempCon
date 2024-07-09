import SwiftUI

struct ContentView: View {
    @State private var inputTemperature = ""
    @State private var inputUnit = "Celsius"
    @State private var outputUnit = "Fahrenheit"
    @State private var convertedTemperature = ""
    @FocusState private var amountIsFocused: Bool

    let tempUnits = ["Celsius", "Fahrenheit", "Kelvin"]

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Input Temperature")) {
                    TextField("Enter temperature", text: $inputTemperature)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                        .onChange(of: inputTemperature) {
                            convertTemperature()
                        }
                    Picker("Input Unit", selection: $inputUnit) {
                        ForEach(tempUnits, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .onChange(of: inputUnit) {
                        convertTemperature()
                    }
                }
                Section(header: Text("Output Temperature")) {
                    Picker("Output Unit", selection: $outputUnit) {
                        ForEach(tempUnits, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .onChange(of: outputUnit) {
                        convertTemperature()
                    }
                    Text("Converted Value: \(convertedTemperature)")
                }
            }
            .navigationTitle("Temperature Converter")
        }
        .toolbar {
            if amountIsFocused {
                Button("Done") {
                    amountIsFocused = false
                }
            }
        }
    }

    func convertTemperature() {
        guard let temp = Double(inputTemperature) else {
            convertedTemperature = ""
            return
        }

        var tempInCelsius: Double
        switch inputUnit {
        case "Fahrenheit":
            tempInCelsius = (temp - 32) * 5 / 9
        case "Kelvin":
            tempInCelsius = temp - 273.15
        default:
            tempInCelsius = temp
        }

        var result: Double
        switch outputUnit {
        case "Fahrenheit":
            result = (tempInCelsius * 9 / 5) + 32
        case "Kelvin":
            result = tempInCelsius + 273.15
        default:
            result = tempInCelsius
        }

        convertedTemperature = String(format: "%.2f", result)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
