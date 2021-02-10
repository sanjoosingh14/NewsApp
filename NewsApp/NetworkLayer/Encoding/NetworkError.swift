import Foundation

public enum NetworkError: Error {
    case parametersNil
    case encodingFailed
    case missingURL
    case noData
    case parsingError
    case apiError
}

extension NetworkError: LocalizedError {
    public var errorDescription: String?{
        switch self {
        case .parametersNil:
            return NSLocalizedString("Input is not correct", comment: "")
        case .encodingFailed:
            return NSLocalizedString("Parameter encoding failed", comment: "")
        case .missingURL:
            return NSLocalizedString("URL is nil", comment: "")
        case .noData:
            return NSLocalizedString("Json data is not correct", comment: "")
        case .parsingError:
            return NSLocalizedString("Unable to parsing data", comment: "")
        case .apiError:
            return NSLocalizedString("Api call failed", comment: "")
        }
    }
}
