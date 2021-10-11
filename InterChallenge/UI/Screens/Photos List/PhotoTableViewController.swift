import Combine
import UIKit

class PhotoTableViewController: UITableViewController {
    // MARK: - Private properties
    private let viewModel: PhotoTableViewModel
    private var subscribers = Set<AnyCancellable>()
    private var cellsViewMdodels = [PhotoTableCellViewModel?]()
    
    init(viewModel: PhotoTableViewModel) {
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
        viewModel.fillPhotos()
    }
}

// MARK: - Override of table view functions
extension PhotoTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.photos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PhotoTableViewCell.cellIdentifier, for: indexPath) as? PhotoTableViewCell else {
            return UITableViewCell()
        }
        
        let photo = viewModel.photos[indexPath.row]
        guard let cellViewModel = cellsViewMdodels[indexPath.row] else {
            let newCellViewModel = viewModel.makeTableCellViewModelWith(photo: photo)
            cell.setDataWith(viewModel: newCellViewModel)
            cellsViewMdodels[indexPath.row] = newCellViewModel
            return cell
        }
     
        cell.setDataWith(viewModel: cellViewModel)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let photo = viewModel.photos[indexPath.row]
        viewModel.getImageFrom(urlString: photo.url) { [weak self]result in
            switch result {
            case .success(let data):
                guard let self = self else { return }
                if let image = UIImage(data: data) {
                    self.viewModel.showDetailsOf(photo: photo, showingImage: image)
                }
            default:
                break
            }
        }
    }
}

// MARK: - Private helper functions
extension PhotoTableViewController {
    private func setupNavigationBar () {
        navigationItem.title = viewModel.navigationBarTitle
    }
    
    private func setupTableView() {
        tableView.register(PhotoTableViewCell.self, forCellReuseIdentifier: PhotoTableViewCell.cellIdentifier)
    }
    
    private func setupBindings() {
        viewModel
            .$photos
            .receive(on: DispatchQueue.main)
            .sink {[weak self] items in
                guard let self = self else { return }
                self.cellsViewMdodels = [PhotoTableCellViewModel?](repeating: nil, count: items.count)
                self.tableView.reloadData()
            }.store(in: &subscribers)
    }
}
