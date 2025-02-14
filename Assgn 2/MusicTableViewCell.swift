//
//  MusicTableViewCell.swift
//  Assgn 2
//
//  Created by Mayank Jangid on 2/14/25.
//

import UIKit

class MusicTableViewCell: UITableViewCell, UITableViewDelegate {
    
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var musicSlider: UISlider!
    @IBOutlet weak var playPauseButton: UIButton!
    
    var timer: Timer?
    var isPlaying = false
    var elapsedTime: Float = 0.0
    let totalTime: Float = 10.0
    var onPlayPause: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        musicSlider.minimumValue = 0
        musicSlider.maximumValue = totalTime
        musicSlider.value = elapsedTime
    }
    
    @IBAction func playPauseTapped(_ sender: UIButton) {
        onPlayPause?()
    }
    
    func startPlaying() {
        isPlaying = true
        playPauseButton.setTitle("Pause", for: .normal)
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            
            self.elapsedTime += 0.1
            self.musicSlider.value = self.elapsedTime
            
            if self.elapsedTime >= self.totalTime {
                self.stopPlaying()
            }
        }
    }
    
    func stopPlaying() {
        isPlaying = false
        playPauseButton.setTitle("Play", for: .normal)
        timer?.invalidate()
        timer = nil
    }
    
}

//    override func prepareForReuse() {
//        super.prepareForReuse()
//
//        elapsedTime = 0
//        musicSlider.value = 0
//
//        // Stop any active timer
//        timer?.invalidate()
//        timer = nil
//
//        isPlaying = false
//    }

