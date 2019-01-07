//
//  ViewController.swift
//  StackView_ChineseZodiac
//
//  Created by James Chun on 1/2/19, modified by Mark Meretzky
//  Copyright © 2019 James Chun. All rights reserved.
//

import UIKit;

class ViewController: UIViewController {

    let rows: [[(String, Int)]] = [               //two dimensional array of tuples: 6 rows by 2 columns
        [("rat",    2008), ("ox",      2009)],
        [("tiger",  2010), ("rabbit",  2011)],
        [("dragon", 2012), ("snake",   2013)],
        [("horse",  2014), ("goat",    2015)],
        [("monkey", 2016), ("rooster", 2017)],
        [("dog",    2018), ("pig",     2019)]
    ];

/*
     let rows: [[(String, Int)]] = [               //two dimensional array of tuples: 4 rows by 3 columns
         [("rat",     2008), ("ox",     2009), ("tiger",  2010)],
         [("rabbit",  2011), ("dragon", 2012), ("snake",  2013)],
         [("horse",   2014), ("goat",   2015), ("monkey", 2016)],
         [("rooster", 2017), ("dog",    2018), ("pig",    2019)]
     ];
*/
 
    override func viewDidLoad() {
        super.viewDidLoad();
        // Do any additional setup after loading the view, typically from a nib.
        
        print("\(rows.count) rows, \(rows[0].count) columns");
        let color: UIColor = UIColor(red: 189/255, green: 7/255, blue: 17/255, alpha: 1);
        let spacing: CGFloat = 18; //spacing in all vertical UIStackViews except the smallest
        
        //Create the title label.
        
        let title: UILabel = UILabel();
        title.backgroundColor = color;
        title.font = UIFont(name: "Copperplate", size: 30);
        title.textColor = .white;
        
        title.text = " Chinese Zodiac ";   //spaces to allow rounded corners
        title.frame.size = title.intrinsicContentSize;
        title.layer.cornerRadius = title.frame.height / 2;
        title.layer.masksToBounds = true;
        let titleHeightConstraint: NSLayoutConstraint = title.heightAnchor.constraint(equalToConstant: title.frame.height);
        titleHeightConstraint.isActive = true;
        
        let bigVerticalStackView: UIStackView = UIStackView();  //will contain signs.count horizontal stack views
        bigVerticalStackView.axis = .vertical;
        bigVerticalStackView.distribution = .fillEqually;
        bigVerticalStackView.spacing = 18;
        //bigVerticalStackView.translatesAutoresizingMaskIntoConstraints = false;
        
        for row in rows {
            let horizontalStackView: UIStackView = UIStackView();
            horizontalStackView.axis = .horizontal;
            horizontalStackView.distribution = .fillEqually;
            bigVerticalStackView.addArrangedSubview(horizontalStackView);
            
            for sign in row {
                guard let image: UIImage = UIImage(named: sign.0) else {
                    continue; //Don't return.  Maybe we can get other signs to work.
                }
                let imageView: UIImageView = UIImageView(image: image);
                imageView.contentMode = .scaleAspectFit;   //Do not distort.
                
                let label: UILabel = UILabel();
                label.backgroundColor = color;
                label.font = UIFont(name: "Copperplate", size: 18);
                label.textColor = .white;
                label.text = " \(sign.0.capitalized): \(sign.1) ";   //spaces to allow rounded corners
                label.frame.size = label.intrinsicContentSize;
                label.layer.cornerRadius = label.frame.height / 2;
                label.layer.masksToBounds = true;
                
                let heightConstraint: NSLayoutConstraint = label.heightAnchor.constraint(equalToConstant: label.frame.height);
                heightConstraint.isActive = true;
                
                let smallVerticalStackView: UIStackView = UIStackView();
                smallVerticalStackView.axis = .vertical;
                smallVerticalStackView.distribution = .fill;
                smallVerticalStackView.alignment = .center;
                smallVerticalStackView.addArrangedSubview(imageView);
                smallVerticalStackView.addArrangedSubview(label);
                horizontalStackView.addArrangedSubview(smallVerticalStackView);
            }
        }
        
        //The biggest stack view contains the title and all the signs.
        
        let biggestVerticalStackView: UIStackView = UIStackView();
        biggestVerticalStackView.axis = .vertical;
        biggestVerticalStackView.alignment = .center;
        biggestVerticalStackView.spacing = spacing;
        biggestVerticalStackView.translatesAutoresizingMaskIntoConstraints = false;
        biggestVerticalStackView.addArrangedSubview(title);
        biggestVerticalStackView.addArrangedSubview(bigVerticalStackView);
        view.addSubview(biggestVerticalStackView);
        
        //Make the biggestVerticalStackView be coterminous
        //with the safe area of the big white view.
        
        let top: NSLayoutConstraint = biggestVerticalStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor);
        top.isActive = true;
        
        let bottom: NSLayoutConstraint = biggestVerticalStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor);
        bottom.isActive = true;
        
        let leading: NSLayoutConstraint = biggestVerticalStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor);
        leading.isActive = true;
        
        //Don't have to give a name to the instance of NSLayoutConstraint.
        biggestVerticalStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true;
    }
}
