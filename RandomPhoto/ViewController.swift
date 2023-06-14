//
//  ViewController.swift
//  RandomPhoto
//
//  Created by Sammy Mehra on 6/11/23.
// 

import UIKit

let SAVED = "saved";

class ViewController: UIViewController {

    private let imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill;
        imageView.backgroundColor = .white;
        return imageView;
    }()
    
    private let button : UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Random Photo", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.lightGray, for: .disabled)
        return button
    }()
    
    private let saveButton : UIButton = {
        let saveButton = UIButton()
        saveButton.backgroundColor = .white
        saveButton.setTitle("Save Photo", for: .normal)
        saveButton.setTitleColor(.black, for: .normal)
        saveButton.setTitleColor(.lightGray, for: .disabled)
        return saveButton
    }()
    
    let colors : [UIColor] = [
        .systemBlue,
        .systemPink,
        .systemCyan,
        .systemGreen,
        .systemYellow,
        .systemPurple,
        .systemOrange
    ]
    
    var activePhotoUrlString = ""
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        defaults.set([] as [String], forKey: SAVED)
                
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemRed;
        view.addSubview(imageView)
        imageView.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        imageView.center = view.center
    
        view.addSubview(button)
        view.addSubview(saveButton)
        
        displayRandomCat()
        
        button.addTarget(self, action: #selector(didTapButton), for:.touchUpInside)
        saveButton.addTarget(self, action: #selector(didTapSaveButton), for:.touchUpInside)
    }
    
    @objc func didTapButton(){
        button.isEnabled = false
        displayRandomCat()
    }
    
    @objc func didTapSaveButton(){
        var urlArray:[String] = defaults.stringArray(forKey: SAVED)!
        urlArray.append(activePhotoUrlString)
        defaults.set(urlArray, forKey: SAVED);
        print(urlArray)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        button.frame = CGRect(x: 30, y: view.frame.size.height-150-view.safeAreaInsets.bottom, width: view.frame.size.width-60, height: 55)
        
        saveButton.frame = CGRect(x: 75, y: view.frame.size.height-70-view.safeAreaInsets.bottom, width: view.frame.size.width-150, height: 45)
    }

    func displayRandomCat() {
        
        struct Cat: Codable {
            var url: String
        }
        
        guard let catJsonUrl = URL(string: "https://cataas.com/cat?json=true") else{return}

        let task = URLSession.shared.dataTask(with: catJsonUrl) { data, response, error in

            let decoder = JSONDecoder()

            if let data = data {
                do {
                    let cat = try decoder.decode(Cat.self, from: data)
                    print("Got Cat:")
                    print(cat)
                    let catUrlString = "https://cataas.com" + cat.url
                    self.activePhotoUrlString = "https://cataas.com" + cat.url
                    let catUrl = URL(string:catUrlString)!
                    guard let data = try?Data(contentsOf: catUrl) else {return}
                    
                    // Main thread execution
                    DispatchQueue.main.async {
                        self.imageView.image = UIImage(data: data)
                        self.view.backgroundColor = self.colors.randomElement()
                        self.button.isEnabled = true
                    }
                    
                } catch {
                    print(error)
                    return
                }
            }
        }
        task.resume()

    }


}




