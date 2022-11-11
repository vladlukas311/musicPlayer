
import UIKit
import AVFoundation

class PlayerViewController: UIViewController {

    //MARK: - public
    public var position: Int = 0
    public var songs: [Song] = []
    var player: AVAudioPlayer?
    @IBOutlet var holder: UIView!
    
    
    //MARK: - private
    private let albumImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let songNameLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .white
        label.layer.opacity = 0.8
        return label
    }()
    
    private let artistNameLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .white
        label.layer.opacity = 0.8
        return label
    }()
    
//    private let albumNameLabel: UILabel = {
//       let label = UILabel()
//        label.textAlignment = .center
//        label.numberOfLines = 0
//        label.textColor = .white
//        label.layer.opacity = 0.8
//        return label
//    }()

    private let playPauseButton = UIButton()
    private let playPauseButtonCircle = UIView()
    
    
    //MARK: - lifecycleFunc
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
        holder.backgroundColor = UIColor(red: 0.114, green: 0.09, blue: 0.149, alpha: 1)
    }
 
    //MARK: - viewDidLayoutSubviews
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if holder.subviews.count == 0 {
            configure()
        }
    }
    
    //MARK: - configure func
    
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
            player.volume = 0.5
            
            player.play()
        }
        catch {
            print("error occured")
        }
        
        //MARK: - UISetup
        
        albumImageView.frame = CGRect(x: 10,
                                      y: 10,
                                      width: holder.frame.size.width-20,
                                      height: holder.frame.size.width-20)
        albumImageView.image = UIImage(named: song.imageName)
        holder.addSubview(albumImageView)
        
        songNameLabel.frame = CGRect(x: 60,
                                     y: albumImageView.frame.size.height + 70,
                                      width: holder.frame.size.width-140,
                                      height: 70)
        artistNameLabel.frame = CGRect(x: 10,
                                      y: albumImageView.frame.size.height + 10 + 100,
                                      width: holder.frame.size.width-20,
                                      height: 70)
        
        songNameLabel.text = song.name
//        albumNameLabel.text = song.albumName
        artistNameLabel.text = song.artistName
        
        songNameLabel.font = UIFont(name: "Helvetica-Bold", size: 26)
//        albumNameLabel.font = UIFont(name: "Helvetica", size: 18)
        artistNameLabel.font = UIFont(name: "Helvetica-Boldv", size: 22)
        
        
        holder.addSubview(songNameLabel)
//        holder.addSubview(albumNameLabel)
        holder.addSubview(artistNameLabel)
        
        
        
        
        let nextButton = UIButton()
        let backButton = UIButton()
        
        
        let yPosition = artistNameLabel.frame.origin.y + 70 + 100
        let size: CGFloat = 50
        
        
        playPauseButton.frame = CGRect(x: (holder.frame.size.width - size) / 2.0,
                                       y: yPosition,
                                       width: size,
                                       height: size)
        nextButton.frame = CGRect(x: holder.frame.size.width - size - 70,
                                  y: yPosition,
                                  width: size,
                                  height: size)
        backButton.frame = CGRect(x: 70,
                                  y: yPosition,
                                  width: size,
                                  height: size)

        
        
        
        playPauseButton.addTarget(self, action: #selector(didTapPlayPauseButton), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        

        playPauseButton.setBackgroundImage(UIImage(systemName: "play"), for: .normal)
        backButton.setBackgroundImage(UIImage(systemName: "backward.end"), for: .normal)
        nextButton.setBackgroundImage(UIImage(systemName: "forward.end"), for: .normal)
        
        playPauseButton.tintColor = .white
        playPauseButton.layer.shadowColor = UIColor.white.cgColor
        playPauseButton.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        playPauseButton.layer.masksToBounds = false
        playPauseButton.layer.shadowRadius = 9.0
        playPauseButton.layer.shadowOpacity = 0.5
        playPauseButton.layer.cornerRadius = playPauseButton.frame.width / 2
        playPauseButton.layer.borderColor = UIColor.black.cgColor
        playPauseButton.layer.borderWidth = 0.0
        nextButton.tintColor = .white
        nextButton.layer.borderWidth = 1.0
        backButton.tintColor = .white
        
        
        
        holder.addSubview(playPauseButton)
        holder.addSubview(nextButton)
        holder.addSubview(backButton)
        
        
        let slider = UISlider(frame: CGRect(x: 20, y: holder.frame.size
            .height-60, width: holder.frame.size.width-40, height: 50))
        holder.addSubview(slider)
        slider.value = 0.5
        slider.addTarget(self, action: #selector(didSlideSlider(_:)), for: .valueChanged)
        holder.addSubview(slider)
        
    }
    
    //MARK: - @ObjC func
    
    @objc func didTapBackButton() {
        if position > 0 {
            position = position - 1
            player?.stop()
            for subview in holder.subviews {
                subview.removeFromSuperview()
            }
            configure()
        }
    }
    
    @objc func didTapNextButton() {
        if position < (songs.count - 1) {
            position = position + 1
            player?.stop()
            for subview in holder.subviews {
                subview.removeFromSuperview()
            }
            configure()
        }

    }
    
    @objc func didTapPlayPauseButton() {
        if player?.isPlaying  == true {
            //pause
            player?.pause()
            // show play button
            playPauseButton.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
            // shrink image
            UIView.animate(withDuration: 0.2, animations: {
                self.albumImageView.frame = CGRect(x: 30,
                                                   y: 30,
                                                   width: self.holder.frame.size.width-60,
                                                   height: self.holder.frame.size.width-60)
            })
        }
        else {
            //play
            player?.play()
            playPauseButton.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
            
            // increase image size
            UIView.animate(withDuration: 0.2, animations: {
                self.albumImageView.frame = CGRect(x: 10,
                                              y: 10,
                                                   width: self.holder.frame.size.width-20,
                                                   height: self.holder.frame.size.width-20)
            })
        }
    }
    
    @objc func didSlideSlider(_ slider: UISlider) {
        let value = slider.value
        player?.volume = value
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let player = player {
            player.stop()
        }
    }
    

}
