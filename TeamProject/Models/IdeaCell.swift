//
//  IdeaCell.swift
//  TeamProject
//
//  Created by David G Chopin on 12/10/18.
//  Copyright © 2018 David G Chopin. All rights reserved.
//

import UIKit

class IdeaCell: UITableViewCell {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = UIColor.clear
        self.textLabel?.textColor = UIColor.white
    }
}
