
import Foundation
protocol NewsApiFactory {
    func createTopHeadlinesUrl() -> URLComponents
    func createCommentUrl() -> URLComponents
    func createLikeUrl() -> URLComponents
}

struct NewsApiFactoryImpl: NewsApiFactory {
    
    let apiKey = "2ed7996e7c844109abdca49cd1623719"
    func createTopHeadlinesUrl() -> URLComponents {
        let countryCode = "us"
        var components = URLComponents()
        components.scheme = "https"
        components.host = "newsapi.org"
        components.path = "/v2/top-headlines"
        components.queryItems = [
          URLQueryItem(name: "country", value: countryCode),
          URLQueryItem(name: "apiKey", value: apiKey)
        ]
        return components
    }
    func createCommentUrl() -> URLComponents {
           var components = URLComponents()
           components.scheme = "https"
           components.host = "cn-news-info-api.herokuapp.com"
           components.path = "/comments/_"
           return components
    }
    func createLikeUrl() -> URLComponents {
              var components = URLComponents()
              components.scheme = "https"
              components.host = "cn-news-info-api.herokuapp.com"
              components.path = "/likes/_"
              return components
    }
}
