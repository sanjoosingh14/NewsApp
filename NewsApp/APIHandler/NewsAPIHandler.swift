
import Foundation
import UIKit

class NewsAPI {
    static let shared = NewsAPI()
    private let cachedImages = NSCache<NSURL, UIImage>()

    func getNews(with url: URL, completion: @escaping ([News]?) -> ()) {
    
        URLSession.shared.dataTask(with: url) { data, response, error in
        
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            } else if let data = data {
            let newsList = try? JSONDecoder().decode(NewsList.self, from: data)
            completion(newsList?.articles)
        }
        
        }.resume()
    
    }
    func getData(from url: URL, completion: @escaping (Data?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
        if let error = error {
            print(error.localizedDescription)
            completion(nil)
        }
        else if let data = data {
           completion(data)
        }
        }.resume()
    }
    
    func getLikesCount(with url: URL, completion: @escaping (Int?) -> ()){
        URLSession.shared.dataTask(with: url) { data, response, error in
               
                   if let error = error {
                       print(error.localizedDescription)
                       completion(nil)
                   }
                   else if let data = data {
                    guard let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any] else {
                                   return
                    }
                    if let like =  json["likes"] as? Int{
                        completion(like)
                        return
                    }
                    completion(nil)
               }
               }.resume()
    }
    func getCommentsCount(with url: URL, completion: @escaping (Int?) -> ()){
           URLSession.shared.dataTask(with: url) { data, response, error in
                  
                      if let error = error {
                          print(error.localizedDescription)
                          completion(nil)
                      }
                      else if let data = data {
                       guard let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any] else {
                                      return
                       }
                       if let comment =  json["comments"] as? Int{
                           completion(comment)
                           return
                       }
                       completion(nil)
                  }
                  }.resume()
       }
}
