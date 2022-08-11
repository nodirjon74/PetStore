//
//  PetModel.swift
//  PetStore
//
//  Created by Nodir on 09/08/22.
//

import Foundation
import RealmSwift

class PetModel: Object, Codable  {
    @objc dynamic var id: Int
    @objc dynamic var name: String = ""
    @objc dynamic var status: String = ""
}

