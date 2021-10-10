import Combine
import UIKit

class PostTableViewController: UITableViewController {
    private let viewModel: PostsTableViewModel
    private var subscribers = Set<AnyCancellable>()
    
    init(viewModel: PostsTableViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("This view controller does not support Storyboard!")
    }
    
    // MARK: - View Controller Life Cycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
        setupBindings()
        viewModel.fillPosts()
    }
}

// MARK: - Override of table view functions
extension PostTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleAndDescriptionTableViewCell.cellIdentifier, for: indexPath) as? TitleAndDescriptionTableViewCell else {
            return UITableViewCell()
        }

        let post = viewModel.posts[indexPath.row]
        cell.setDataFrom(model: post)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = viewModel.posts[indexPath.row]
        viewModel.showCommentsOf(post: post)
    }
}

// MARK: - Private helper functions
extension PostTableViewController {
    private func setupNavigationBar() {
        navigationItem.title = "Postagens de \(viewModel.navigationBarTitle)"
    }
    
    private func setupTableView() {
        tableView.register(TitleAndDescriptionTableViewCell.self, forCellReuseIdentifier: TitleAndDescriptionTableViewCell.cellIdentifier)
    }
    
    private func setupBindings() {
        viewModel
            .$posts
            .receive(on: DispatchQueue.main)
            .sink {[weak self] _ in
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
