import XCTest
@testable import NewsApp

class NewsListUseCasesTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_fetchNewsWithWrongUrl_fail(){
        let newUrlStr = "https://newsapi.org//v2/top-headlines??country=us&apiKey=2ed7996e7c844109abdca49cd1623719"
        let sut = DefaultNewsListUseCase(NewsListRepository(NetworkRouter()))
        let request = NewsEndPoint(newUrlStr)!
        XCTAssertNotNil(request)
        let newsExpectation = expectation(description: "Fetching news")
        sut.execute(request) { (result) in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, NetworkError.apiError.localizedDescription , "Api issue")
            case .success(let newsModel):
                XCTAssertNil(newsModel)
            }
            newsExpectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func test_fetchPhotosWithBlankUrl_fail(){
        let newUrlStr = ""
        let request = NewsEndPoint(newUrlStr)
        XCTAssertNil(request)
    }
    
    func test_fetchPhotosWithValidUrl_success(){
        let newUrlStr = "https://newsapi.org/v2/top-headlines?country=us&apiKey=2ed7996e7c844109abdca49cd1623719"
        let sut = DefaultNewsListUseCase(NewsListRepository(NetworkRouter()))
        let request = NewsEndPoint(newUrlStr)!
        XCTAssertNotNil(request)
        let photoExpectation = expectation(description: "Fetching Photo")
        sut.execute(request) { (result) in
            switch result {
            case .failure(let error):
                XCTAssertNil(error)
            case .success(let newlist):
                XCTAssertNotNil(newlist)
                XCTAssertTrue(newlist.articles?.count ?? 0 > 0)
            }
            photoExpectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }

}
