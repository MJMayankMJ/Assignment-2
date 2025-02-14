//
//  TableViewController.swift
//  Assgn 2
//
//  Created by Mayank Jangid on 2/14/25.
//

import UIKit

class TableViewController: UITableViewController{

    var maxNumber: Int = 0 // TextField no.
    var currentlyPlayingIndex: IndexPath? // Track currently playing cell
    var playbackProgressRecord : [IndexPath: Float] = [:]

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
        cell.numberLabel.text = "\(indexPath.row + 1)" // Show row number
        
        // Handle play/pause callback
        cell.onPlayPause = { [weak self] in //weak self to prevent memory leaks
            self?.handlePlayPause(for: cell, at: indexPath)
        }
        //So as the weird thing when the cells re use doesnt happen
        cell.elapsedTime = playbackProgressRecord[indexPath] ?? 0
        cell.musicSlider.value = cell.elapsedTime
        return cell
    }

    //stop other than play yourself feature
    private func handlePlayPause(for cell: MusicTableViewCell, at indexPath: IndexPath) {
        
        playbackProgressRecord[indexPath] = cell.elapsedTime

        //if nothing is pressed
        if let currentlyPlayingIndex = currentlyPlayingIndex,
           //if playing cell is not MusicTableViewCell type as in diff thingie
           let playingCell = tableView.cellForRow(at: currentlyPlayingIndex) as? MusicTableViewCell,
           //if the tapped cell is different from the currently playing one
           currentlyPlayingIndex != indexPath {
            // stop the previous playing cell
            playingCell.stopPlaying()
        }

        
        if cell.isPlaying {
            cell.stopPlaying()
            currentlyPlayingIndex = nil
        } else {
            cell.startPlaying()
            currentlyPlayingIndex = indexPath
        }
    }
}
