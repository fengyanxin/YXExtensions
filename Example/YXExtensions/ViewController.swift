//
//  ViewController.swift
//  YXExtensions
//
//  Created by fengyanxin on 03/16/2023.
//  Copyright (c) 2023 fengyanxin. All rights reserved.
//

import UIKit
import YXExtensions

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let imgV = UIImageView.init(frame: CGRect(x: 100,
                                                  y: 100,
                                                  width: 60,
                                                  height: 60))
        imgV.image = UIImage.init(named: "ic_scooter")
        imgV.contentMode = .scaleAspectFit
        imgV.backgroundColor = .lightGray
        imgV.yx_clipsCorner(cornerRadius: 10)
        view.addSubview(imgV)
        
        print(UIDevice.extensions.yx_modelName)
        print(UIDevice.yx_modelName)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

