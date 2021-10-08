import Combine
import UIKit

class UsersTableViewController: UITableViewController {
    private let viewModel: UsersTableViewModel
    private var subscribers = Set<AnyCancellable>()
    
    init(viewModel: UsersTableViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("This view controller does not support Storyboard!")
    }
    
    // MARK: - View Controller Life Cycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setBindings()
        viewModel.fillUsers()
    }
}
   
// MARK: - Override of table view functions
extension UsersTableViewController {
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

// MARK: - Private helper functions
extension UsersTableViewController {
    private func setupTableView() {
        tableView.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: UserTableViewCell.cellIdentifier)
    }
    
    private func setBindings() {
        viewModel
            .$users
            .receive(on: DispatchQueue.main)
            .sink { [weak self] itens in
                guard let self = self else { return }
                self.tableView.reloadData()
            }.store(in: &subscribers)
        
        viewModel
            .$errorMessage
            .receive(on: DispatchQueue.main)
            .sink {[weak self] message in
                guard let self = self else { return }
                if !message.isEmpty {
                    self.presentErrorAlertWith(message: message)
                }
            }.store(in: &subscribers)
    }
}

// MARK: - Table view cell delegate functions
extension UsersTableViewController: UserTableViewCellDelegate {
    func didTapAlbums(with user: User) {
        viewModel.didTapAlbums(with: user)
    }
    
    func didTapPosts(with user: User) {
        viewModel.didTapPosts(with: user)
    }
}
