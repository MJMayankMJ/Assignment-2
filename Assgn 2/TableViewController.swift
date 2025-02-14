//
//  TableViewController.swift
//  Assgn 2
//
//  Created by Mayank Jangid on 2/14/25.
//

import UIKit

class TableViewController: UITableViewController {

    var maxNumber: Int = 0 // Number from TextField
    var currentlyPlayingIndex: IndexPath? // Track currently playing cell
    var playbackProgressRecord: [IndexPath: Float] = [:] // Store progress

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        tableView.tableFooterView = UIView()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return maxNumber
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MusicTableViewCell
        
        // Set number label
        cell.numberLabel.text = "\(indexPath.row + 1)"
        
        // Restore the correct playback progress
        cell.elapsedTime = playbackProgressRecord[indexPath] ?? 0
        cell.musicSlider.value = cell.elapsedTime
        
        // Handle play/pause logic
        cell.onPlayPause = { [weak self] in
            self?.handlePlayPause(for: cell, at: indexPath)
        }

        return cell
    }

    private func handlePlayPause(for cell: MusicTableViewCell, at indexPath: IndexPath) {
        
        // Save playback progress
        playbackProgressRecord[indexPath] = cell.elapsedTime

        // If a different cell was playing, stop it
        if let currentlyPlayingIndex = currentlyPlayingIndex,
           let playingCell = tableView.cellForRow(at: currentlyPlayingIndex) as? MusicTableViewCell,
           currentlyPlayingIndex != indexPath {
            playingCell.stopPlaying()
        }

        // Toggle play/pause
        if cell.isPlaying {
            cell.stopPlaying()
            currentlyPlayingIndex = nil
        } else {
            cell.startPlaying()
            currentlyPlayingIndex = indexPath
        }
    }
}
