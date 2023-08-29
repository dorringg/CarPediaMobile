import SwiftUI

struct EditCarView: View {
    @Binding var car: Car

    @State private var selectedDate = Date()
    @State private var kilometers: Int = 0
    @State private var year: String = "" // <-- Added year
    @State private var numberPlate: String = "" // <-- Added number plate

    var body: some View {
        Form {
            TextField("Name", text: $car.name)
            TextField("Model", text: $car.model)
            TextField("Year", text: $year) // <-- Added year field
                .keyboardType(.numberPad)
            TextField("Number Plate", text: $numberPlate) // <-- Added number plate field
                .autocapitalization(.allCharacters)
            Stepper("Kilometers: \(kilometers)", value: $kilometers)
            DatePicker("Last Service Date", selection: $car.lastServiceDate)
            DatePicker("WOF Date", selection: $car.wofDate)
            // More fields for images would be needed here
        }
        .onAppear {
            kilometers = car.kilometers
            year = "\(car.year)" // <-- Initialized year
            numberPlate = car.numberPlate // <-- Initialized number plate
        }
        .onDisappear {
            car.kilometers = kilometers
            car.year = Int(year) ?? car.year // <-- Updated year
            car.numberPlate = numberPlate // <-- Updated number plate
        }
        .navigationBarTitle("Edit Car", displayMode: .inline)
    }
}
