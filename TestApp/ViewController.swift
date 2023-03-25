//
//  ViewController.swift
//  TestApp
//
//  Created by Ansh Singh on 18/03/23.
//

import UIKit
import FirebaseDatabase
import FirebaseSharedSwift

class ViewController: UIViewController {
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("Lesson 1", for: .normal)
        button.backgroundColor = .blue
        button.isHidden = true
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    var result: CompleteData?
    
    var ref: DatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(button)
        button.frame = CGRect(x: 100, y: 600, width: 100, height: 100)
        ref = Database.database().reference()
        let _ = ref.observe(DataEventType.value, with: { snapshot in
            guard let data = try? JSONSerialization.data(withJSONObject: snapshot.value) else {return}
            let decoder = JSONDecoder()
            if let result = try? decoder.decode(CompleteData.self, from: data) {
                self.result = result
                self.button.isHidden = false
            }
        })
    }
    
    @objc func buttonTapped() {
        let vc = LessonViewController()
        vc.completeData = self.result
        let navVc = UINavigationController(rootViewController: vc)
        navVc.modalPresentationStyle = .fullScreen
        navVc.isNavigationBarHidden = true
        self.present(navVc, animated: true)
    }
}

struct Lesson: Codable {
    var videoUrl: String
    var lessonName: String
    var title: String
    var subtitle: String
    var description: String
    var coverImage: String
    var topics: [Topic]
    
    enum CodingKeys: String, CodingKey {
        case lessonName = "lesson_name"
        case title = "title"
        case subtitle = "subtitle"
        case description = "description"
        case coverImage = "cover_image"
        case topics = "topic"
        case videoUrl = "video_url"
    }
    
    init(lessonName: String, title: String, subtitle: String, description: String, coverImage: String, topics: [Topic], video: String) {
        self.lessonName = lessonName
        self.title = title
        self.subtitle = subtitle
        self.description = description
        self.coverImage = coverImage
        self.topics = topics
        self.videoUrl = video
    }
}

struct Topic: Codable {
    var topicTitle: String
    var topicDescription: String
    var topicImage: String
    var imageAtTop: Bool
    var bgColor: String
    
    enum CodingKeys: String, CodingKey {
        case topicTitle = "topic_title"
        case topicDescription = "topic_description"
        case topicImage = "topic_image"
        case imageAtTop = "image_at_top"
        case bgColor = "bg_color"
    }
    
    init(title: String, description: String, image: String, atTop: Bool, color: String) {
        self.topicImage = image
        self.topicTitle = title
        self.topicDescription = description
        self.imageAtTop = atTop
        self.bgColor = color
    }
}

struct CompleteData: Codable {
    var lessons: [Lesson]
    
    enum CodingKeys: String, CodingKey {
        case lessons = "lessons"
    }
}

