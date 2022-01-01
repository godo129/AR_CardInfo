//
//  CardData.swift
//  AR_Card
//
//  Created by hong on 2022/01/01.
//

import Foundation

struct cardManager {
    var cardNumber: Int
    var cardName : String
    var CVCNumber : Int
    var bankName : String
}

var myCard = cardManager(cardNumber: 0, cardName: "", CVCNumber: 0, bankName: "")
