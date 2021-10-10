import Combine
import Alamofire
import UIKit

class PhotoTableViewController: UITableViewController {
    private let viewModel: PhotoTableViewModel
    private var subscribers = Set<AnyCancellable>()
    
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

// tem que criar um repo ou service pra pegar as imagens e cachear na memória RAM
// MARK: - Override of table view functions
extension PhotoTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.photos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PhotoTableViewCell.cellIdentifier, for: indexPath) as? PhotoTableViewCell else {
            return UITableViewCell()
        }

    // criar uma view model pra cada e fazer com que todas tenham a mesma repo como referencia, a repo da VM dessa tela
        let photo = viewModel.photos[indexPath.row]
        cell.titleLabel.text = photo.title
        
        viewModel.getImageFrom(urlString: photo.thumbnailUrl) { result in
            switch result {
            case .success(let data):
                cell.photoImageView.image = UIImage(data: data)
            default:
                break
            }
        }
        
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
        navigationItem.title = "Fotos de \(viewModel.navigationBarTitle)"
    }
    
    private func setupTableView() {
        tableView.register(PhotoTableViewCell.self, forCellReuseIdentifier: PhotoTableViewCell.cellIdentifier)
    }
    
    private func setupBindings() {
        viewModel
            .$photos
            .receive(on: DispatchQueue.main)
            .sink {[weak self] _ in
                guard let self = self else { return }
                self.tableView.reloadData()
            }.store(in: &subscribers)
    }
}
