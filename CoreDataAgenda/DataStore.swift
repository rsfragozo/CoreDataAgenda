//
//  DataStore.swift
//  CoreDataAgenda
//
//  Created by vinigodoy on 17/02/16.
//  Copyright © 2016 HSBC. All rights reserved.
//


import UIKit
import CoreData
import Foundation

class DataStore {
    static let instance = DataStore()
    
    fileprivate let managedContext = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
    
    fileprivate init() {
    }
    
    func getPersonList() -> [Person] {
        let request = NSFetchRequest(entityName: "Person")
        return try! managedContext.fetch(request) as! [Person]
    }
    
    func getPhoneList() -> [Phone] {
        let request = NSFetchRequest(entityName: "Phone")
        return try! managedContext.fetch(request) as! [Phone]
    }
    
    fileprivate func saveContext() -> Bool {
        do {
            try managedContext.save()
            return true
        } catch {
            print(error)
            return false
        }
    }
    
    func savePerson(_ name:String, phones: [String]) -> Bool {
        let personEntity = NSEntityDescription.entity(forEntityName: "Person", in: managedContext)
        let person = Person(entity: personEntity!, insertInto: managedContext)
        person.name = name
        
        let personPhones = person.phones?.mutableCopy() as! NSMutableSet
        for phoneNumber in phones {
            let phoneEntity = NSEntityDescription.entity(forEntityName: "Phone", in: managedContext)
            let phone = Phone(entity: phoneEntity!, insertInto:  managedContext)
            phone.number = phoneNumber
            personPhones.add(phone)
        }
        person.phones = personPhones.copy() as? NSSet
        return saveContext()
    }
    
    func removePersonAtRow(_ row : Int) -> Bool {
        let list = getPersonList()
        let person = list[row]
//        for phone in person.phones {
//            managedContext.deleteObject(phone as Phone!)
//        }
        managedContext.delete(person)
        return saveContext()
    }
    
    func updatePerson(_ name : String, row : Int) -> Bool {
        let list = getPersonList()
        let person = list[row]
        person.name = name
        return saveContext()
    }
    
    func removePhoneAtRow(_ row : Int) -> Bool {
        let list = getPhoneList()
        let phone = list[row]
        let personPhones = phone.person?.phones?.mutableCopy() as! NSMutableSet
        personPhones.remove(phone)
        managedContext.delete(phone)
        return saveContext()
    }
}
