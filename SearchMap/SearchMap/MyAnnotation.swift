//
//  MyAnnotation.swift
//  SearchMap
//
//  Created by 杨奇 on 2018/8/13.
//  Copyright © 2018年 杨奇. All rights reserved.
//

import UIKit
import MapKit
class MyAnnotation: NSObject,MKAnnotation {
    var coordinate:CLLocationCoordinate2D = CLLocationCoordinate2DMake(0, 0)
    var title:String!
 init(coordinate:CLLocationCoordinate2D,title:String) {
        self.coordinate = coordinate
        self.title = title
    }
    
}
