//
//  Card.swift
//  DeckOfOneCards
//
//  Created by Garrett Lyons on 3/10/20.
//  Copyright © 2020 Turtle. All rights reserved.
//

import Foundation

struct Card: Codable {
    let image: URL
    let value: String
    let suit: String
}

struct TopLevelObject: Codable {
    let cards: [Card]
}
