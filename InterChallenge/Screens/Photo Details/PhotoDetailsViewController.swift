import Combine
import UIKit

class PhotoDetailsViewController: UIViewController {
    lazy var detailImageView: UIImageView = {
        let newView = UIImageView()
        newView.translatesAutoresizingMaskIntoConstraints = false
        
        return newView
    }()
    
    lazy var nameLabel: UILabel = {
        let labelView = UILabel()
        labelView.translatesAutoresizingMaskIntoConstraints = false
        labelView.numberOfLines = 0
        return labelView
    }()
    
    private let image: UIImage
    private let photo: Photo
    
    init(image: UIImage, photo: Photo) {
        self.image = image
        self.photo = photo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("This view controller does not support Storyboard!")
    }
    
    // MARK: - View Controller Life Cycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewControllerView()
        setNavigationBar()
        setLabelView()
        setImageView()
    }
}

// MARK: - Private helper functions
extension PhotoDetailsViewController {
    private func setNavigationBar() {
        navigationController?.title = "Detalhes"
        navigationItem.backButtonTitle = "Back"
    }
    
    private func setViewControllerView() {
        self.view.backgroundColor = .white
    }
    
    private func setLabelView() {
        self.view.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24),
            nameLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -24),
        ])
        nameLabel.text = photo.title
    }
    
    private func setImageView() {
        self.view.addSubview(detailImageView)
        NSLayoutConstraint.activate([
            detailImageView.heightAnchor.constraint(equalToConstant: 250),
            detailImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16),
            detailImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24),
            detailImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -24),
            detailImageView.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: -16)
        ])
        detailImageView.image = image
    }
}
