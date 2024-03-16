////
////  heroRowView.swift
////  OneLastLastChance
////
////  Created by dara sroin on 14/3/2567 BE.
////
//
import SwiftUI

struct heroListView: View {
    @ObservedObject var vm = HeroDataViewModel()
    @State private var isLinkActive = false
    @Environment(Current_State.self) var current_state
    @ObservedObject private var vm2 = SystemDataViewModel()
    

//    @ObservedObject private var Ceremony = ceremony(current_MaxAmount: current_state.number_input)
    
    var body: some View {
//        Text("\(vm2.savedEntities[0].department1_quota)")
        NavigationSplitView {
            
            VStack {
                if(vm.savedEntities.isEmpty){
                    
                    Text("No Dude Exist!")
                    
//                    let departments = ["kanok","Inthorn","prachacheun","booraphon"]
                    
                    Text("kanok quota : \(vm2.getQuota(int: 0))")
                    Text("Inthorn quota : \(vm2.getQuota(int: 1))")
                    Text("prachacheun quota : \(vm2.getQuota(int: 2))")
                    Text("booraphon quota : \(vm2.getQuota(int: 3))")
//                    Text("DepartMent 4 quota : \(vm2.getQuota(int: 2))")
                    
                }else{
                    
                    List{
                        
                        ForEach(vm.savedEntities) { entity in
                            NavigationLink(destination: HeroDetail(specific_name: entity.fullName!)) {
                                HStack {
                                    Image(uiImage: UIImage(data: entity.pic!)!)
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                    Text(entity.fullName ?? "no name")
                                        .font(.subheadline)
                                    Text(entity.postalCode ?? "no name")
                                        .font(.subheadline)
                                    Text(entity.department ?? "no department")
                                        .font(.subheadline)
                                }
                            }
                        }
//                        .onDelete(perform: vm.deleteData)
                        
                        
                        
                        
                    }
                    
                    
                    
//                    Button(/*@START_MENU_TOKEN@*/"Button"/*@END_MENU_TOKEN@*/) {
//                        Sorting().sorting(ceremony: Ceremony)
//                        vm.fetchData()
//                    }
                    
                    
                    
                    .listStyle(PlainListStyle()) // Set list style to plain
                    .navigationTitle("Hero List")
//                    Text("Maximum : \(current_state.maximum_amount) ")
                    VStack{
                        Text("kanok quota : \(vm2.getQuota(int: 0))")
                            
                        Text("Inthorn quota : \(vm2.getQuota(int: 1))")
                        Text("prachacheun quota : \(vm2.getQuota(int: 2))")
                        Text("booraphon quota : \(vm2.getQuota(int: 3))")
                    }
                    
                    
                    
                }
                    
            }
            .onAppear{
                vm.fetchData()
                vm2.fetchData()
//                current_state.sortingCeremony()
            }
        }detail: {
            
        }
        
            
    
    }
}

#Preview {
    heroListView()
        .environment(Current_State())

}

