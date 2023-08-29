import SwiftUI

struct CarListView: View {
    @ObservedObject var viewModel: CarListViewModel
    @State private var searchText: String = ""
     
    var body: some View {
        ScrollView {
            VStack {
                // Search bar at the top with added padding
                SearchBar(text: $searchText)
                    .padding(.horizontal)
                    .padding(.top, 20) // Add extra padding at the top
                
                LazyVStack(spacing: 20) {
                    ForEach(viewModel.userCars.filter({ car in  // <-- changed `viewModel.cars` to `viewModel.userCars`
                        searchText.isEmpty ? true : car.name.lowercased().contains(searchText.lowercased())
                    })) { car in
                        NavigationLink(destination: CarDetailView(car: car)) {
                            HStack {
                                // Small blue car icon
                                Image(systemName: "car.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(.blue) // Blue Icon
                                
                                // Text information
                                VStack(alignment: .leading, spacing: 10) {
                                    HStack {
                                        Text("\(car.year) \(car.name)")  // Display Year
                                            .font(.headline)
                                            .fontWeight(.bold)
                                            .foregroundColor(.black) // Black Text
                                        Text(car.model)
                                            .font(.headline)
                                            .foregroundColor(.black) // Black Text
                                    }
                                    Text("Plate: \(car.numberPlate)")  // Display Number Plate
                                        .font(.body)
                                        .foregroundColor(.black) // Black Text
                                }
                                Spacer()
                            }

                            .padding()
                            .background(Color(UIColor.systemBackground)) // adapts to light/dark mode
                            .cornerRadius(10)
                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                        }
                    }
                }
                .padding()
            }
        }
        .background(Color.gray.opacity(0.05))
        .navigationBarTitle("Cars", displayMode: .inline)
        .navigationBarItems(leading:
            Button(action: {
                // Your logout action here
            }) {
                Text("Logout")
                    .foregroundColor(.blue)
            },
            trailing: NavigationLink(destination: AddCarView(viewModel: viewModel)) {
                Image(systemName: "plus")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color.blue)
            }
        )
    }
}
