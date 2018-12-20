//
//  ViewController.swift
//  fbMessenger
//
//  Created by Manveer Singh Pandher on 20/12/2018.
//  Copyright © 2018 Manveer Singh Pandher. All rights reserved.
//

import UIKit

class FriendsController: UICollectionViewController {

    private final let cellID : String = "cellID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.title="Recent"
        
        collectionView.backgroundColor = UIColor.white
        collectionView.register(FriendCell.self, forCellWithReuseIdentifier: cellID)
        
        // When you drag the screen up, it bounces back
        collectionView.alwaysBounceVertical = true
        
        //When you drag the screen sideways, it bounces back
        //  collectionView.alwaysBounceHorizontal = true
        
    }
    
    
}

extension FriendsController : UICollectionViewDelegateFlowLayout{
    //Methods from UICollectionViewController
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
    }
    
    //Methods from UICollectionViewDelegateFlowLayout. Used to describe each elements size according to the window its in
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //Each cell will have a width of the window, and max 100 height
        return CGSize(width: view.frame.width, height: 100)
    }
    
}

class FriendCell : BaseCell{
    
    let profileImageView : UIImageView = {
        let imageview : UIImageView = UIImageView()
        imageview.contentMode = .scaleAspectFit
        imageview.layer.cornerRadius = 34 
        imageview.layer.masksToBounds = true
        return imageview
    }()
    
    let dividerLineView : UIView = {
        let view : UIView = UIView()
        view.backgroundColor = UIColor.green
        return view
    }()
    
    override func setupViews() {
        backgroundColor = UIColor.white
        addSubview(dividerLineView)
        addSubview(profileImageView)
        dividerLineView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.image = #imageLiteral(resourceName: "newHarambe")
        
        //Constraints for the divider line at the bottom of the cell
        addConstraintsWithFormat(format: "H:|-82-[v0]|", views: dividerLineView)
        addConstraintsWithFormat(format: "V:[v0(1)]|", views: dividerLineView)
        //Constraints for the image in the cell
        addConstraintsWithFormat(format: "H:|-12-[v0(68)]", views: profileImageView)
        addConstraintsWithFormat(format: "V:|-12-[v0(68)]", views: profileImageView)
    }
}

extension UIView {
    
    func addConstraintsWithFormat(format : String, views : UIView...){
        //Dictionary for å holde en oversikt over alle viewsene. Key er en String, UIView er UIViewsene
     
        var viewsDictionary = [String : UIView]()
      
        //views.enumerated() lar lar oss
        for (index, view) in views.enumerated(){
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
   
    }
    
    
}

class BaseCell : UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupViews() {
        backgroundColor = UIColor.blue
    }
    
}
