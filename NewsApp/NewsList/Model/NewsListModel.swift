import Foundation

struct NewsList: Codable {
    let articles: [News]?
   
    enum CodingKeys: String, CodingKey {
        case articles = "articles"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        articles = try values.decodeIfPresent([News].self, forKey: .articles)
    }
}

struct News: Codable {
    let title: String?
    let description: String?
    let urlToImage:String?
    let author:String?
    let publishedAt: String?
    
    enum CodingKeys: String, CodingKey {
                case title = "title"
                case description = "description"
                case urlToImage = "urlToImage"
                case author = "author"
                case publishedAt = "publishedAt"
     }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                title = try values.decodeIfPresent(String.self, forKey: .title)
                description = try values.decodeIfPresent(String.self, forKey: .description)
                urlToImage = try values.decodeIfPresent(String.self, forKey: .urlToImage)
                author = try values.decodeIfPresent(String.self, forKey: .author)
                publishedAt = try values.decodeIfPresent(String.self, forKey: .publishedAt)
               
        }
}



extension KeyedDecodingContainer{
    public func checkValidation<T: Decodable>(_ type: T.Type, forKey key: KeyedDecodingContainer<K>.Key) throws ->  T?{
        if let resStr = try? decodeIfPresent(type, forKey: key){
            return resStr
        }else{
            return nil
        }
    }
}
