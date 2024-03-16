//
//  SortingCerem.swift
//  OneLastLastChance
//
//  Created by dara sroin on 14/3/2567 BE.
//

import Foundation

    
    
import Foundation
import SwiftUI

@Observable
class Current_State : ObservableObject {
    
//    this function to calculate the quoata of every department,and to calculate and show the maximum amount of member in list
    
    var maximum_amount = HeroDataViewModel().savedEntities.endIndex
    var vm = HeroDataViewModel()
    var vm2 = SystemDataViewModel()
    
    
    func update_state(input : Int){
        if input > HeroDataViewModel().savedEntities.endIndex {
            maximum_amount = input
        }
        vm.fetchData()
        vm2.fetchData()
    }
    
    func updateQuota(){
        if maximum_amount % 4 == 0{
            for i in 0..<4{
                vm2.UpdateQuota(input: maximum_amount/4, department: i)
            }
        }else {
            for i in 0..<4{
                vm2.UpdateQuota(input: (maximum_amount-(maximum_amount%4))/4, department: i)
            }
            var noMoreAdd = [Int]()
            for _ in 0..<(maximum_amount%4){
                while true {
                    let RandNum = Int.random(in: 0...3)
                    if !noMoreAdd.contains(RandNum) {
                        noMoreAdd.append(RandNum)
                        vm2.UpdateQuota(input: 1, department: RandNum)
                        vm2.fetchData()
                        break
                    }
                }
            }
            
        }
    }
    
    
    
}

