//
//  PetPresenter.swift
//  PetStore
//
//  Created by Nodir on 09/08/22.
//

import Foundation
import RealmSwift

protocol PetViewPresenter: AnyObject {
    init(view: ViewUpdate)
    func viewDidLoad()
    func onSave()
    func segmentIndex(_ segTitle: String?) -> Int?
    
}

class PetPresenter: PetViewPresenter {
    
    var view: ViewUpdate?
    var status: String = "available"
    private var retrieve: RetrieveData?
    private let dataService = DataService()
    
    required init(view: ViewUpdate) {
        self.view = view
        self.retrieve = RetrieveData(view: view)
    }
    
    func viewDidLoad() {
        retrieve?.status = "https://petstore.swagger.io/v2/pet/findByStatus?status=" + status
        retrieve?.getData(callBack: view!.onRetrieveData(_:))
        
    }

    func onSave() {
        
        do {
            try dataService.saveData(view?.onSaveDate() as? [PetModel])
        } catch {
            view?.didFailWithError(error: error)
        }
        
    }
    
    func segmentIndex(_ segTitle: String?) -> Int? {
        switch segTitle {
        case "available":
            return 0
        case "sold":
            return 1
        case "pending":
            return 2
        default:
            return 0
        }
    }
    

}
