//
//  Connectivity.swift
//  PetStore
//
//  Created by Nodir on 09/08/22.
//

import Foundation
import Alamofire

struct Connectivity {
  static let sharedInstance = NetworkReachabilityManager()!
  static var isConnectedToInternet: Bool {
      return self.sharedInstance.isReachable
    }
}
