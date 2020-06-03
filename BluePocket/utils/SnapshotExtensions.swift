//
//  SnapshotExtensions.swift
//  BluePocket
//
//  Created by Mateus Lopes on 23/05/20.
//  Copyright © 2020 Mateus Lopes. All rights reserved.
//

import Foundation
import FirebaseFirestore

extension QueryDocumentSnapshot {
    
    func decoded<T: Decodable>() throws -> T {
        print(data())
        
        let jsonData = try JSONSerialization.data(withJSONObject: data(), options: [])
        let object = try JSONDecoder().decode(T.self, from: jsonData)
        return object
    }
    
}

extension QuerySnapshot {
    func decoded<T: Decodable>() throws -> [T] {
        
        let objects: [T] = try documents.map({ try $0.decoded()})
        return objects
    }
}
