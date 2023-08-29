import SwiftUI

struct AddCarView: View {
    @ObservedObject var viewModel: CarListViewModel
    
    @State private var name: String = ""
    @State private var model: String = ""
    @State private var year: String = ""  // New State
        @State private var numberPlate: String = ""  // New State
    @State private var kilometers: String = ""
    @State private var lastServiceDate = Date()
    @State private var wofDate = Date()
    
    @State private var isImagePickerPresented: Bool = false
    @State private var selectedImage: UIImage?
    @State private var images: [UIImage] = []
    
    var body: some View {
        Form {
            Section(header: Text("Vehicle Information")) {
                TextField("Brand Name", text: $name)
                TextField("Model", text: $model)
                TextField("Year", text: $year).keyboardType(.numberPad)  // New TextField
                TextField("Number Plate", text: $numberPlate)  // New TextField
                TextField("Kilometers", text: $kilometers).keyboardType(.numberPad)
            }
            
            Section(header: Text("Service Information")) {
                DatePicker("Last Service Date", selection: $lastServiceDate, displayedComponents: .date)
                DatePicker("WOF Date", selection: $wofDate, displayedComponents: .date)
            }
            
            Section(header: Text("Car Images")) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(images, id: \.self) { image in
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 150, height: 150)
                                .cornerRadius(8)
                        }
                    }
                }
                Button("Add Image") {
                    isImagePickerPresented.toggle()
                }
            }
        }
        .navigationBarTitle("Add Car", displayMode: .inline)
        .navigationBarItems(trailing: Button("Add Car") {
            viewModel.addCar(
                name: name, model: model, year: Int(year) ?? 0, numberPlate: numberPlate,
                kilometers: Int(kilometers) ?? 0, lastServiceDate: lastServiceDate, wofDate: wofDate, images: images
            )  // Update this method as well
            resetFields()
        }.disabled(name.isEmpty || model.isEmpty || year.isEmpty || numberPlate.isEmpty || kilometers.isEmpty))
        
        .sheet(isPresented: $isImagePickerPresented, onDismiss: loadImage) {
            ImagePicker(selectedImage: $selectedImage)
        }
    }
    
    func resetFields() {
        name = ""
        model = ""
        kilometers = ""
        images.removeAll()
    }
    
    func loadImage() {
        if let selectedImage = selectedImage {
            images.append(selectedImage)
        }
    }
}
