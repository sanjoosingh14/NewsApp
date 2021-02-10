import Foundation

protocol NetworkOperationProtocol {
    associatedtype output: Codable
    func execute(_ router: NetworkRouterProtocol, _ request: EndPointType, _ completion: @escaping ((output?, NetworkError?)) -> Void)
}

class NetworkOperation<T: Codable>: NetworkOperationProtocol {
    typealias output = T
    
    func execute(_ router: NetworkRouterProtocol, _ request: EndPointType, _ completion: @escaping ((T?, NetworkError?)) -> Void) {
        router.request(request) { (data, response, error) in
            if let _ = error {
                completion((nil, NetworkError.apiError))
                return
            }
            let urlResponse = response as? HTTPURLResponse
            guard urlResponse?.statusCode == 200 else {
                completion((nil, NetworkError.apiError))
                return
            }
            if let data = data {
                // Parsing
                let parser = Parser(data: data)
                if let photoModel = parser.decode(output.self){
                    completion((photoModel, nil))
                }else{
                    completion((nil, NetworkError.parsingError))
                }
                return
            }else{
                completion((nil, NetworkError.noData))
                return
            }
        }
    }
     
}
