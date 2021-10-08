import Combine
import UIKit

class PhotoDetailsViewController: UIViewController {
    var detailImageView: UIImageView = {
        let newView = UIImageView()
        newView.translatesAutoresizingMaskIntoConstraints = false
        
        return newView
    }()
    
    var nameLabel: UILabel = {
        let newView = UILabel()
        newView.translatesAutoresizingMaskIntoConstraints = false
        
        return newView
    }()
    
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
        self.view.addSubview(detailImageView)
        self.view.addSubview(nameLabel)
        self.view.backgroundColor = .white
        setImageView()
        setLabelView()
        detailImageView.image = image
        nameLabel.text = photo.title
    }
    
    private func setImageView() {
        NSLayoutConstraint.activate([
            detailImageView.heightAnchor.constraint(equalToConstant: 250),
            detailImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16),
            detailImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24),
            detailImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -24),
            detailImageView.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: -16)
        ])
    }
    
    private func setLabelView() {
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24),
            nameLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -24),
        ])
    }
}
