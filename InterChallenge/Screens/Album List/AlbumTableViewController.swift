import UIKit

class AlbumTableViewController: UITableViewController {
    weak var coordinator: MainCoordinator?
    var user: User
    var repository: AlbumsRepository
    var albums = [Album]()
    
    init(user: User, repository: AlbumsRepository, coordinator: MainCoordinator) {
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
        navigationItem.title = "Álbuns de \(user.name)"
        tableView.register(UINib(nibName: "AlbumTableViewCell", bundle: nil), forCellReuseIdentifier: "AlbumCell")
        fillAlbums()
    }
    
    private func fillAlbums() {
        repository.getAlbumsOf(userId: user.id) { result in
            switch result {
            case .failure(let error):
                let alert = UIAlertController(title: "Erro", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
                    alert.dismiss(animated: true)
                }))
                self.present(alert, animated: true)
            case .success(let fetchedAlbums):
                self.albums = fetchedAlbums
                self.tableView.reloadData()
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumCell", for: indexPath) as? AlbumTableViewCell else {
            return UITableViewCell()
        }

        let album = albums[indexPath.row]
        cell.albumNameLabel.text = album.title

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let album = albums[indexPath.row]
        coordinator?.showPhotosIn(album: album, ofUser: user)
    }
}
