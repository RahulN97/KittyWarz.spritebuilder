//
//  NinjaNap.swift
//  KittyWars
//
//  Created by Rahul Nambiar on 2/20/16.
//  Copyright © 2016 Sahaj Bhatt. All rights reserved.
//

import Foundation

class NinjaNap: Ability {
    
    override init() {
        super.init()
        amt = 85.0
        unlockLevel = 10
        abilityType = "Defense"
        typeOfKitty = "NinjaKitty"
        name = "Ninja Nap"
    }
}