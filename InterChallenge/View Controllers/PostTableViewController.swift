import Alamofire
import UIKit

class PostTableViewController: UITableViewController {
    weak var coordinator: CommentCoordinator?
    let user: User
    let repository: PostRepository
    var posts = [Post]()
    
    init(user: User, repository: PostRepository, coordinator: CommentCoordinator) {
        self.repository = repository
        self.user = user
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("This view controller does not support Storyboard!")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Postagens de \(user.name)"
        tableView.register(UINib(nibName: "TitleAndDescriptionTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "TitleAndDescriptionCell")
        fillPosts()
    }
    
    private func fillPosts() {
        repository.getPostsFrom(userId: user.id) { result in
            switch result {
            case .failure(let error):
                let alert = UIAlertController(title: "Erro", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
                    alert.dismiss(animated: true)
                }))
                self.present(alert, animated: true)
            case .success(let fetchedUsers):
                self.posts = fetchedUsers
                self.tableView.reloadData()
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TitleAndDescriptionCell", for: indexPath) as? TitleAndDescriptionTableViewCell else {
            return UITableViewCell()
        }

        let post = posts[indexPath.row]
        cell.titleLabel.text = post.title
        cell.descriptionLabel.text = post.body

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = posts[indexPath.row]
        coordinator?.showCommentsIn(post: post, ofUser: user)
    }
}
