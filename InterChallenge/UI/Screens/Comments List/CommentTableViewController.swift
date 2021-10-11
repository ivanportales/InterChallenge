import Combine
import UIKit

class CommentTableViewController: UITableViewController {
    // MARK: - Private properties
    private let viewModel: CommentTableViewModel
    private var subscribers = Set<AnyCancellable>()
    
    init(viewModel: CommentTableViewModel) {
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
        setupTabtleView()
        setupBindings()
        viewModel.fillComments()
    }
}

// MARK: - Override of table view functions
extension CommentTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.comments.count
    }
     
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleAndDescriptionTableViewCell.cellIdentifier, for: indexPath) as? TitleAndDescriptionTableViewCell else {
             return UITableViewCell()
         }

        let comment = viewModel.comments[indexPath.row]
        //cell.selectionStyle = .none
        cell.setDataFrom(model: comment, andStyle: .none)

         return cell
     }
}

// MARK: - Private helper functions
extension CommentTableViewController {
    private func setupNavigationBar() {
        navigationItem.title = viewModel.navigationBarTitle
    }
    
    private func setupTabtleView() {
        tableView.register(TitleAndDescriptionTableViewCell.self, forCellReuseIdentifier: TitleAndDescriptionTableViewCell.cellIdentifier)
    }
    private func setupBindings() {
        viewModel
            .$comments
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
