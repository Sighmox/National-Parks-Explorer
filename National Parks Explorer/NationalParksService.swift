//
//  NationalParksService.swift
//  National Parks Explorer
//
//  Created by Paul Baker on 4/9/19.
//  Copyright © 2019 Paul Baker. All rights reserved.
//

import Foundation

class NationalParksService {
    
    func fetchParks(for state: String, completion: @escaping ([NationalPark]?, Error?) -> Void) {
        
        // example - all parks in Arizona https//api.nps.gov/api/v1/parks?stateCode=az
        
        let components: URLComponents = {
            var components = URLComponents()
            components.scheme = "https"
            components.host = "api.nps.gov"
            components.path = "/api/v1/parks"
            components.queryItems = [
                URLQueryItem(name: "stateCode", value: state),
            ]
            return components
        }()
        
        let url = components.url
        let session = URLSession.shared
        let task = session.dataTask(with: url!) { data, response, error in
            if let results = data {
                let decoder = JSONDecoder()
                let results = try! decoder.decode(NationalParkResult.self, from: results)
                completion(results.data, nil)
            }
            // TODO Error handling
        }
        
        task.resume()
    }
}
