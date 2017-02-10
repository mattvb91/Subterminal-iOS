//
//  Model.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 10/02/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import Foundation
import SharkORM

class Model: SRKObject {
    
    //Wrapper for commit
    open func save() -> Bool {
        return super.commit()
    }
    
}
