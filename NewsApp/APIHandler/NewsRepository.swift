import Foundation

enum FetchArticlesError: Error {
    case loading
    case parsing
}

typealias FetchArticlesResult = (_ result: Result<[News], FetchArticlesError>) -> Void

protocol NewsRepository {
    func fetchNews(completion: @escaping ([News]?) -> ())
    func getLikesCount(completion: @escaping (Int?) -> ())
    func getCommentsCount(completion: @escaping (Int?) -> ())
}
class NewsRepositoryImp: NewsRepository {
    static let shared = NewsRepositoryImp()

    func getLikesCount(completion: @escaping (Int?) -> ()) {
         guard let url = NewsApiFactoryImpl().createLikeUrl().url else {
             completion(nil)
             return
         }
         NetworkRepositoryImpl().fetchRequest(url) { networkResult in
         switch networkResult {
            case .success(let response):
                let (urlResponse, data) = response
                 guard let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]
                    else {
                      completion(nil)
                      return
                  }
                  if let comment =  json["comments"] as? Int{
                      completion(comment)
                      return
                  }
                else{
                    completion(nil)
                    return
                }
            case .failure:
                completion(nil)
                return
            }
        }
    }
    
    func getCommentsCount(completion: @escaping (Int?) -> ()) {
         guard let url = NewsApiFactoryImpl().createCommentUrl().url else {
             completion(nil)
             return
         }
         NetworkRepositoryImpl().fetchRequest(url) { networkResult in
         switch networkResult {
            case .success(let response):
                let (urlResponse, data) = response
                 guard let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]
                    else {
                      completion(nil)
                      return
                  }
                  if let comment =  json["comments"] as? Int{
                      completion(comment)
                      return
                  }
                else{
                    completion(nil)
                    return
                }
            case .failure:
                completion(nil)
                return
            }
        }
    }
    

    func fetchNews(completion: @escaping ([News]?) -> ()) {
         guard let url = NewsApiFactoryImpl().createTopHeadlinesUrl().url else {
             completion(nil)
             return
         }
         NetworkRepositoryImpl().fetchRequest(url) { networkResult in
         switch networkResult {
            case .success(let response):
                let (urlResponse, data) = response
                let newsList = try? JSONDecoder().decode(NewsList.self, from: data)
                if let news = newsList?.articles{
                    completion(news)
                    return
                }
                else{
                    completion(nil)
                    return
                }
            case .failure:
                completion(nil)
                return
            }
        }
    }
}
