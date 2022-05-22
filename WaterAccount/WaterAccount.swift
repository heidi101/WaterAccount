//
//  WaterAccount.swift
//  WaterAccount
//
//  Created by HL on 5/21/22.
//

import Foundation

struct WaterAcc {
    var username : String
    var pin : Int
    var gallonsUsed : Int
    var gallonsLeft : Int
    init(username : String, pin : Int, gallonsUsed : Int, gallonsLeft : Int){
        self.username = username
        self.pin = pin
        self.gallonsUsed = gallonsUsed
        self.gallonsLeft = gallonsLeft
    }
}
