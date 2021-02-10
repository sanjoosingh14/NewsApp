//
//  PhotoDownloadEndPoint.swift
//  AssignmentForTimesInternet
//
//  Created by IndianRenters on 08/02/21.
//  Copyright © 2021 Alok. All rights reserved.
//

import Foundation

struct PhotoDownloadEndPoint: EndPointType {
    private let photoUrlStr: String
    
    init(_ photoUrlStr: String) {
        self.photoUrlStr = photoUrlStr
    }
    
    var baseURL: URL {
        guard let url = URL(string: photoUrlStr) else { fatalError("baseURL could not be configured.")}
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
