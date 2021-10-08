import UIKit

class AlbumTableViewCell: UITableViewCell {
    static let cellIdentifier = "AlbumCell"
    @IBOutlet weak var albumNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
