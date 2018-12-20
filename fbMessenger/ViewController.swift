//
//  ViewController.swift
//  fbMessenger
//
//  Created by Manveer Singh Pandher on 20/12/2018.
//  Copyright © 2018 Manveer Singh Pandher. All rights reserved.
//

import UIKit

class Friend : NSObject {
    
    var name : String?
    var profileImageName : UIImage?
}

class Message : NSObject {
    
    var text : String?
    var date : NSDate?
    
    var friendWhoSentMessage : Friend?
    
}

class FriendsController: UICollectionViewController {

    private final let cellID : String = "cellID"
    
    var messages : [Message]?
    
    func setupData() {
        //Person one
        let harambe = Friend()
        harambe.name = "Harambe"
        harambe.profileImageName = #imageLiteral(resourceName: "newHarambe")
        
        let messageOne = Message()
        messageOne.friendWhoSentMessage = harambe
        messageOne.text = "Hello. My name is Harambe. Nice to meet you man!"
        messageOne.date = NSDate()
         //Person Two
        
        let rasmus : Friend = Friend()
        rasmus.name = "Rasmus Agerup"
        rasmus.profileImageName = #imageLiteral(resourceName: "rasmusAgerup")
        
        let messageTwo : Message = Message()
        messageTwo.friendWhoSentMessage = rasmus
        messageTwo.text = "Hei Manveer! Rasmus her :)"
        messageTwo.date = NSDate()
        
        let david : Friend = Friend()
        david.name = "David Krogh"
        david.profileImageName = #imageLiteral(resourceName: "davidKrogh")
        
        let messageThree : Message = Message()
        messageThree.friendWhoSentMessage = david
        messageThree.text = "Heihei! Tilbake fra salgsmøte nå!"
        messageThree.date = NSDate()
        //Add all the messages to the messages array
        messages = [messageOne, messageTwo, messageThree]
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupData() //Gets data from method above
        
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.title="Recent"
        
        collectionView.backgroundColor = UIColor.white
        collectionView.register(MessageCell.self, forCellWithReuseIdentifier: cellID)
        
        // When you drag the screen up, it bounces back
        collectionView.alwaysBounceVertical = true
        
        //When you drag the screen sideways, it bounces back
        //  collectionView.alwaysBounceHorizontal = true
        
    }
    
    
}

extension FriendsController : UICollectionViewDelegateFlowLayout{
    //Methods from UICollectionViewController
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = messages?.count{
            return count
        }
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! MessageCell
        if let message = messages?[indexPath.item]{
            cell.message = message
        }
  
        
        return cell
    }
    
    //Methods from UICollectionViewDelegateFlowLayout. Used to describe each elements size according to the window its in
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //Each cell will have a width of the window, and max 100 height
        return CGSize(width: view.frame.width, height: 100)
    }
    
}

class MessageCell : BaseCell{
    
    var message : Message?{
        didSet{
            nameLabel.text = message?.friendWhoSentMessage?.name
            if let profileImageName = message?.friendWhoSentMessage?.profileImageName{
                 profileImageView.image = profileImageName
            }
            if let date = message?.date {
                let dateformatter = DateFormatter()
                dateformatter.dateFormat = "h:mm a"
                timeLabel.text = dateformatter.string(from: date as Date)
            }
            
           messageLabel.text = message?.text
            
            
        }
    }
    
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
    
    var nameLabel : UILabel = {
        let label : UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Friend Name"
        return label
    }()
    
    let messageLabel : UILabel = {
        let messageLabel : UILabel = UILabel()
        messageLabel.font = UIFont.systemFont(ofSize: 14)
        messageLabel.text = "Friends Message and something fadeeeeeee"
     
        messageLabel.backgroundColor = UIColor.white
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
    
    let hasReadImageView : UIImageView = {
        let imageView : UIImageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        return imageView
    }()
    override func setupViews() {
        backgroundColor = UIColor.gray
        
        addSubview(dividerLineView)
        addSubview(profileImageView)
        
        setupContainerView() //Will add a containerview as a subView. In the function
        
        dividerLineView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.image = #imageLiteral(resourceName: "newHarambe")
        hasReadImageView.image = #imageLiteral(resourceName: "newHarambe")
        
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
        
       
        addSubview(containerView)
        
        addConstraintsWithFormat(format: "H:|-90-[v0]|", views: containerView)
        addConstraintsWithFormat(format: "V:[v0(50)]", views: containerView)
         //Constraint to the height to be the center of the cell
        addConstraint(NSLayoutConstraint(item: (containerView), attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
        containerView.addSubview(nameLabel)
        containerView.addSubview(messageLabel)
        containerView.addSubview(timeLabel)
        containerView.addSubview(hasReadImageView)
        
        containerView.addConstraintsWithFormat(format: "H:|[v0][v1(80)]-12-|", views: nameLabel, timeLabel) //NameLabel and timeLabel
        
         containerView.addConstraintsWithFormat(format: "V:|[v0][v1(24)]|", views: nameLabel, messageLabel)
        
        containerView.addConstraintsWithFormat(format: "H:|[v0]-8-[v1(20)]-12-|", views: messageLabel, hasReadImageView) //MsgLabel
        
       
        containerView.addConstraintsWithFormat(format: "V:|[v0(24)]", views: timeLabel)
        containerView.addConstraintsWithFormat(format: "V:[v0(20)]|", views: hasReadImageView)
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
