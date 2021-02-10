
import Foundation

protocol NewsListUseCase {
    func execute(_ request: EndPointType, completion: @escaping (Result<NewsList, NetworkError>)->())
}

class DefaultNewsListUseCase: NewsListUseCase {
    private let newsRepository: NewsListRepositoryProtocol
    init(_ repo: NewsListRepositoryProtocol) {
        self.newsRepository = repo
    }
    
    func execute(_ request: EndPointType, completion: @escaping (Result<NewsList, NetworkError>) -> ()) {
        self.newsRepository.fetchArticles(request) { result in
            completion(result)
            return
        }
    }
}


