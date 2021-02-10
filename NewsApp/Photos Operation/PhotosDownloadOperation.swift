//
//  PhotosDownloadOperation.swift
//  AssignmentForTimesInternet
//
//  Created by IndianRenters on 08/02/21.
//  Copyright © 2021 Alok. All rights reserved.
//

import UIKit

final class PhotosDownloadOperation: Operation {
    
    //private let endPoint: EndPointType
    //private let router: NetworkRouterProtocol
    private let photoRecord: PhotoRecord
    
    init(_ photoRecord: PhotoRecord) {
        self.photoRecord = photoRecord
//        self.endPoint = PhotoDownloadEndPoint(photoRecord.urlStr)
//        self.router = NetworkRouter()
    }
    
    override func main() {
        guard isCancelled == false else { return }
        
        //isExecuting = true
        //isFinished = false
        self.photoRecord.state = .downloading
        
        /*self.router.request(endPoint) {[weak self] (data, _, error) in
            if let _ = error {
                print("failed..\(self?.photoRecord.urlStr)")
                self?.photoRecord.state = .failed
            }else {
                if let data = data {
                    let image = UIImage(data: data)
                    self?.photoRecord.state = .downloaded
                    self?.photoRecord.image = image
                }else{
                    print("failed..\(self?.photoRecord.urlStr)")
                    self?.photoRecord.state = .failed
                }
            }
            //self?.isExecuting = false
            //self?.isFinished = true
        }*/
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
