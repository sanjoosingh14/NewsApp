import Foundation

protocol NewsDetailUseCase {
    func executeLikes(_ request: EndPointType, completion: @escaping (Result<Like, NetworkError>)->())
    func executeComment(_ request: EndPointType, completion: @escaping (Result<Comment, NetworkError>)->())
}

class DefaultNewsDetailUseCase: NewsDetailUseCase {
    private let newsDetailRepository: NewsDetailRepositoryProtocol
    init(_ repo: NewsDetailRepositoryProtocol) {
        self.newsDetailRepository = repo
    }
    
    func executeLikes(_ request: EndPointType, completion: @escaping (Result<Like, NetworkError>) -> ()) {
        self.newsDetailRepository.fetchLikes(request) { result in
            completion(result)
            return
        }
    }
    func executeComment(_ request: EndPointType, completion: @escaping (Result<Comment, NetworkError>) -> ()) {
          self.newsDetailRepository.fetchComment(request) { result in
              completion(result)
              return
          }
      }
}


