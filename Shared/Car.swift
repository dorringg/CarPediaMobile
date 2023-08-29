import Foundation
import UIKit

struct Car: Identifiable {
    var id = UUID() // Add an id property
    var name: String // Change 'let' to 'var'
    var model: String // Change 'let' to 'var'
    var year: Int // Change 'let' to 'var'
    var numberPlate: String // Change 'let' to 'var'
    var kilometers: Int
    var lastServiceDate: Date
    var wofDate: Date
    var images: [UIImage]
    
    // Initialize Car from individual properties
    init(name: String, model: String, year: Int, numberPlate: String, kilometers: Int, lastServiceDate: Date, wofDate: Date, images: [UIImage]) {
        self.name = name
        self.model = model
        self.year = year
        self.numberPlate = numberPlate
        self.kilometers = kilometers
        self.lastServiceDate = lastServiceDate
        self.wofDate = wofDate
        self.images = images
    }
    
    // Initialize Car from a dictionary
    init?(dictionary: [String: Any]) {
        guard
            let name = dictionary["name"] as? String,
            let model = dictionary["model"] as? String,
            let year = dictionary["year"] as? Int,
            let numberPlate = dictionary["numberPlate"] as? String,
            let kilometers = dictionary["kilometers"] as? Int,
            let lastServiceTimestamp = dictionary["lastServiceDate"] as? TimeInterval,
            let wofTimestamp = dictionary["wofDate"] as? TimeInterval,
            let imagesData = dictionary["images"] as? [Data]
        else {
            return nil
        }
        
        self.name = name
        self.model = model
        self.year = year
        self.numberPlate = numberPlate
        self.kilometers = kilometers
        self.lastServiceDate = Date(timeIntervalSince1970: lastServiceTimestamp)
        self.wofDate = Date(timeIntervalSince1970: wofTimestamp)
        
        // Convert Data to UIImage
        self.images = imagesData.compactMap { data in
            UIImage(data: data)
        }
    }
    
    func toDictionary() -> [String: Any] {
           let lastServiceTimestamp = lastServiceDate.timeIntervalSince1970
           let wofTimestamp = wofDate.timeIntervalSince1970
           
           // Convert images to Base64 encoded strings
           let imagesBase64: [String] = images.compactMap { image in
               if let imageData = image.jpegData(compressionQuality: 0.8) {
                   return imageData.base64EncodedString(options: [])
               }
               return nil
           }
           
           let dictionary: [String: Any] = [
               "name": name,
               "model": model,
               "year": year,
               "numberPlate": numberPlate,
               "kilometers": kilometers,
               "lastServiceDate": lastServiceTimestamp,
               "wofDate": wofTimestamp,
               "images": imagesBase64 // Store Base64 encoded image strings
           ]
           
           return dictionary
       }
}
