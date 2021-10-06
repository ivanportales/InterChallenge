import UIKit

protocol UserTableViewCellDelegate: AnyObject {
    func didTapAlbums(with user: User)
    func didTapPosts(with user: User)
}

class UserTableViewCell: UITableViewCell {
    
    @IBOutlet weak var initialsLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    weak var delegate: UserTableViewCellDelegate?
    var user: User!
    var id: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setDataFrom(user: User) {
        self.selectionStyle = .none
        self.user = user
        self.id = user.id
        self.initialsLabel.text = String(user.name.prefix(2))
        self.nameLabel.text = user.name
        self.userNameLabel.text = user.username
        self.emailLabel.text = user.email
        self.phoneLabel.text = user.phone
        
        //self.contentView.backgroundColor = indexPath.row % 2 == 0 ? .white : UIColor(white: 0.667, alpha: 0.2)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func albumsAction(_ sender: UIButton) {
        if let user = user, let delegate = delegate {
            delegate.didTapAlbums(with:user)
        }
    }
    
    @IBAction func postsAction(_ sender: UIButton) {
        if let user = user, let delegate = delegate {
            delegate.didTapPosts(with: user)
        }
    }
}
