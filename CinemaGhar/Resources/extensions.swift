//
//  extensions.swift
//  CinemaGhar
//
//  Created by pooja kamble on 24/12/25.
//

import Foundation
 
extension String {
    func capitalaizedFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
