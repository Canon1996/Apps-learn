//
//  ViewController.swift
//  SearchMap
//
//  Created by 杨奇 on 2018/8/12.
//  Copyright © 2018年 杨奇. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var btnHotel: UIButton!
    @IBOutlet weak var btnHosptial: UIButton!
    
    @IBOutlet weak var btnSM: UIButton!
    @IBAction func btnHotleClick(_ sender: Any) {
        mapView.removeAnnotations(mapView.annotations)
        searchMap(place: "hotle")
        
        reset()
    }
    @IBAction func btnHospitalClick(_ sender: Any) {
        mapView.removeAnnotations(mapView.annotations)
        searchMap(place: "hospital")
        reset()
    }
    @IBAction func btnSMClick(_ sender: Any) {
        mapView.removeAnnotations(mapView.annotations)
        searchMap(place: "supermarket")
        reset()
    }
    //初始化位置
    let intialLocation = CLLocation(latitude: 28.6352979715, longitude: 121.3782001463)
    //设置搜索范围
    let searchRadius:CLLocationDistance = 5000
    
    //@IBOutlet weak var btnHospitalClick: UIButton!
    
    @IBAction func btnMenuClick(_ sender: Any) {
        UIView.animate(withDuration: 0.5, delay: 0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            self.btnMenu.transform = CGAffineTransform(rotationAngle: 0.25*3.1415927)
            self.btnHotel.alpha = 0.8
            self.btnHotel.transform = CGAffineTransform(scaleX: 1.5,y: 1.5).concatenating(CGAffineTransform(translationX: -80,y: -25))
            self.btnHosptial.transform = CGAffineTransform(scaleX: 1.5,y: 1.5).concatenating(CGAffineTransform(translationX: 0,y: -50))
            self.btnSM.transform = CGAffineTransform(scaleX: 1.5,y: 1.5).concatenating(CGAffineTransform(translationX: 80,y: -25))
            self.btnHosptial.alpha = 0.8
            self.btnSM.alpha = 0.8
        }, completion: nil)
    }
    @IBOutlet weak var btnMenu: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.btnMenu.alpha = 0
        //对三个按钮透明度的设置
        self.btnHotel.alpha = 0
        self.btnHosptial.alpha = 0
        self.btnSM.alpha = 0
        //使三个按钮变成圆角矩形
        self.btnHotel.layer.cornerRadius = 10
        self.btnHosptial.layer.cornerRadius = 10
        self.btnSM.layer.cornerRadius = 10
        UIView.animate(withDuration: 1, delay: 1, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            self.btnMenu.alpha = 1
            self.btnMenu.transform = CGAffineTransform(rotationAngle: 0.5*3.1415927)
        }, completion: nil)
        //创建一个区域
        let region = MKCoordinateRegionMakeWithDistance(intialLocation.coordinate, searchRadius, searchRadius)
        //设置显示
        mapView.setRegion(region, animated: true)
        searchMap(place: "place")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func reset(){
        UIView.animate(withDuration: 0.3, delay: 0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            self.btnHotel.alpha = 0
            self.btnHotel.transform = CGAffineTransform(scaleX: 1,y: 1).concatenating(CGAffineTransform(translationX: 0,y: 0))
            self.btnHosptial.alpha = 0
            self.btnHosptial.transform = CGAffineTransform(scaleX: 1,y: 1).concatenating(CGAffineTransform(translationX: 0,y: 0))
            self.btnSM.alpha = 0
            self.btnSM.transform = CGAffineTransform(scaleX: 1,y: 1).concatenating(CGAffineTransform(translationX: 0,y: 0))
        }, completion: nil)
        
    }
    //增加兴趣地点
    func addLocation(title:String,latitude:CLLocationDegrees,longtitude:CLLocationDegrees){
     let location = CLLocationCoordinate2D(latitude: latitude, longitude: longtitude)
     let annotation = MyAnnotation(coordinate: location, title: title)
     mapView.addAnnotation(annotation)
     }
    
    //搜索
    func searchMap(place:String){
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = place
    //搜索当前区域
    let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    request.region = MKCoordinateRegion(center: intialLocation.coordinate, span: span)
    //启动搜索并且把返回结果保存在数组中
        let search = MKLocalSearch(request: request)
        search.start { (response:MKLocalSearchResponse!, error:Error!) -> Void in
            for item in response.mapItems {
                self.addLocation(title: item.name!, latitude: (item.placemark.location?.coordinate.latitude)!, longtitude: (item.placemark.location?.coordinate.longitude)!)
            }
        }
    }
    
}

