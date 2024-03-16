
import Foundation
import SwiftUI

@Observable
class ModelData{
    var location : [Location] = load("zipcodes.th.json")

}

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data


    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }


    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }


    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}

struct PostalModelData : View {
    var modelData = ModelData()
    var body : some View {
        Text(modelData.location[711].latitude)
    }
}
struct Location : Decodable {
    var country_code : String
    var zipcode: String
    var place: String
    var state: String
    var state_code: String
    var province : String
    var province_code : String
    var community : String
    var community_code : String
    var latitude : String
    var longitude : String
}

