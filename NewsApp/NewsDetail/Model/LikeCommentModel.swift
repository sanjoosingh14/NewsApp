import Foundation

struct Like: Codable {
    let likes: Int?
   
    enum CodingKeys: String, CodingKey {
        case likes = "likes"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        likes = try values.decodeIfPresent(Int.self, forKey: .likes)
    }
}

struct Comment: Codable {
    let comments: Int?
   
    enum CodingKeys: String, CodingKey {
        case comments = "comments"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        comments = try values.decodeIfPresent(Int.self, forKey: .comments)
    }
}
