//
//  ArrayExtension.swift
//  VKBetta
//
//  Created by Сергей Зайцев on 17.06.2021.
//

import Foundation

extension Array where Element == Int {
    
    func mapToIndexPaths() -> [IndexPath] {
        return map({ IndexPath(row: $0, section: 0) })
    }
}
