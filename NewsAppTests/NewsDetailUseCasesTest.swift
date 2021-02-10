import XCTest
@testable import NewsApp

class NewsDetailUseCasesTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_fetchLikeWithWrongUrl_fail(){
        let newUrlStr = "https://cn-news-info-api.herokuapp.com///likes/_"
        let sut = DefaultNewsDetailUseCase(NewsDetailRepository(NetworkRouter()))
        let request = NewsEndPoint(newUrlStr)!
        XCTAssertNotNil(request)
        let newsExpectation = expectation(description: "Fetching like count")
        sut.executeLikes(request) { (result) in
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

    func test_fetchLikeWithValidUrl_success(){
        let newUrlStr = "https://cn-news-info-api.herokuapp.com/likes/_"
        let sut = DefaultNewsDetailUseCase(NewsDetailRepository(NetworkRouter()))
        let request = NewsEndPoint(newUrlStr)!
        XCTAssertNotNil(request)
        let photoExpectation = expectation(description: "Fetching like count")
        sut.executeLikes(request) { (result) in
            switch result {
            case .failure(let error):
                XCTAssertNil(error)
            case .success(let like):
                XCTAssertNotNil(like)
                XCTAssertTrue(like.likes ?? 0 > 0)
            }
            photoExpectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }

}
