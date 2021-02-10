import Foundation

protocol NewsListRepositoryProtocol {
    func fetchArticles(_ request: EndPointType, completion: @escaping (Result<NewsList, NetworkError>)->())
}

class NewsListRepository: NewsListRepositoryProtocol {
    private let router: NetworkRouterProtocol
    init(_ router: NetworkRouterProtocol) {
        self.router = router
    }
    func fetchArticles(_ request: EndPointType, completion: @escaping (Result<NewsList, NetworkError>) -> ()) {
        NetworkOperation<NewsList>().execute(self.router, request) { (touple) in
            if let newsModel = touple.0 {
                completion(.success(newsModel))
                return
            }else{
                completion(.failure(touple.1 ?? NetworkError.noData))
                return
            }
        }
    }
}
