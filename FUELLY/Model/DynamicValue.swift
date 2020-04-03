//
//  DynamicValue.swift
//  FUELLY
//
//  Created by San Byn Nguyen on 01.04.2020.
//  Copyright © 2020 San Byn Nguyen. All rights reserved.
//

import Foundation

class DynamicValue<T>: NSObject {
    typealias CompletionHandler = ((T) -> Void)
    
    var value : T {
        didSet {
            self.notify()
        }
    }

    private var observers = [String: CompletionHandler]()

    init(_ value: T) {
        self.value = value
    }

    public func addObserver(_ observer: NSObject, completionHandler: @escaping CompletionHandler) {
        observers[observer.description] = completionHandler
    }

    public func addAndNotify(observer: NSObject, completionHandler: @escaping CompletionHandler) {
        self.addObserver(observer, completionHandler: completionHandler)
        self.notify()
    }

    private func notify() {
        observers.forEach({ $0.value(value) })
    }

    deinit {
        observers.removeAll()
    }
}


struct State<T> {
    var data: [T]
    
    enum StateChange {
        case insert(T, IndexPath)
        case delete(IndexPath)
        case reload([T])
    }
    
    var stateChange: StateChange {
        didSet {
            switch stateChange {
            case let .insert(new, indexPath):
                data.insert(new, at: indexPath.row)
            case let .delete(indexPath):
                data.remove(at: indexPath.row)
            case let .reload(new):
                data = new
            }
        }
    }
    
    init(data: [T]) {
        self.data = data
        self.stateChange = .reload(self.data)
    }
    
    init() {
        self.init(data: [])
    }
}
