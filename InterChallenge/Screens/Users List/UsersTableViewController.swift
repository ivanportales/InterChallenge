import Combine
import UIKit

class UsersTableViewController: UITableViewController {
    let viewModel: UsersTableViewModel
    var subscribers = Set<AnyCancellable>()
    
    init(viewModel: UsersTableViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("This view controller does not support Storyboard!")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setBindings()
        viewModel.fillUsers()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.cellIdentifier, for: indexPath) as? UserTableViewCell else {
            return UITableViewCell()
        }
        
        let user = viewModel.users[indexPath.item]
        cell.setDataFrom(user: user)
        cell.delegate = self
        cell.contentView.backgroundColor = indexPath.row % 2 == 0 ? .white : UIColor(white: 0.667, alpha: 0.2)
        
        return cell
    }
}

extension UsersTableViewController {
    private func setBindings() {
        viewModel
            .$users
            .receive(on: DispatchQueue.main)
            .sink { [weak self] itens in
                guard let self = self else { return }
                self.tableView.reloadData()
            }.store(in: &subscribers)
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: "UserCell")
    }
}

extension UsersTableViewController: UserTableViewCellDelegate {
    func didTapAlbums(with user: User) {
        viewModel.didTapAlbums(with: user)
    }
    
    func didTapPosts(with user: User) {
        viewModel.didTapPosts(with: user)
    }
}
