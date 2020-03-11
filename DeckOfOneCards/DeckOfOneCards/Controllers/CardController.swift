//
//  CardController.swift
//  DeckOfOneCards
//
//  Created by Garrett Lyons on 3/10/20.
//  Copyright © 2020 Turtle. All rights reserved.
//

import UIKit

class CardController {
    
    static func fetchCard(completion: @escaping (Result <Card, CardError>) -> Void) {
        //1) Prepare URL
        guard let baseURL = URL(string: "https://deckofcardsapi.com/api/deck/new/draw/") else { return completion(.failure(.invalidURL)) }
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let queryItem = URLQueryItem(name: "count", value: "1")
        components?.queryItems = [queryItem]
        guard let finalURL = components?.url else { return (completion(.failure(.invalidURL))) }
        
        //2) Contact server
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            //3) Handle errors from the server
            if let error = error {
                return completion(.failure(.thrown(error)))
            }
            //4) Check for json data
            guard let data = data else { return completion(.failure(.noData)) }
            
            //5) Decode json into a Card
            do {
                let topLevelObject = try JSONDecoder().decode(TopLevelObject.self, from: data)
                guard let card = topLevelObject.cards.first else { return completion(.failure(.noData)) }
                return completion(.success(card))
            } catch {
                return completion(.failure(.thrown(error)))
            }
        }.resume()
    }
    
    static func fetchImage(for card: Card, completion: @escaping (Result<UIImage, CardError>) -> Void) {
        //1)
        let url = card.image
        //2)
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            //3)
            if let error = error {
                return completion(.failure(.thrown(error)))
            }
            //4)
            guard let data = data else { return completion(.failure(.noData)) }
            //5)
            guard let image = UIImage(data: data) else { return completion(.failure(.unableToDecode)) }
            return completion(.success(image))
        }.resume()
    }
}//End of Class
