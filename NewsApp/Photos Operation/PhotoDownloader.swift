
import UIKit

enum OperationState {
    case new
    case downloading
    case downloaded
    case failed
}

class PhotoRecord {
    let urlStr: String
    var image: UIImage? = nil
    var state = OperationState.new
    
    init(urlStr: String){
        self.urlStr = urlStr
    }
}

final class PendingOperations {
    lazy var downloadInProgress: [Int: Operation] = [:]
    lazy var downloadQueue: OperationQueue = {
        var queue = OperationQueue()
        queue.name = "Download Queue"
        return queue
    }()
    
}
typealias PhotoDownloadHandler = (_ image: UIImage?, _ index: Int) -> Void

final class PhotoDownloader {
    private let downloadOpertaionQueue = PendingOperations()
    
    func loadPhoto(photoRecord: PhotoRecord, index: Int, completion: @escaping PhotoDownloadHandler) {
        guard downloadOpertaionQueue.downloadInProgress[index] == nil else {
            completion(photoRecord.image, index)
            return
        }
        let downloadOperation = PhotosDownloadOperation(photoRecord)
        downloadOperation.completionBlock = { [weak self] in
            guard let self = self else { return }
            if downloadOperation.isCancelled {
                completion(photoRecord.image, index)
                return
            }
            self.downloadOpertaionQueue.downloadInProgress.removeValue(forKey: index)
            completion(photoRecord.image, index)
        }
        downloadOpertaionQueue.downloadInProgress[index] = downloadOperation
        downloadOpertaionQueue.downloadQueue.addOperation(downloadOperation)
    }
}
