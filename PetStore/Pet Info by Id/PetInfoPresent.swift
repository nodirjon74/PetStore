//
//  PetInfoPresent.swift
//  PetStore
//
//  Created by Nodir on 11/08/22.
//

import Foundation
import Alamofire

protocol PetInfo: AnyObject {
    init(view: ViewUpdate, find byId: Int)
    func viewDidLoad()
}

class PetInfoPresent: PetInfo {
    
    var view: ViewUpdate?
    var petId: Int?
    private let ntw = Networking()
    private var dataService = DataService()
    
    required init(view: ViewUpdate, find byId: Int) {
        self.view = view
        self.petId = byId
    }
    
    func viewDidLoad() {
        if Connectivity.isConnectedToInternet {
            findByPetId()
        } else {
            do {
                try view?.onRetrieveData(dataService.retrieveData())
            } catch {
                view?.didFailWithError(error: error)
            }
        }
        
    }
    
    private func findByPetId() {
        ntw.req("https://petstore.swagger.io/v2/pet/\(petId!)", view: view!) { data in
            let decoder = JSONDecoder()

            do {
                let jsonDecoded = try decoder.decode(PetModel.self, from: data)
                return jsonDecoded as PetModel
            } catch {
                self.view?.didFailWithError(error: error)
            }
            print("Error")
            return PetModel.self as! Codable
        }
    }
    
}
