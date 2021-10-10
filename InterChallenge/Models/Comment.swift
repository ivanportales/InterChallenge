import Foundation

struct Comment: Codable {
    let id: Int
    let postId: Int
    let name: String
    let body: String
    
    enum CodingKeys: String, CodingKey {
        case id, postId, name, body
    }
}

extension Comment: TitleAndDescriptionCellDisplayable {
    var title: String {
        self.name
    }
    
    var description: String {
        self.body
    }
}
