//
//  ContentView.swift
//  OneLastLastChance
//
//  Created by dara sroin on 14/3/2567 BE.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State private var selection: Tab = .list
    @ObservedObject private var vm = HeroDataViewModel()
    @ObservedObject private var vm2 = SystemDataViewModel()
    @Environment(Current_State.self) var current_state
  
    

    enum Tab {
//        case home
        case feature
        case list
        
    }
    var body : some View {
        
        
        
        TabView(selection: $selection ) {

            heroListView()
                .tabItem {
                    Label("List", systemImage: "list.bullet").onAppear{
                    }
                }
                .tag(Tab.list)
                .onAppear{
                    vm.fetchData()
                    vm2.fetchData()
//                    current_state.sortingCeremony()
                    }
            
            
            list_operation()
                .tabItem {
                
                    Label("Add", systemImage: "plus").onAppear{
                
                    }
                }.tag(Tab.feature)
                    .onAppear{
                   
                    vm.fetchData()
                    vm2.fetchData()
//                    current_state.sortingCeremony()
                }
            
        }
                
        
    }
}
#Preview {
    ContentView()
        .environment(Current_State())
}

