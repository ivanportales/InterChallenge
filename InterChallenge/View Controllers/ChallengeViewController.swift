import Alamofire
import UIKit

class ChallengeViewController: UITableViewController {
    var repository: UsersRepository
    var users = [User]()
    
    init(repository: UsersRepository) {
        self.repository = repository
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("This view controller does not support Storyboard!")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: "UserCell")
        fillUsers()
    }
    
    private func fillUsers() {
        repository.getUsers { result in
            switch result {
            case .failure(let error):
                let alert = UIAlertController(title: "Erro", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
                    alert.dismiss(animated: true)
                }))
                self.present(alert, animated: true)
            case .success(let fetchedUsers):
                self.users = fetchedUsers
                self.tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as? UserTableViewCell else {
            return UITableViewCell()
        }
        
        let user = users[indexPath.item]
        cell.setDataFrom(user: user)
        cell.delegate = self
        cell.contentView.backgroundColor = indexPath.row % 2 == 0 ? .white : UIColor(white: 0.667, alpha: 0.2)
        
        return cell
    }
}

extension ChallengeViewController: UserTableViewCellDelegate {
    func didTapAlbums(with user: User) {
        let destinationVC = AlbumTableViewController(user: user, repository: WebAlbumsRepository())
        navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    func didTapPosts(with user: User) {
        let destinationVC = PostTableViewController(user: user, repository: WebPostsRepository())
        navigationController?.pushViewController(destinationVC, animated: true)
    }
}
