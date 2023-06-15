//
//  SavedViewController.swift
//  RandomPhoto
//
//  Created by Sammy Mehra on 6/14/23.
//

import Foundation
import UIKit


class SavedViewController: UIViewController {
    
    private let imageViews : [UIImageView] = []
    
    public var savedUrls: [String] = [];

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemRed;
        
        // instantiate image views
        for i in 0...savedUrls.count-1 {
            let savedUrl: String = savedUrls[i]

            let imageView : UIImageView = {
                let imageView = UIImageView()
                imageView.contentMode = .scaleAspectFill;
                imageView.backgroundColor = .white;
                return imageView;
            }()
            
        }

        

    }

}

