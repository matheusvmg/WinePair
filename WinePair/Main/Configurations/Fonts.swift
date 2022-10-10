//
//  Fonts.swift
//  WinePair
//
//  Created by Matheus Góes on 28/09/22.
//

import UIKit

struct Fonts {
    struct Family {
        static let bold = "Montserrat-Bold"
        static let medium = "Montserrat-Medium"
        static let regular = "Montserrat-Regular"
    }
    
    struct Bold {
        static let xl = UIFont(name: Family.bold, size: 36)!
        static let lg = UIFont(name: Family.bold, size: 24)!
        static let sm = UIFont(name: Family.bold, size: 16)!
    }
    
    struct Medium {
        static let sm = UIFont(name: Family.medium, size: 16)!
    }
    
    struct Regular {
        static let sm = UIFont(name: Family.regular, size: 16)!
        static let xs = UIFont(name: Family.regular, size: 14)!
    }
}
