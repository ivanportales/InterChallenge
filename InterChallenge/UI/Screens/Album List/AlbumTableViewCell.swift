import UIKit

class AlbumTableViewCell: UITableViewCell {
    static let cellIdentifier = "AlbumCell"
    
    // MARK: - Declaration of views
    private lazy var albumNameLabel: UILabel = {
        let labelView = makeGenericUILabelView(lines: 0)
        return labelView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupAlbumNameLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("this view does not support Storyboard!")
    }
    
    func setDataOf(album: Album) {
        self.albumNameLabel.text = album.title
    }
}

// MARK: - Private views setup functions
extension AlbumTableViewCell {
    private func setupAlbumNameLabel() {
        self.contentView.addSubview(albumNameLabel)
        NSLayoutConstraint.activate([
            albumNameLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            albumNameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16),
            albumNameLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            albumNameLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -16)
        ])
    }
}
