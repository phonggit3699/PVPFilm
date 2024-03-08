//
//  PVPFilmObservable.swift
//  PhongPVFilm
//
//  Created by Pham Phong on 06/03/2024.
//

import Foundation

struct Observable<T> {
    typealias Observer = String

    private var handlers: [Observer: (T) -> Void] = [:]

    var value: T {
        didSet {
            handlers.forEach { $0.value(value) }
        }
    }

    init(_ value: T) {
        self.value = value
    }

    @discardableResult
    mutating func observeNext(_ handler: @escaping (T) -> Void) -> Observer {
        let key = UUID().uuidString as Observer
        handlers[key] = handler
        return key
    }

    mutating func remove(_ key: Observer) {
        handlers.removeValue(forKey: key)
    }
}
