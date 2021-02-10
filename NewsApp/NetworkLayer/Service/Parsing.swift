import Foundation

struct Parser {
    fileprivate var data: Data
    init(data: Data) {
        self.data = data
    }
}

extension Parser {
    //MARK:- Parsing data to create model
    public func decode<T: Codable>(_ type: T.Type) -> T? {
        let jsonDecoder = JSONDecoder()
        do {
            let response = try jsonDecoder.decode(T.self, from: data)
            return response
        } catch {
            return nil
        }
    }
}
