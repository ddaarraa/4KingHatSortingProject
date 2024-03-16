//
//  OneLastLastChanceApp.swift
//  OneLastLastChance
//
//  Created by dara sroin on 14/3/2567 BE.
//


// starting point of the app
// please run this one in order to execute the simulation
 
import SwiftUI

@main
struct OneLastLastChanceApp: App {
    
    let currentState = Current_State()
    
    var body: some Scene {
        WindowGroup {
            HomePage()
                .environment(currentState)
        }
    }
}
