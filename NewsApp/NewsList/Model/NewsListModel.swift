import Foundation
class NewsList: Decodable {
    let articles: [News]
}
class News: Decodable {
    let title: String?
    let description: String?
    let urlToImage:String?
    let author:String?
    var comment:Int?
    var like:Int?
}

