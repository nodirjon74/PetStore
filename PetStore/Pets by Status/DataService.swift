//
//  DataService.swift
//  PetStore
//
//  Created by Nodir on 09/08/22.
//

import Foundation
import RealmSwift

struct DataService {
    
    private let realm = try! Realm()
    
    func saveData(_ data: [PetModel]?) throws {
        
        guard let items = data else {
            throw NSError(domain: "Data object nil", code: 0, userInfo: nil)
        }
        
        do {
            try realm.write {
                self.realm.deleteAll()
                self.realm.add(items)
            }
        } catch {
            throw NSError(domain: "Couldn't find data object", code: 0, userInfo: nil)
        }
    }
    
    func retrieveData() throws -> AnyObject? {
        print("Presenter retrieves Item objects from the Realm Database.")
        let items = realm.objects(PetModel.self)
        
        
        let mod: [PetModel]? = items.reversed()
        
        guard mod != nil else {
            throw NSError(domain: "Couldn't find data object", code: 0, userInfo: nil)
        }
        
        print(items.count)
        return mod as AnyObject
        

    }

    
}
