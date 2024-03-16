//
//  HomePage.swift
//  OneLastLastChance
//
//  Created by dara sroin on 15/3/2567 BE.
//

import SwiftUI

struct HomePage: View {
    @State var textFieldText1 : String = ""
    @State private var isLinkActive = false
    @State private var isHeroRowViewPresented = false
    @ObservedObject private var vm = HeroDataViewModel()
    @ObservedObject private var vm2 = SystemDataViewModel()
    @Environment(Current_State.self) var current_state
    
    var body: some View {
        
        NavigationSplitView {
            ZStack {
                Image("4kingsBackground")
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Text("Hello Cruel World")
                        .font(.title)
                        .bold()
                        .foregroundStyle(.white)
                        .padding()
                   
                }.offset(y:-250)
                VStack {
                    Text("Current Member In Database : \(vm.savedEntities.endIndex)")
                        .font(.subheadline)
                        .bold()
                        .foregroundStyle(.white)
                        .padding()
                    
                }.offset(y:-200)
                
                ZStack{
                    VStack{
                        Rectangle()
                            .fill(Color.white)
                            .frame(width: 300, height: 50)
                            .cornerRadius(10)
                            .shadow(radius: 3).overlay{
                                TextField("Must be more than \(vm.savedEntities.endIndex) ", text : $textFieldText1)
                                    .font(.headline)
                                    .padding(.leading)
                                    .background(Color(.white))
                                    .cornerRadius(10)
                                    .keyboardType(.numberPad)
                                    .padding(.horizontal)
                            }
                    }
                    
                }.offset(y:-50)
                
                VStack{
                    
                
                    
                    Button("Confirm") {
                        if(Int(textFieldText1)! > vm.savedEntities.endIndex ){
                            current_state.update_state(input: Int(textFieldText1)!)
                            
                            
                            self.isLinkActive = true
                            current_state.updateQuota()
                            vm.resetDepartment()
                            vm2.resetQuota()
                            
                        }else{
                            textFieldText1 = ""
                            
                        }
                        
                    }.foregroundColor(.white)
                    
                    NavigationLink(
                        destination: ContentView(),
                        isActive: $isLinkActive,
                        label: { EmptyView() }
                    ).isDetailLink(false)
                    .hidden()
                    .navigationBarHidden(true)
                    
                }
                
                
            }
            
            .onAppear{
                vm.resetDepartment()
                vm.fetchData()
               
                vm2.resetQuota()
                vm2.fetchData()
            
            }
        }detail: {
        }
        
//        
    }
    
}

#Preview {
    HomePage()
        .environment(Current_State())
        
}

