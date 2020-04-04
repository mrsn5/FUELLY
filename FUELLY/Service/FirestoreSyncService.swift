//
//  FirebaseSyncService.swift
//  FUELLY
//
//  Created by San Byn Nguyen on 04.04.2020.
//  Copyright © 2020 San Byn Nguyen. All rights reserved.
//

import Foundation
import Firebase
import RealmSwift

class FirestoreSyncService<T: SyncObject> {
    
    let realm = try! Realm()
    
    init() {
        print("INIT \(T.self)")
        let results = Array(self.realm.objects(T.self).filter("isSync == false"))
        for r in results {
            add(data: r)
        }
    }
    
    deinit {
        print("DEINIT \(T.self)")
    }
    
    func add(data: T) {
        DB_USER.document(DEVICE_ID).collection(data.path).document(data.uid).setData(data.dictionary()) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
    }
    
    
}
