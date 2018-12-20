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
    
    let nameLabel : UILabel = {
        let label : UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Friend Name"
        return label
    }()
    
    let messageLabel : UILabel = {
        let messageLabel : UILabel = UILabel()
        messageLabel.font = UIFont.systemFont(ofSize: 14)
        messageLabel.text = "Friends Message and something fadeeeeeee"
     
        messageLabel.backgroundColor = UIColor.darkGray
        return messageLabel
    }()
    
    let timeLabel : UILabel = {
        let timeLabel : UILabel = UILabel()
        timeLabel.font = UIFont.systemFont(ofSize: 16)
        timeLabel.text = "12:05 pm"
        timeLabel.backgroundColor = UIColor.yellow
        timeLabel.textAlignment = .right
        return timeLabel
    }()
    
    override func setupViews() {
        backgroundColor = UIColor.gray
        
        addSubview(dividerLineView)
        addSubview(profileImageView)
        
        setupContainerView() //Will add a containerview as a subView. In the function
        
        dividerLineView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.image = #imageLiteral(resourceName: "newHarambe")
        
        //Constraints for the image in the cell
        addConstraintsWithFormat(format: "H:|-12-[v0(68)]", views: profileImageView)
        addConstraintsWithFormat(format: "V:[v0(68)]", views: profileImageView)
        //Constraints the height to be the center of the cell
        addConstraint(NSLayoutConstraint(item: profileImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        //Constraints for the divider line at the bottom of the cell
        addConstraintsWithFormat(format: "H:|-82-[v0]|", views: dividerLineView)
        addConstraintsWithFormat(format: "V:[v0(1)]", views: dividerLineView)
    
    }
    
    private func setupContainerView(){
        let containerView = UIView()
        containerView.backgroundColor = UIColor.blue
       
        addSubview(containerView)
        
        addConstraintsWithFormat(format: "H:|-90-[v0]|", views: containerView)
        addConstraintsWithFormat(format: "V:[v0(50)]", views: containerView)
         //Constraint to the height to be the center of the cell
        addConstraint(NSLayoutConstraint(item: (containerView), attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
        containerView.addSubview(nameLabel)
        containerView.addSubview(messageLabel)
        containerView.addSubview(timeLabel)
        containerView.addConstraintsWithFormat(format: "H:|[v0][v1(80)]-12-|", views: nameLabel, timeLabel) //NameLabel and timeLabel
        
        containerView.addConstraintsWithFormat(format: "H:|[v0]-12-|", views: messageLabel) //MsgLabel
        containerView.addConstraintsWithFormat(format: "V:|[v0][v1(24)]|", views: nameLabel, messageLabel)
        containerView.addConstraintsWithFormat(format: "V:|[v0(20)]", views: timeLabel)
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
       //Adds constraints on all the incomming views
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
