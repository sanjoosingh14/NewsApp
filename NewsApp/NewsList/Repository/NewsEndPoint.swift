import Foundation

struct NewsEndPoint: EndPointType {
    private let newAPIUrlStr: String
    init?(_ newAPIUrlStr: String) {
        guard newAPIUrlStr.count > 0 else { return nil}
        self.newAPIUrlStr = newAPIUrlStr
    }
    
    var baseURL: URL {
        guard let url = URL(string: newAPIUrlStr) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        return ""
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        return .request
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
    
}
