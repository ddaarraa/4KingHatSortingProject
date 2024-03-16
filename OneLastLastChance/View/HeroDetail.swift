import SwiftUI
import MapKit

struct HeroDetail: View {
    @ObservedObject var vm = HeroDataViewModel()
    @Environment(Current_State.self) var current_state
    var specific_name : String
//    @Environment(postalModel.self) var modelData
    let modelData  = ModelData()
    func coordinate() -> CLLocationCoordinate2D {
        let specific_element = vm.savedEntities.first(where: {$0.fullName == specific_name})
        let postalCode = specific_element!.postalCode
        
        //        var location = modelData.location.first(where: {0$.})
        var index : Int { modelData.location.lastIndex( where: { $0.zipcode == postalCode}) ?? 0 }
        
        //        location.postalcode
        
        let coordinate : CLLocationCoordinate2D
        
        if(index != 0){
            
            return CLLocationCoordinate2D(
                latitude : Double(modelData.location[index].latitude)!,
                longitude :  Double(modelData.location[index].longitude)!
            )
        }else {
            return CLLocationCoordinate2D(latitude: 38.8719, longitude: 77.0563)
        }
        
    }
    
    var body: some View {
        let specific_element = vm.savedEntities.first(where: {$0.fullName == specific_name})
        let postalCode = specific_element!.postalCode
        var index : Int { modelData.location.lastIndex( where: { $0.zipcode == postalCode}) ?? 0 }
        
        
         
        ScrollView{
            
            
            
            
            VStack(alignment: .leading) {
                Image("4kings").resizable().scaledToFit()
                
                
                VStack{
                    Image("anonymous")
                        .resizable()
                        .frame(width: 170, height: 170)
                        .clipShape(Circle())
                        .overlay{
                            Circle().stroke(.white, lineWidth: 4)
                        }.shadow(radius: 7)
                        .offset(y:-40)
                        
                    VStack{
                        HStack{
                            Text(specific_element?.fullName ?? "null")
                                .font(.title)
                                
                        }
                        //                    FavoriteButton(isSet: $modelData.landmarks[landmarkIndex].isFavorite)
                        if index != 0 {
                            
                            
                            HStack{
                                Text(modelData.location[index].place )
                                
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                                
                            }
                            HStack{
                                Text(modelData.location[index].state )
                                
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                                
                            }
                        }else {
                            HStack{
                                Text("Pentagon/USA" )
                                
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                                
                            }
                        }
//                        HStack{
//                            Text(ceremony().sorting_hat())
//                        }
                    }
                    .offset(y:-30)
                    Divider().foregroundColor(.black)
                }
                var image_name = specific_element?.department ?? "null"
                Image(image_name).resizable().scaledToFit()
                
                
            }
            
            .onAppear{
//                vm2.fetchData()
                vm.fetchData()
            }
            
            MapView(coordinate: coordinate()).frame(height: 300)
            .padding()
            
            
            
            
            
//            Text(specific_element.fullName ?? "No Name")
//            Text(specific_element.postalCode ?? "No PostalCode")
            
        }
    }
}

//#Preview {
//    
//    HeroDetail(specific_name: "Ai Haaa")
//        
//}
