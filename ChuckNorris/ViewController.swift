//
//  ViewController.swift
//  ChuckNorris
//
//  Created by ZELIMKHAN MAGAMADOV on 27.08.2020.
//  Copyright © 2020 ZELIMKHAN MAGAMADOV. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet var logo: UIImageView!
  @IBOutlet var joke: UILabel!
  @IBOutlet var getJokeButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    getJokeButton.layer.cornerRadius = getJokeButton.frame.height / 2
    getJoke()
  
  }
  
  @IBAction func getJoke() {
    let url = URL(string: "https://api.chucknorris.io/jokes/random")
    let session = URLSession.shared
    let task = session.dataTask(with: url!) { (data, response, error) in
      if let data = data {
        let jsonDecoder = JSONDecoder()
        
        do {
          let joke = try jsonDecoder.decode(Joke.self, from: data)
          DispatchQueue.main.async {
            self.joke.text = joke.value
          }
        } catch {
          DispatchQueue.main.async {
            print("\(error)")
          }
          
        }
      } else {
        DispatchQueue.main.async {
          self.joke.text = "Error data!"
        }
        
      }
    }
    task.resume()
    Animations.requireUserAtencion(on: logo)
  }

}

class Animations {
  static func requireUserAtencion(on onView: UIImageView) {
    let animation = CABasicAnimation(keyPath: "position")
    animation.duration = 0.07
    animation.repeatCount = 3
    animation.autoreverses = true
    animation.fromValue = NSValue(cgPoint: CGPoint(x: onView.center.x - 5, y: onView.center.y))
    animation.toValue = NSValue(cgPoint: CGPoint(x: onView.center.x + 5, y: onView.center.y))
    onView.layer.add(animation, forKey: "position")
  }
}
