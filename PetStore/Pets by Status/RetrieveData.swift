//
//  RetrieveData.swift
//  PetStore
//
//  Created by Nodir on 11/08/22.
//

import Foundation

protocol RetrieveDataProtocol {
    init(view: ViewUpdate)
    func getData(callBack: (AnyObject)->())
}

struct RetrieveData: RetrieveDataProtocol {
    
    var view: ViewUpdate?
    var ntw: Networking
    var status: String = ""
    private let dataService = DataService()
    
    init(view: ViewUpdate) {
        self.view = view
        self.ntw = Networking()
    }
    
    func getData(callBack: (AnyObject)->()) {
        if Connectivity.isConnectedToInternet {
            print("Connected")
            getDataFromNetwork()
        } else {
            getLocalData(callBack)
        }
    }
    
    private func getLocalData(_ callback: (AnyObject)->()) {
        
        do {
            
            if let data = try dataService.retrieveData() {
                callback(data)
            }
            
        } catch let error {
            view?.didFailWithError(error: error)
        }
    }
    
    private func getDataFromNetwork() {
        
        ntw.req(status, view: view!) { data in
            let decoder = JSONDecoder()

            do {
                let jsonDecoded = try decoder.decode([PetModel].self, from: data)
                return jsonDecoded as [PetModel]
            } catch {
                self.view?.didFailWithError(error: error)
            }
            print("Error")
            return PetModel.self as! Codable
        }
    }
    
    
}
