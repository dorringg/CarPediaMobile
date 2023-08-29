import SwiftUI
import UIKit
import Firebase
import FirebaseDatabase

class CarListViewModel: ObservableObject {
    @Published var cars: [Car] = []
    @Published var isLoggedIn: Bool = false
    @Published var userCars: [Car] = [] // Add this line
    
    func fetchUserCars() {
        guard let user = Auth.auth().currentUser else {
            return
        }

        let db = Firestore.firestore()
        db.collection("users").document(user.uid).collection("cars").addSnapshotListener { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                var fetchedCars: [Car] = []
                for document in querySnapshot!.documents {
                    if let car = Car(dictionary: document.data()) {
                        fetchedCars.append(car)
                    }
                }
                self.userCars = fetchedCars
            }
        }
    }

    
    func addCar(name: String, model: String, year: Int, numberPlate: String, kilometers: Int, lastServiceDate: Date, wofDate: Date, images: [UIImage]) {
        guard let user = Auth.auth().currentUser else {
            return
        }

        let newCar = Car(name: name, model: model, year: year, numberPlate: numberPlate, kilometers: kilometers, lastServiceDate: lastServiceDate, wofDate: wofDate, images: images)

        let db = Firestore.firestore()
        db.collection("users").document(user.uid).collection("cars").addDocument(data: newCar.toDictionary()) { error in
            if let error = error {
                print("Error writing document: \(error)")
            } else {
                print("Document successfully written!")
                self.fetchUserCars()  // Fetch cars again after adding a new car
            }
        }
    }

}
