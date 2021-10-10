import UIKit

class PhotoTableViewCell: UITableViewCell {
    static let cellIdentifier = "PhotoCell"
    
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
    
    func setDataOf(photo: Photo) {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("this view does not support Storyboard!")
    }
}

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
            titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 60),
            titleLabel.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            titleLabel.bottomAnchor.constraint(lessThanOrEqualTo: self.contentView.bottomAnchor, constant: -16)
        ])
    }
}
