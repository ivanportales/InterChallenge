import Foundation

struct Post: Codable {
    let id: Int
    let userId: Int
    let title: String
    let body: String
    
    enum CodingKeys: String, CodingKey {
        case id, userId, title, body
    }
}

extension Post: TitleAndDescriptionCellDisplayable {
    var description: String {
        self.body
    }
}
