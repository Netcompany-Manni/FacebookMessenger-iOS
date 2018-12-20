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
        
        collectionView.backgroundColor = UIColor.red
        
        collectionView.register(FriendCell.self, forCellWithReuseIdentifier: cellID)
        
    }
    
    
}

extension FriendsController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
    }
    
    
}

class FriendCell : UICollectionViewCell{
    
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
