import Alamofire
import UIKit

class PhotoTableViewController: UITableViewController {
    weak var coordinator: MainCoordinator?
    var repository: PhotosRepository
    var user: User
    var album: Album
    var photos = [Photo]()
    
    init(user: User, album: Album, repository: PhotosRepository, coordinator: MainCoordinator) {
        self.repository = repository
        self.coordinator = coordinator
        self.album = album
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("This view controller does not support Storyboard!")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Fotos de \(user.name)"
        tableView.register(UINib(nibName: "PhotoTableViewCell", bundle: nil), forCellReuseIdentifier: "PhotoCell")
        fillPhotos()
    }
    
    private func fillPhotos() {
        repository.getPhotosFrom(albumId: album.id) { result in
            switch result {
            case .failure(let error):
                let alert = UIAlertController(title: "Erro", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
                    alert.dismiss(animated: true)
                }))
                self.present(alert, animated: true)
            case .success(let fetchedPhotos):
                self.photos = fetchedPhotos
                self.tableView.reloadData()
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as? PhotoTableViewCell else {
            return UITableViewCell()
        }

        let photo = photos[indexPath.row]
        cell.titleLabel.text = photo.title

        AF.download(photo.thumbnailUrl).responseData { response in
            switch response.result {
            case .success(let data):
                cell.photoImageView.image = UIImage(data: data)
            default:
                break
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let photo = photos[indexPath.row]
        AF.download(photo.url).responseData { [weak self] response in
            switch response.result {
            case .success(let data):
                guard let self = self else { return }
                if let image = UIImage(data: data) {
                    self.coordinator?.showDetailsOf(photo: photo, showingImage: image)
                }
            default:
                break
            }
        }
    }
}
