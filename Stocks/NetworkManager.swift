//
//  NetworkManager.swift
//  TopSeries
//
//  Created by oren shalev on 06/12/2019.
//  Copyright © 2019 oren shalev. All rights reserved.
//

import Foundation

enum HttpMethod : String{
    case GET,POST
}

class NetworkManager {
    
   static private func getRequest(url: URL,params: [String: String]? = [:] , completion: @escaping (Data) -> ())  {
          
        guard let params = params else { return }
        
        var components = URLComponents(string: "https://www.alphavantage.co/query")!
        var queryItems : [URLQueryItem] = []
        
        // loop trough the params and add it to the path component
        for (key,value) in params {
            queryItems.append(URLQueryItem(name: key, value: value))
        }
        
        components.queryItems = queryItems
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: " ", with: "%2B")
        
    
        
        let task = URLSession.shared.dataTask(with: components.url!) { (data, response, error) in
        if let error = error {
            print("netwirk request error: \(error)")
        } else {
            if let response = response as? HTTPURLResponse {
                print("statusCode: \(response.statusCode)")
            }
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                
                print("data: \(dataString)")
                
                completion(data)
            }
        }
    }
    task.resume()
    
    }

    
    static func getCandlesFor(stock: Stock, and timeInterval: String, completion: @escaping ([Candle],[ObservableCandle]) -> ()) {
        
        let url = URL(string: "https://www.alphavantage.co/query")!
        
        let params = ["function":"TIME_SERIES_INTRADAY",
                      "symbol":stock.symbol,
                      "interval":timeInterval,
                      "apikey":"Z8EW6CI3PHR9SUTK"]
        
        getRequest(url: url, params: params) { (data) in
            
            do {
                // make sure this JSON is in the format we expect
                if let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    
                    let key = "Time Series (\(timeInterval))"
                    var array : [Candle] = []
                    var array2 : [ObservableCandle] = []
                    
                    if let candles = dictionary[key] as? [String: Any] {

                        for (key,value) in candles {
                            
                            // Parse the "key" to a time string without the date
                            let result = key.split(separator: " ")
                            let time = result[1]
                            
                            // Grab the "value" and take its values
                            guard let value = value as? [String: String] else {
                                return
                            }
                            
                            let open = value["1. open"]
                            let high = value["2. high"]
                            let low = value["3. low"]
                            let close = value["4. close"]
                            let volume = value["5. volume"]

                            
                            // Create a "Candle" object and add it to the array
                            array.append(Candle(time: String(time),
                                                open: open!,
                                                high: high!,
                                                low: low!,
                                                close: close!,
                                                volume: volume!))
                            
                            array2.append(ObservableCandle(time: String(time), open: open!, high: high!, low: low!, close: close!, volume: volume!))
                        }
                        
                            completion(array,array2)
                        
                        
                    }
                    
                }
            } catch let error as NSError {
                print("Failed to load: \(error.localizedDescription)")
            }
            
        }
        
    }
    
}
