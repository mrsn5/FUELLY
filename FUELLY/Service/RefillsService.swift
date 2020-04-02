//
//  RefillsUseCaseType.swift
//  FUELLY
//
//  Created by San Byn Nguyen on 01.04.2020.
//  Copyright © 2020 San Byn Nguyen. All rights reserved.
//

import Foundation
import RealmSwift

final class RefillsService {
    
    static let shared = RefillsService()
   
    func fetchRefills(_ completion: @escaping ((Result<[Refill], Error>) -> Void)) {
        
        let realm = try! Realm()
        completion((.success(Array(realm.objects(Refill.self)))))
            
    }
}




