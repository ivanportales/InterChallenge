import UIKit

class DetailsViewController: UIViewController {
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    let image: UIImage
    let photo: Photo
    
    init(image: UIImage, photo: Photo) {
        self.image = image
        self.photo = photo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("This view controller does not support Storyboard!")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailImageView.image = image
        nameLabel.text = photo.title
    }
}
