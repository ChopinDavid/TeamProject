//
//  Idea.swift
//  TeamProject
//
//  Created by David G Chopin on 12/10/18.
//  Copyright © 2018 David G Chopin. All rights reserved.
//

import UIKit

class Idea {
    var name: String!
    var description: String!
    var id: String!
    var claimed: Bool!
    
    init(name: String, description: String, id: String, claimed: Int) {
        self.name = name
        self.description = description
        self.id = id
        switch claimed {
        case 0:
            self.claimed = false
        case 1:
            self.claimed = true
        default:
            self.claimed = true
        }
    }
}
