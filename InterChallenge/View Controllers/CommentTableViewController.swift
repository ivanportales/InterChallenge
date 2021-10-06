import Alamofire
import UIKit

class CommentTableViewController: UITableViewController {
    
    let user: User
    let post: Post
    let repository: CommentRepository
    var comments = [Comment]()
    
    init(user: User, post: Post, repository: CommentRepository) {
        self.repository = repository
        self.post = post
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("This view controller does not support Storyboard!")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Comentários de \(user.name)"
        tableView.register(UINib(nibName: "TitleAndDescriptionTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "TitleAndDescriptionCell")
        fillComments()
    }
    
    private func fillComments() {
        repository.getCommentsFrom(postId: post.id) { result in
            switch result {
            case .failure(let error):
                let alert = UIAlertController(title: "Erro", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
                    alert.dismiss(animated: true)
                }))
                self.present(alert, animated: true)
            case .success(let fetchedComments):
                self.comments = fetchedComments
                self.tableView.reloadData()
            }
        }   }

   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
   }
    
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TitleAndDescriptionCell", for: indexPath) as? TitleAndDescriptionTableViewCell else {
            return UITableViewCell()
        }

        let comment = comments[indexPath.row]
        cell.selectionStyle = .none
        cell.titleLabel.text = comment.name
        cell.descriptionLabel.text = comment.body

        return cell
    }
}
