//
//  StationService.swift
//  FUELLY
//
//  Created by San Byn Nguyen on 03.04.2020.
//  Copyright © 2020 San Byn Nguyen. All rights reserved.
//


import Foundation
import RealmSwift

final class StationsService {
    
    static let shared = StationsService()
    
    
    
    let realm = try! Realm()
    
    func fetch(_ completion: @escaping ((Result<[Station], Error>) -> Void)) {
        completion((.success(Array(realm.objects(Station.self)))))
    }
    
    func save(_ station: Station, _ completion: @escaping ((Result<Station, Error>) -> Void)) {
        try! realm.write {
            realm.add(station)
            completion(.success(station))
        }
    }
    
    func delete(_ station: Station, _ completion: @escaping ((Result<Station, Error>) -> Void)) {
        try! realm.write {
            realm.delete(station)
            completion(.success(station))
        } 
    }
}
