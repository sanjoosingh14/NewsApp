
import XCTest
@testable import NewsApp

class NewsDetailViewModelTest: XCTestCase {
    var mockNewsRepositroy: MockNewsRepositroy!
    var sut: NewsDetailViewModel!
    
    override func setUp() {
        super.setUp()
        mockNewsRepositroy = MockNewsRepositroy()
        sut = NewsDetailViewModel()
    }

    override func tearDown() {
        sut = nil
        mockNewsRepositroy = nil
        super.tearDown()
    }
    
    func test_fetch_comment_fail() {
        // When start fetch
        sut.fetchcomments()

        // Assert
        XCTAssertFalse(mockNewsRepositroy.isFetchCommentCalled)
    }
    func test_fetch_like_fail() {
        // When start fetch
        sut.fetchlikes()

        // Assert
        XCTAssertFalse(mockNewsRepositroy.isFetchLikeCalled)
    }
  
}
