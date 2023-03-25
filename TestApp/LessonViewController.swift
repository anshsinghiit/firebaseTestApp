//
//  LessonViewController.swift
//  TestApp
//
//  Created by Ansh Singh on 25/03/23.
//

import UIKit
import AVFoundation
import AVKit

class LessonViewController: UIViewController {
    
    var completeData: CompleteData?
    
    var player: AVPlayer?
    
    var navigationBar: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var leftButton: UIButton = {
        let button = UIButton()
        button.setTitle("← App Course", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()
    
    var lessonTitle: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var shareButton: UIButton = {
        let image = UIButton()
        image.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
        return image
    }()
    
    var playerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        view.backgroundColor = .gray
        return view
    }()
    
    var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    @objc func backButtonTapped() {
        self.dismiss(animated: true)
    }
    
    @objc func shareButtonTapped() {
        guard playerView.isHidden else {
            playerView.isHidden = true
            return
        }
        playerView.isHidden = false
        player = AVPlayer()
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.playerView.bounds
        playerLayer.videoGravity = .resizeAspectFill
        playerView.layer.addSublayer(playerLayer)
        if let url = URL(string: self.completeData?.lessons[0].videoUrl ?? "") {
            player?.replaceCurrentItem(with: AVPlayerItem(url: url))
            player?.play()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        createViews()
        setupTableView()
        lessonTitle.text = self.completeData?.lessons[0].lessonName
    }
    
    func createViews() {
        view.backgroundColor = .white
        
        view.addSubview(navigationBar)
        view.addSubview(leftButton)
        view.addSubview(shareButton)
        view.addSubview(lessonTitle)
        view.addSubview(tableView)
        view.addSubview(playerView)
        
        NSLayoutConstraint.activate([
            navigationBar.heightAnchor.constraint(equalToConstant: 32),
            navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            leftButton.centerYAnchor.constraint(equalTo: navigationBar.centerYAnchor),
            leftButton.leadingAnchor.constraint(equalTo: navigationBar.leadingAnchor, constant: 12),
            shareButton.trailingAnchor.constraint(equalTo: navigationBar.trailingAnchor, constant: -12),
            shareButton.centerYAnchor.constraint(equalTo: navigationBar.centerYAnchor),
            lessonTitle.centerYAnchor.constraint(equalTo: navigationBar.centerYAnchor),
            lessonTitle.centerXAnchor.constraint(equalTo: navigationBar.centerXAnchor),
            tableView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            playerView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
            playerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            playerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            playerView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.bounces = true
        tableView.register(HeaderTableCell.self, forCellReuseIdentifier: String(describing: HeaderTableCell.self))
        tableView.register(TopicTableCell.self, forCellReuseIdentifier: String(describing: TopicTableCell.self))
    }

}

extension LessonViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : self.completeData?.lessons[0].topics.count ?? 0
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HeaderTableCell.self)) as! TableViewCell
            cell.delegate = self
            cell.item = self.completeData?.lessons[indexPath.row]
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TopicTableCell.self)) as! TableViewCell
            cell.delegate = self
            cell.item = self.completeData?.lessons[0].topics[indexPath.row]
            return cell
        }
    }
    
}
