
import Foundation
@testable import NewsApp

class MockURLSessionDataTask: URLSessionDataTask {
    override func resume() {}
}

class MockURLSession: URLSessionProtocol {
    var capturedCompletion: ((Data?, URLResponse?, Error?) -> Void)?
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        capturedCompletion = completionHandler
        return MockURLSessionDataTask()
    }
}
