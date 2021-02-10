import Foundation

protocol NewsDetailRepositoryProtocol {
    func fetchLikes(_ request: EndPointType, completion: @escaping (Result<Like, NetworkError>)->())
    func fetchComment(_ request: EndPointType, completion: @escaping (Result<Comment, NetworkError>)->())

}

class NewsDetailRepository: NewsDetailRepositoryProtocol {
    private let router: NetworkRouterProtocol
    init(_ router: NetworkRouterProtocol) {
        self.router = router
    }
    func fetchLikes(_ request: EndPointType, completion: @escaping (Result<Like, NetworkError>) -> ()) {
        NetworkOperation<Like>().execute(self.router, request) { (touple) in
            if let like = touple.0 {
                completion(.success(like))
                return
            }else{
                completion(.failure(touple.1 ?? NetworkError.noData))
                return
            }
        }
    }
    
    func fetchComment(_ request: EndPointType, completion: @escaping (Result<Comment, NetworkError>) -> ()) {
          NetworkOperation<Comment>().execute(self.router, request) { (touple) in
              if let comment = touple.0 {
                  completion(.success(comment))
                  return
              }else{
                  completion(.failure(touple.1 ?? NetworkError.noData))
                  return
              }
          }
      }
}
