

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet var table: UITableView!
    
    private var songs = [Song]()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.topItem?.title = "Your music is here"
        table.delegate = self
        table.dataSource = self
        configureSongs()
        setupUI()
    }
    
    func setupUI() {
        table.translatesAutoresizingMaskIntoConstraints = false
        table.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        table.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        table.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        table.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
    }
    
    func configureSongs() {
        songs.append(Song(name: "Малиновый закат",
//                          albumName: "Малый повзрослел",
                          artistName: "Макс Корж",
                          imageName: "image1",
                          trackName: "song1"))
        songs.append(Song(name: "Макс гей",
//                          albumName: "ко мне",
                          artistName: "назад",
                          imageName: "image2",
                          trackName: "song2"))
        songs.append(Song(name: "того все",
//                          albumName: "делал",
                          artistName: "дадада",
                          imageName: "image3",
                          trackName: "song3"))
    }
    // table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
     
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let song = songs[indexPath.row]
        cell.textLabel?.text = song.name
//        cell.detailTextLabel?.text = song.albumName
        cell.accessoryType = .disclosureIndicator
        cell.imageView?.image = UIImage(named: song.imageName)
        cell.textLabel?.font = UIFont(name: "Helvetica-Bold", size: 18)
        cell.detailTextLabel?.font = UIFont(name: "Helvetica", size: 17)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let position = indexPath.row
        
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "player") as? PlayerViewController else { return
        }
        vc.songs = songs
        vc.position = position
        present(vc, animated: true)
    }


}

struct Song {
    let name: String
//    let albumName: String
    let artistName: String
    let imageName: String
    let trackName: String
}
