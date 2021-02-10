import XCTest
@testable import NewsApp

class NewsListViewModelTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_fetchNews_succes() {
        let newsUseCase = DefaultNewsListUseCase(NewsListRepository(NetworkRouter()))
        let sut = NewsListViewModel(newsUseCase, downloader: PhotoDownloader())
        let photoExpectation = expectation(description: "Fetching news")
        sut.fetchArticles()
        DispatchQueue.main.asyncAfter(deadline: .now() + 8) {
            XCTAssertTrue(sut.news.value.count > 0)
            photoExpectation.fulfill()
        }
        waitForExpectations(timeout: 8, handler: nil)
    }

}
