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
import Network

class FirestoreSyncService<T: SyncObject> {
    
    var resync = false
    let monitor = NWPathMonitor()
    
    init(comletion: @escaping (Bool) -> Void = { _ in }) {
        monitor.pathUpdateHandler = { [weak self] path in
            if path.status == .satisfied {
                self?.sync()
                self?.monitor.cancel()
                comletion(self?.resync ?? false)
            } 
        }
        let queue = DispatchQueue(label: "monitor")
        monitor.start(queue: queue)
    }
    
    func sync() {
        DispatchQueue.global(qos: .background).async {
            let realm = try! Realm()
            self.resync = false
            let results = Array(realm.objects(T.self).filter("isSync == false"))
            for r in results {
                let ref = ThreadSafeReference(to: r)
                self.add(ref)
            }
        }
    }
    
    private func add(_ ref: ThreadSafeReference<T>) {
        let realm = try! Realm()
        guard let data = realm.resolve(ref) else { return }
        let ref = ThreadSafeReference(to: data)
        
        DB_USER.document(DEVICE_ID).collection(data.path).document(data.uid).setData(data.dictionary()) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                let realm = try! Realm()
                guard let data = realm.resolve(ref) else { return }
                
                try! realm.write {
                    data.isSync = true
                    realm.add(data)
                }
                print("Document sync successfully")
            }
        }
    }
    
    
}
