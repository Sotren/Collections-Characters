//
//  Observable.swift
//  TestGit
//
//  Created by Станислав Москальцов  on 18.08.2022.
//

import Foundation

class Observable<T> {
    
    private var listener :( (T) -> Void)?
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(listener: @escaping (T) -> Void ) {
        listener(value)
        self.listener = listener
    }
}
