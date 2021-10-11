import UIKit

protocol UserTableViewCellDelegate: AnyObject {
    func didTapAlbums(with user: User)
    func didTapPosts(with user: User)
}

class UserTableViewCell: UITableViewCell {
    static let cellIdentifier = "UserCell"
    
    private lazy var separatorView: UIView  = {
        var newView = makeGenericUIViewWith(backgroundColor: .lightGray)
        return newView
    }()
    
    private lazy var initialsContainerView: UIView  = {
        var newView = makeGenericUIViewWith(backgroundColor: .systemYellow)
        return newView
    }()
    
    private lazy var nameLabel: UILabel  = {
        var labelView = makeGenericUILabelView(lines: 0)
        labelView.textAlignment = .center
        return labelView
    }()
    
    private lazy var userNameLabel: UILabel  = {
        var labelView = makeGenericUILabelView(lines: 0)
        return labelView
    }()
    
    private lazy var initialsLabel: UILabel  = {
        var labelView = makeGenericUILabelView(lines: 0)
        labelView.textAlignment = .center
        return labelView
    }()
    
    private lazy var emailLabel: UILabel  = {
        var labelView = makeGenericUILabelView(lines: 0)
        return labelView
    }()
    
    private lazy var phoneLabel: UILabel  = {
        var labelView = makeGenericUILabelView(lines: 0)
        return labelView
    }()
    
    private lazy var albunsButtonView: UIButton  = {
        let buttonView = makeStackButtonWith(title: "ÁLBUNS", andSelector: #selector(albumsAction))
        return buttonView
    }()
    
    private lazy var postsButtonView: UIButton  = {
        let buttonView = makeStackButtonWith(title: "POSTAGENS", andSelector: #selector(postsAction))
        return buttonView
    }()
    
    private lazy var buttonsStackView: UIStackView  = {
        var stackView = UIStackView(arrangedSubviews: [albunsButtonView,postsButtonView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        return stackView
    }()
    
    weak var delegate: UserTableViewCellDelegate?
    var user: User!
    var id: Int = 0
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("This view does not support Storyboard!")
    }
    
    func setDataOf(user: User) {
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

    @objc private func albumsAction() {
        if let user = user, let delegate = delegate {
            delegate.didTapAlbums(with:user)
        }
    }
    
    @objc private func postsAction() {
        if let user = user, let delegate = delegate {
            delegate.didTapPosts(with: user)
        }
    }
}

extension UserTableViewCell {
    private func setupViews() {
        setupInitialsContainerView()
        setupSeparatorView()
        setupNameLabel()
        setupUsernameLabel()
        setupEmailLabel()
        setupPhoneLabel()
        setupButtonsStackView()
    }

    private func setupInitialsContainerView() {
        self.contentView.addSubview(initialsContainerView)
        NSLayoutConstraint.activate([
            initialsContainerView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16),
            initialsContainerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            initialsContainerView.heightAnchor.constraint(equalToConstant: 88),
            initialsContainerView.widthAnchor.constraint(equalToConstant: 88)
        ])
        setupInitialsLabel(on: initialsContainerView)
    }

    private func setupInitialsLabel(on view: UIView) {
        initialsContainerView.addSubview(initialsLabel)
        NSLayoutConstraint.activate([
            initialsLabel.topAnchor.constraint(equalTo: initialsContainerView.topAnchor),
            initialsLabel.leadingAnchor.constraint(equalTo: initialsContainerView.leadingAnchor),
            initialsLabel.trailingAnchor.constraint(equalTo: initialsContainerView.trailingAnchor),
            initialsLabel.bottomAnchor.constraint(equalTo: initialsContainerView.bottomAnchor)
        ])
    }

    private func setupSeparatorView() {
        self.contentView.addSubview(separatorView)
        NSLayoutConstraint.activate([
            separatorView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
            separatorView.leadingAnchor.constraint(equalTo: initialsContainerView.trailingAnchor, constant: 32),
            separatorView.widthAnchor.constraint(equalToConstant: 2)
        ])
    }

    private func setupNameLabel() {
        self.contentView.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: initialsContainerView.bottomAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: separatorView.leadingAnchor, constant: -32)
        ])
    }

    private func setupUsernameLabel() {
        self.contentView.addSubview(userNameLabel)
        NSLayoutConstraint.activate([
            userNameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16),
            userNameLabel.leadingAnchor.constraint(equalTo: separatorView.trailingAnchor, constant: 16),
            userNameLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16)
        ])
    }

    private func setupEmailLabel() {
        self.contentView.addSubview(emailLabel)
        NSLayoutConstraint.activate([
            emailLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 24),
            emailLabel.leadingAnchor.constraint(equalTo: separatorView.trailingAnchor, constant: 16),
            emailLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16)
        ])
    }

    private func setupPhoneLabel() {
        self.contentView.addSubview(phoneLabel)
        NSLayoutConstraint.activate([
            phoneLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 24),
            phoneLabel.leadingAnchor.constraint(equalTo: separatorView.trailingAnchor, constant: 16),
            phoneLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16)
        ])
    }

    private func setupButtonsStackView() {
        self.contentView.addSubview(buttonsStackView)
        NSLayoutConstraint.activate([
            buttonsStackView.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 24),
            buttonsStackView.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 64),
            buttonsStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            buttonsStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            buttonsStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8)
        ])
    }
}
