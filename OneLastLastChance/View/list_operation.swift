//
//  list_operation.swift
//  OneLastLastChance
//
//  Created by dara sroin on 15/3/2567 BE.
//

import SwiftUI

struct list_operation: View   {
    
    @StateObject var vm = HeroDataViewModel()
    @State var textFieldText1 : String = ""
    @State var textFieldText2 : String = ""
    @Environment(Current_State.self) var current_state
    @StateObject var vm2 = SystemDataViewModel()
    
    
    
    var body: some View{
        
        NavigationSplitView {
            
//            Text("Fill in Information")
//                .padding()
            VStack(spacing : 20){
                if(vm.savedEntities.endIndex < current_state.maximum_amount){
                    
                    Text("Fill in Information")
                        .padding()
                    ZStack{
                        Rectangle()
                            .fill(Color.white)
                            .frame(width: 300, height: 50)
                            .cornerRadius(10)
                            .shadow(radius: 3).overlay{
                                TextField("Fullname ", text : $textFieldText1)
                                    .font(.headline)
                                    .padding(.leading)
                                    .background(Color(.white))
                                    .cornerRadius(10)
                                    .padding(.horizontal)
                            }
                    }
                    ZStack{
                        Rectangle()
                            .fill(Color.white)
                            .frame(width: 300, height: 50)
                            .cornerRadius(10)
                            .shadow(radius: 3).overlay{
                                TextField("Address(Postal Code)", text : $textFieldText2)
                                    .font(.headline)
                                    .padding(.leading)
                                    .background(Color(.white))
                                    .cornerRadius(10)
                                    .padding(.horizontal)
                            }
                    }
                    Button(action : {
                        guard !textFieldText1.isEmpty else {return}
                        vm.addData(text1: textFieldText1, text2: textFieldText2 , pic_resource: "anonymous", department: "no department")
                        textFieldText1 = ""
                        textFieldText2 = ""
                        
                        if(HeroDataViewModel().savedEntities.endIndex == current_state.maximum_amount  ){
//                            current_state.sortingCeremony()
                            vm.sortinghat()
                        }

                        
                    }, label: {
                        Text("Add")
                    })
                    .padding(.horizontal)
                }else{
                    
                    Spacer()
                    Text("Full House !!!")
                    .padding(.horizontal)
                    
                }
                
                Spacer()
                List{
                    
                    ForEach(vm.savedEntities){ entity in
                        HStack{
                            Image(uiImage: UIImage(data: entity.pic!)!).resizable().frame(width:50, height:50)
                                .frame(width: 30, height: 30)
                        
                            Text(entity.fullName ?? "NO Name")
                                .font(.subheadline)
                            Text(entity.postalCode ?? "No Postal")
                                .font(.subheadline)
                            Text(entity.department ?? "No department")
                                .font(.subheadline)
                            
//
                                    
                        }.padding(EdgeInsets())
//                        Image(entity.pic ?? "NUll")
                        
                    }
                    .onDelete(perform: vm.deleteData)
                }
            }.onAppear{
                vm2.fetchData()
                vm.fetchData()
            
            }
            
        }detail: {
            
        }.navigationTitle("List Operation")
    }
}
//#Preview {
//    list_operation()
//        .environment(CurrentState())
//}

