import Combine
import UIKit

class AlbumTableViewController: UITableViewController {
    private let viewModel: AlbumTableViewModel
    private var subscribers = Set<AnyCancellable>()
    
    init(viewModel: AlbumTableViewModel) {
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
        viewModel.fillAlbums()
    }
}

// MARK: - Override of table view functions
extension AlbumTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.albums.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AlbumTableViewCell.cellIdentifier, for: indexPath) as? AlbumTableViewCell else {
            return UITableViewCell()
        }

        let album = viewModel.albums[indexPath.row]
        cell.albumNameLabel.text = album.title

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let album = viewModel.albums[indexPath.row]
        viewModel.showPhotosIn(album: album)
    }
}

// MARK: - Private helper functions
extension AlbumTableViewController {
    private func setupNavigationBar() {
        navigationItem.title = "Álbuns de \(viewModel.navigationBarTitle)"
    }
    
    private func setupTabtleView() {
        tableView.register(UINib(nibName: "AlbumTableViewCell", bundle: nil), forCellReuseIdentifier: AlbumTableViewCell.cellIdentifier)
    }
    
    private func setupBindings() {
        viewModel
            .$albums
            .receive(on: DispatchQueue.main)
            .sink {[weak self] _ in
                guard let self = self else { return }
                self.tableView.reloadData()
            }.store(in: &subscribers)
    }
}
