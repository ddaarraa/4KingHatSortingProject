//
//  SwiftUIView.swift
//  OneLastLastChance
//
//  Created by dara sroin on 14/3/2567 BE.
//

import SwiftUI
import CoreData
import UIKit

class HeroDataViewModel : ObservableObject {
    let container : NSPersistentContainer
    @Published var savedEntities : [Hero] = []
    
    init() {
        container = NSPersistentContainer(name: "OneLastLastChance")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("ERROR LOADING CORE DATA . \(error)")
            }else {
                print("Successfully loading core data!")
            }
        }
        fetchData()
    }
    func fetchData () {
        let request = NSFetchRequest<Hero>(entityName: "Hero")
        do{
           savedEntities = try container.viewContext.fetch(request)
        }catch let error {
            print("Error fetching. \(error)")
        }
    }
    func addData(text1 : String, text2 : String, pic_resource : String, department : String) {
        let newData = Hero(context: container.viewContext)
        newData.fullName = text1
        newData.postalCode = text2
        if let image = UIImage(named: pic_resource) {
            if let imageData = image.pngData() { // You can use JPEG representation if preferred with UIImageJPEGRepresentation
                // Assign the binary data to the Core Data attribute
                newData.pic = imageData
            }
        }
        newData.department = department
        // Save the changes to Core Data
        
        saveData()
    }
//    func addPostal(text : String) {
//        let newData = Hero(context: container.viewContext)
//        newData.postalCode = text
//        saveData()
//    }
    func deleteData(indexSet : IndexSet) {
        guard let index = indexSet.first else { return }
        let entity = savedEntities[index]
        let departments = ["kanok","Inthorn","prachacheun","booraphon"]
        var index1 = 0
        for i in 0..<4 {
            if(departments[i] == entity.department){
                index1 = i
                SystemDataViewModel().UpdateQuota(input: 1, department: index1)
                SystemDataViewModel().saveData()
            }
        }
        
        
        container.viewContext.delete(entity)
        
        saveData()
    }
    
    func updateData(entity : Hero) {
        let currentName = entity.fullName ?? ""
        let newName = currentName + "!"
        entity.fullName = newName
        saveData()
    }
    func addPic(name : String) {
        let newData = Hero(context: container.viewContext)
        if let image = UIImage(named: name) {
            if let imageData = image.pngData() { 
                newData.pic = imageData
            }
        }
        // Save the changes to Core Data
        saveData()
        
    }
    func updateDepartment(entity : Hero, newDepartment : String){
        entity.department = newDepartment
        saveData()
    }
    func resetDepartment(){
        for entity in savedEntities {
            entity.department = "no department"
        }
        saveData()
    }
    func sortinghat(){
        
//        for entity in savedEntities {
//            entity.department = "kuy"
//        }
        let departments = ["kanok","Inthorn","prachacheun","booraphon"]
        @ObservedObject var vm2 = SystemDataViewModel()
        
        for entity in savedEntities {
            if (entity.department == "no department"){
                while true {
                    let RandNum = Int.random(in: 0...3)
                    if(vm2.getQuota(int: RandNum) > 0){
                        vm2.UpdateQuota(input: -1, department: RandNum)
                        updateDepartment(entity: entity, newDepartment: departments[RandNum])
                        break
                    }
                }
            }
        }
        saveData()
    }
    
    func saveData() {
        do {
            try container.viewContext.save()
            fetchData()
        }catch let error {
            print("Error saving \(error)")
        }
    }
}



class SystemDataViewModel : ObservableObject {
    let container : NSPersistentContainer
    @Published var savedEntities : [WillNeed] = []
    
    init() {
        container = NSPersistentContainer(name: "OneLastLastChance")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("ERROR LOADING CORE DATA . \(error)")
            }else {
                print("Successfully loading core data!")
            }
        }
        fetchData()
    }
    func fetchData () {
        let request = NSFetchRequest<WillNeed>(entityName: "WillNeed")
        do{
           savedEntities = try container.viewContext.fetch(request)
        }catch let error {
            print("Error fetching. \(error)")
        }
    }
    func saveData() {
        do {
            try container.viewContext.save()
            fetchData()
        }catch let error {
            print("Error saving \(error)")
        }
    }
    func UpdateQuota(input : Int, department : Int) {
//        let newData = WillNeed(context: container.viewContext)
        
        if department == 0{
            savedEntities[0].department1_quota += Int16(input)
        }else if department == 1 {
            savedEntities[0].department2_quota += Int16(input)
        }else if department == 2 {
            savedEntities[0].department3_quota += Int16(input)
        }else {
            savedEntities[0].department4_quota += Int16(input)
        }
        
        saveData()
    }
    func deleteData(indexSet : IndexSet) {
        guard let index = indexSet.first else { return }
        let entity = savedEntities[index]
        container.viewContext.delete(entity)
        saveData()
    }
    func InitializeData() {
        let newData = WillNeed(context: container.viewContext)
    
        newData.department1_quota = 0
        newData.department2_quota = 0
        newData.department3_quota = 0
        newData.department4_quota = 0
        
        // Save the changes to Core Data
        saveData()
    }
    func resetQuota() {
        if(savedEntities.endIndex==0){
            InitializeData()
        }
//        let newData = WillNeed(context: container.viewContext)
        
        savedEntities[0].department1_quota = 0
        savedEntities[0].department2_quota = 0
        savedEntities[0].department3_quota = 0
        savedEntities[0].department4_quota = 0
        saveData()
    }
    func getQuota(int : Int) -> Int {
        if int == 0{
            return Int(savedEntities[0].department1_quota)
        }else if int == 1 {
            return Int(savedEntities[0].department2_quota)
        }else if int == 2 {
            return Int(savedEntities[0].department3_quota)
        }else {
            return Int(savedEntities[0].department4_quota)
        }
    }
}





//#Preview {
//    CoreDataBootCamp()
//}
