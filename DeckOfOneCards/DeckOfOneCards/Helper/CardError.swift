//
//  CardError.swift
//  DeckOfOneCards
//
//  Created by Garrett Lyons on 3/10/20.
//  Copyright © 2020 Turtle. All rights reserved.
//

import Foundation

enum CardError: LocalizedError {
    
    case invalidURL
    case thrown(Error)
    case noData
    case unableToDecode
    
    var errorDescroption: String? {
        switch self {
            
        case .invalidURL:
            return "You are too good looking that I got lost day dreaming on my way to the server"
        case .thrown(let error):
            return error.localizedDescription
        case .noData:
            return "Server has ADD and forgot to return data"
        case .unableToDecode:
            return "Server is in timeout for responding with bad data. Try again after it washes it's mouth out with soap."
       
        }
    }
    
}
