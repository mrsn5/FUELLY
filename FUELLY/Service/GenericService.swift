//
//  GenericService.swift
//  FUELLY
//
//  Created by San Byn Nguyen on 04.04.2020.
//  Copyright © 2020 San Byn Nguyen. All rights reserved.
//

import Foundation
import RealmSwift

class GenericService<T: SyncObject> {
    
    let realm = try! Realm()
    var syncService: FirestoreSyncService<T>?
    
    init() {
        sync()
    }
    
    func sync() {
        if syncService == nil {
            syncService = FirestoreSyncService<T>() { resync in
                self.syncService = resync ?  FirestoreSyncService<T>() : nil
            }
        } else {
            syncService?.resync = true
        }
    }
    
    func fetch(sortedBy: String, ascending: Bool, _ completion: @escaping ((Result<[T], Error>) -> Void) = { _ in return }) {
        completion((.success(Array(realm.objects(T.self).sorted(byKeyPath: sortedBy, ascending: ascending)))))
        sync()
    }
    
    func save(_ object: T, _ completion: @escaping ((Result<T, Error>) -> Void) = { _ in return }) {
        try! realm.write {
            realm.add(object)
            completion(.success(object))
            sync()
        }
    }
    
    func delete(_ object: T, _ completion: @escaping ((Result<T, Error>) -> Void) = { _ in return }) {
        try! realm.write {
            realm.delete(object)
            completion(.success(object))
            sync()
        }
    }
}





