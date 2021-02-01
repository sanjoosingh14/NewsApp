import Foundation
@testable import NewsApp

class MockNewsRepositroy: NewsRepository {
    var isFetchNewsCalled = false
    var isFetchCommentCalled = false
    var isFetchLikeCalled = false
    
    var fetchNesCompleteClosure: (([News]?) -> ())!
    var fetchCommentCompleteClosure: ((Int?) -> ())!
    var fetchLikeCompleteClosure: ((Int?) -> ())!


    func fetchNews(completion: @escaping ([News]?) -> ()){
        isFetchNewsCalled = true
        fetchNesCompleteClosure = completion

    }
    func getLikesCount(completion: @escaping (Int?) -> ()){
        isFetchLikeCalled = true
        fetchCommentCompleteClosure = completion
    }
    func getCommentsCount(completion: @escaping (Int?) -> ()){
        isFetchCommentCalled = true
        fetchCommentCompleteClosure = completion

    }
}
