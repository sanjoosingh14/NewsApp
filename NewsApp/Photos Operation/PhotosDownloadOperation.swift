
import UIKit

final class PhotosDownloadOperation: Operation {
    
    private let photoRecord: PhotoRecord

    init(_ photoRecord: PhotoRecord) {
        self.photoRecord = photoRecord
    }
    
    override func main() {
        guard isCancelled == false else { return }
        
        self.photoRecord.state = .downloading
        if let url = URL(string: photoRecord.urlStr){
            guard let imageData = try? Data(contentsOf: url) else {
                photoRecord.state = .failed
                return
            }
            if !imageData.isEmpty {
              photoRecord.image = UIImage(data:imageData)
              photoRecord.state = .downloaded
            } else {
              photoRecord.state = .failed
            }
        }
        
    }
    
}
