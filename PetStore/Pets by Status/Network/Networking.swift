//
//  Networking.swift
//  PetStore
//
//  Created by Nodir on 09/08/22.
//

import Foundation
import Alamofire

struct Networking {
    
    func req(_ urlStr: String, view: ViewUpdate, completion: @escaping (_ callBack: Data) -> Codable) {
        AF.request(urlStr, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil)
            .validate()
            .responseJSON(completionHandler: { response in
                switch response.result {
                case .success:
//                    print(response.value)
                    let json = completion(response.data!)
                    view.didUpdateData(json)
                    
                case .failure(let error):
                    print(error)
                    
                }
                
            })
        
    }
    
}
