//
//  Array.swift
//  PlayOjo
//
//  Created by Tanya Koldunova on 05.10.2022.
//

import Foundation
import SpriteKit

extension Array where Element:SKTexture
  {
     func uniqueValues() -> [Element]
     {
        var result:[Element] = []
         self.forEach({ element in
             if !result.contains(where: {$0.description == element.description})
            { result.append(element) }
         })
        return result
     }
    
//    func unique() -> Bool {
//        var array:[Element] = []
//        self.forEach { el in
//            if array.contains(where: {})
//        }
//    }
  }
