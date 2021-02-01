

import XCTest
@testable import NewsApp

class NewsListViewModelTest: XCTestCase {
    var mockNewsRepositroy: MockNewsRepositroy!
    var sut: NewsListViewModel!
    
    override func setUp() {
        super.setUp()
        mockNewsRepositroy = MockNewsRepositroy()
        sut = NewsListViewModel()
    }

    override func tearDown() {
        sut = nil
        mockNewsRepositroy = nil
        super.tearDown()
    }
    
    func test_fetch_news_fail() {
        // When start fetch
        sut.fetchNewsFromApi()

        // Assert
        XCTAssertFalse(mockNewsRepositroy.isFetchNewsCalled)
    }
}
