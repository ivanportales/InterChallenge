import UIKit
import Combine

class PhotoTableViewCell: UITableViewCell {
    static let cellIdentifier = "PhotoCell"
    
    // MARK: - Private properties
    private var viewModel: PhotoTableCellViewModel?
    private var subscribers = Set<AnyCancellable>()
    private var photoURl: String = ""
    
    // MARK: - Private properties
    lazy var titleLabel: UILabel = {
        let labelView = makeGenericUILabelView(lines: 5)
        labelView.numberOfLines = 0
        return labelView
    }()
    
    lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupImageView()
        setTitleLabelView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("this view does not support Storyboard!")
    }
    
    func setDataWith(viewModel: PhotoTableCellViewModel?) {
        self.viewModel = viewModel
        titleLabel.text = viewModel?.photo.title
        setupBindings()
        viewModel?.getPhotoImsgeThumbnailurl()
    }
}

// MARK: - Private helper functions
extension PhotoTableViewCell {
    private func setupBindings() {
        viewModel?
            .$image
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] image in
                guard let self = self else { return }
                if image.imageUrl == self.viewModel?.photo.thumbnailUrl {
                    self.photoImageView.image = image
                }
            }).store(in: &subscribers)
    }
}

// MARK: - Private views setup functions
extension PhotoTableViewCell {
    private func setupImageView() {
        self.contentView.addSubview(photoImageView)
        NSLayoutConstraint.activate([
            photoImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            photoImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
            photoImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8),
            photoImageView.heightAnchor.constraint(greaterThanOrEqualToConstant: 150),
            photoImageView.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    private func setTitleLabelView() {
        self.contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(greaterThanOrEqualTo: self.contentView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            titleLabel.bottomAnchor.constraint(lessThanOrEqualTo: self.contentView.bottomAnchor, constant: -16),
            titleLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
        ])
    }
}

// MARK: - Helper class to help put the right image on cell
class UIImageWithUrl: UIImage {
    var imageUrl = ""
}
