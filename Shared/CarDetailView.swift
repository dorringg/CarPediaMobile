import SwiftUI

struct CarDetailView: View {
    @State var car: Car
    @State var selectedImage: UIImage? // For holding the selected image

    var body: some View {
        Form {
            // Car details
            Section(header: Text("Car Information")) {
                Text(car.name).font(.headline)
                Text(car.model).font(.subheadline)
                Text("\(car.kilometers) km").font(.body)
            }
            
            Section(header: Text("Service Information")) {
                Text("Last Service: \(car.lastServiceDate, formatter: DateFormatter.shortDate)")
                Text("WOF: \(car.wofDate, formatter: DateFormatter.shortDate)")
            }

            // Display images
            Section(header: Text("Images")) {
                ForEach(car.images.prefix(3), id: \.self) { image in
                    NavigationLink(destination: ImageDetailView(image: image)) {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: .infinity)
                            .frame(height: 200)
                            .clipped()
                            .cornerRadius(8)
                    }
                }
            }
        }
        .navigationBarItems(trailing: NavigationLink("Edit Details", destination: EditCarView(car: $car)))
    }
}

// A view to show the image in detail
struct ImageDetailView: View {
    var image: UIImage

    var body: some View {
        Image(uiImage: image)
            .resizable()
            .scaledToFit()
            .navigationBarTitle("Image Detail", displayMode: .inline)
    }
}
