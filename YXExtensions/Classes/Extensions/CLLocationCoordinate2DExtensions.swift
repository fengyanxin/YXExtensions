//
//  CLLocationCoordinate2DExtensions.swift
//  YXExtensions
//
//  Created by 彭鹤 on 2023/3/21.
//

import Foundation
import CoreLocation

// --- transform_earth_from_mars ---
// 参考来源：https://on4wp7.codeplex.com/SourceControl/changeset/view/21483#353936
// Krasovsky 1940
//
// a = 6378245.0, 1/f = 298.3
// b = a * (1 - f)
// ee = (a^2 - b^2) / a^2;
let a : Double = 6378245.0
let ee : Double = 0.00669342162296594323
 
// --- transform_earth_from_mars end ---
// --- transform_mars_vs_bear_paw ---
// 参考来源：http://blog.woodbunny.com/post-68.html
let x_pi : Double = .pi * 3000.0 / 180.0

extension CLLocationCoordinate2D{

    //MARK: -- 获取一个地理围栏的中心点
    static func yx_getCenterPointFromCoordinates(geoCoordinateList: [CLLocationCoordinate2D]) -> CLLocationCoordinate2D{

        let total: Double = Double(geoCoordinateList.count)
        var X: Double = 0.0
        var Y: Double = 0.0
        var Z: Double = 0.0

        for geoCoordinate in geoCoordinateList {
            var lat: Double = 0.0
            var lon: Double = 0.0
            var x: Double = 0.0
            var y: Double = 0.0
            var z: Double = 0.0
            lat = geoCoordinate.latitude * .pi / 180.0
            lon = geoCoordinate.longitude * .pi / 180.0
            x = cos(lat) * cos(lon)
            y = cos(lat) * sin(lon)
            z = sin(lat)
            X += x
            Y += y
            Z += z
        }
        X = X / total;
        Y = Y / total;
        Z = Z / total;
        let Lon: Double = atan2(Y, X)
        let Hyp: Double = sqrt(X * X + Y * Y)
        let Lat: Double = atan2(Z, Hyp)
        return CLLocationCoordinate2D.init(latitude: Lat * 180 / .pi , longitude: Lon * 180 / .pi)
    }
    
    //MARK: -- 判断一个坐标点是否在国内
    func yx_outOfChina() -> Bool {
        
        if self.longitude < 72.004 || self.longitude > 137.8347 ||
            self.latitude < 0.8293 || self.latitude > 55.8271{
            return true
        }
        return false
    }
    
    //MARK: -- 坐标系转换
    /// 从地图坐标转化到火星坐标
    ///
    /// - Returns: CLLocationCoordinate2D
    func yx_locationMarsFromEarth() -> CLLocationCoordinate2D {
        
        let (n_lat,n_lng) = CLLocationCoordinate2D.transform_earth_from_mars(lat: self.latitude, lng: self.longitude)
        let coord_2d      = CLLocationCoordinate2D(latitude: n_lat + self.latitude, longitude: n_lng + self.longitude)
        
        return coord_2d
    }
    
    /// 从火星坐标到地图坐标
    ///
    /// - Returns: CLLocationCoordinate2D
    func yx_locationEarthFromMars() -> CLLocationCoordinate2D {
        
        let (n_lat,n_lng) = CLLocationCoordinate2D.transform_earth_from_mars(lat: self.latitude, lng: self.longitude)
        let coord_2d = CLLocationCoordinate2D(latitude: self.latitude - n_lat, longitude: self.longitude - n_lng)
        
        return coord_2d
    }
    
    /// 从火星坐标转化到百度坐标
    ///
    /// - Returns: CLLocationCoordinate2D
    func yx_locationBaiduFromMars() -> CLLocationCoordinate2D {
        
        let (n_lat,n_lng) = CLLocationCoordinate2D.transform_mars_from_baidu(lat: self.latitude, lng: self.longitude)
        let coord_2d = CLLocationCoordinate2D(latitude: n_lat, longitude: n_lng)
        
        return coord_2d
    }
    
    /// 从百度坐标到火星坐标
    ///
    /// - Returns: CLLocationCoordinate2D
    func yx_locationMarsFromBaidu() -> CLLocationCoordinate2D {
        let (n_lat,n_lng) = CLLocationCoordinate2D.transform_baidu_from_mars(lat: self.latitude, lng: self.longitude)
        let coord_2d = CLLocationCoordinate2D(latitude: n_lat, longitude: n_lng)
        
        return coord_2d
    }
    
    /// 从百度坐标到地图坐标
    ///
    /// - Returns: CLLocationCoordinate2D
    func yx_locationEarthFromBaidu() -> CLLocationCoordinate2D {
        
        let mars = self.yx_locationMarsFromBaidu()
        let (n_lat,n_lng) = CLLocationCoordinate2D.transform_earth_from_mars(lat: mars.latitude, lng: mars.longitude)
        let coord_2d = CLLocationCoordinate2D(latitude: self.latitude - n_lat, longitude: self.longitude - n_lng)
        
        return coord_2d
    }
}

extension CLLocationCoordinate2D{
    
    private static func transform_earth_from_mars(lat: Double, lng: Double) -> (Double, Double) {
        if CLLocationCoordinate2D.transform_sino_out_china(lat: lat, lng: lng) {
            return (lat, lng)
        }
        var dLat = CLLocationCoordinate2D.transform_earth_from_mars_lat(lng - 105.0, lat - 35.0)
        var dLng = CLLocationCoordinate2D.transform_earth_from_mars_lng(lng - 105.0, lat - 35.0)
        let radLat = lat / 180.0 * .pi
        var magic = sin(radLat)
        magic = 1 - ee * magic * magic
        let sqrtMagic:Double = sqrt(magic)
        dLat = (dLat * 180.0) / ((a * (1 - ee)) / (magic * sqrtMagic) * .pi)
        dLng = (dLng * 180.0) / (a / sqrtMagic * cos(radLat) * .pi)
        return (dLat,dLng)
    }
    
    private static func transform_earth_from_mars_lat(_ x: Double,_ y: Double) -> Double {
        var ret: Double = -100.0 + 2.0 * x + 3.0 * y + 0.2 * y * y + 0.1 * x * y + 0.2 * sqrt(fabs(x))
        ret += (20.0 * sin(6.0 * x * .pi) + 20.0 * sin(2.0 * x * .pi)) * 2.0 / 3.0
        ret += (20.0 * sin(y * .pi) + 40.0 * sin(y / 3.0 * .pi)) * 2.0 / 3.0
        ret += (160.0 * sin(y / 12.0 * .pi) + 320 * sin(y * .pi / 30.0)) * 2.0 / 3.0
        return ret
    }
    
    private static func transform_earth_from_mars_lng(_ x: Double,_ y: Double) -> Double {
        var ret: Double = 300.0 + x + 2.0 * y + 0.1 * x * x + 0.1 * x * y + 0.1 * sqrt(fabs(x))
        ret += (20.0 * sin(6.0 * x * .pi) + 20.0 * sin(2.0 * x * .pi)) * 2.0 / 3.0
        ret += (20.0 * sin(x * .pi) + 40.0 * sin(x / 3.0 * .pi)) * 2.0 / 3.0
        ret += (150.0 * sin(x / 12.0 * .pi) + 300.0 * sin(x / 30.0 * .pi)) * 2.0 / 3.0
        return ret
    }
    
    private static func transform_mars_from_baidu(lat: Double, lng: Double) -> (Double,Double) {
        let x = lng , y = lat
        let z = sqrt(x * x + y * y) + 0.00002 * sin(y * x_pi)
        let theta = atan2(y, x) + 0.000003 * cos(x * x_pi)
        return (z * sin(theta) + 0.006, z * cos(theta) + 0.0065)
    }
    
    private static func transform_baidu_from_mars(lat: Double, lng: Double) -> (Double,Double) {
        let x = lng - 0.0065 , y = lat - 0.006
        let z =  sqrt(x * x + y * y) - 0.00002 * sin(y * x_pi)
        let theta = atan2(y, x) - 0.000003 * cos(x * x_pi)
        return (z * sin(theta), z * cos(theta))
    }
    
    private static func transform_sino_out_china(lat: Double, lng: Double) -> Bool {
        if (lng < 72.004 || lng > 137.8347) {
            return true
        }
        if (lat < 0.8293 || lat > 55.8271) {
            return true
        }
        return false
    }
}
