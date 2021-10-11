import UIKit

protocol TitleAndDescriptionCellDisplayable {
    var title: String { get }
    var description: String { get }
}

class TitleAndDescriptionTableViewCell: UITableViewCell {
    static let cellIdentifier = "TitleAndDescriptionCell"
    
    lazy var titleLabel: UILabel = {
        let labelView = makeGenericUILabelView(withFontSize: 21, lines: 2)
        return labelView
    }()
    
    lazy var descriptionLabel: UILabel = {
        let labelView = makeGenericUILabelView(lines: 0)
        return labelView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupTitleLabel()
        setupDescriptionLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("this view does not support Sotryboard!")
    }
    
    func setDataFrom(model: TitleAndDescriptionCellDisplayable, andStyle style: UITableViewCell.SelectionStyle = .blue) {
        titleLabel.text = model.title
        descriptionLabel.text = model.description
        self.selectionStyle = style
    }
}

extension TitleAndDescriptionTableViewCell {
    private func setupTitleLabel() {
        self.contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
        ])
    }
    
    private func setupDescriptionLabel() {
        self.contentView.addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            descriptionLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -16)
        ])
    }
}
