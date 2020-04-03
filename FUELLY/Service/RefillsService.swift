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
    
    
    
    let realm = try! Realm()
    
    func fetch(_ completion: @escaping ((Result<[Refill], Error>) -> Void)) {
        completion((.success(Array(realm.objects(Refill.self)))))
    }
    
    func save(_ refill: Refill, _ completion: @escaping ((Result<Refill, Error>) -> Void)) {
        try! realm.write {
            realm.add(refill)
            completion(.success(refill))
        }
    }
    
    func delete(_ refill: Refill) {
        
    }
}




