
import UIKit
import AVFoundation

class PlayerViewController: UIViewController {

    
    public var position: Int = 0
    public var songs: [Song] = []
    var player: AVAudioPlayer?
    @IBOutlet var holder: UIView!
    
    private let albumImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let songNameLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let artistNameLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let albumNameLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()


    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiSetup()

    }
    
    func uiSetup() {
        holder.translatesAutoresizingMaskIntoConstraints = false
        holder.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        holder.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        holder.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        holder.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
    }

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if holder.subviews.count == 0 {
            configure()
        }
        

    }
    func configure() {
        let song = songs[position]
        
        let urlString = Bundle.main.path(forResource: song.trackName, ofType: "mp3")
        
        do {
           try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            
            guard let urlString = urlString else {
                return
            }
            player = try AVAudioPlayer(contentsOf: URL(string: urlString)!)
            guard let player = player else {
            return
            }
            player.play()
        }
        catch {
            print("error occured")
        }
        
        albumImageView.frame = CGRect(x: 10,
                                      y: 10,
                                      width: holder.frame.size.width-20,
                                      height: holder.frame.size.width-20)
        albumImageView.image = UIImage(named: song.imageName)
        holder.addSubview(albumImageView)
        
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let player = player {
            player.stop()
        }
    }
    

}
