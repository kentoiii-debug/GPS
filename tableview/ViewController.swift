//
//  ViewController.swift
//  tableview
//
//  Created by ssp on 2019/10/24.
//  Copyright © 2019 ssp. All rights reserved.
//

import UIKit
import CoreBluetooth

//GPSアプリ用
import MapKit
import CoreLocation

class ViewController: UIViewController,UIApplicationDelegate, CBCentralManagerDelegate, CBPeripheralDelegate, UIPickerViewDelegate, UIPickerViewDataSource, CLLocationManagerDelegate {
    
    
    //以下GPSアプリ関連
    
    //MkMapViewの変数を定義する
       @IBOutlet var mapView: MKMapView!
       
       //CLLocationManagerのメンバ変数を定義する
       var locManager: CLLocationManager!
       

       
       // 2点間の距離(m)を算出する
       func calcDistance(_ a: CLLocationCoordinate2D, _ b: CLLocationCoordinate2D) -> CLLocationDistance {
           // CLLocationオブジェクトを生成
           let aLoc: CLLocation = CLLocation(latitude: a.latitude, longitude: a.longitude)
           let bLoc: CLLocation = CLLocation(latitude: b.latitude, longitude: b.longitude)
           // CLLocationオブジェクトのdistanceで2点間の距離(m)を算出
           let dist = bLoc.distance(from: aLoc)
           return dist
       }
    
    //地図の初期化関数
       func initMap(){
           
           //縮尺を設定
           var region:MKCoordinateRegion = mapView.region
           region.span.latitudeDelta = 0.02
           region.span.longitudeDelta = 0.02
           mapView.setRegion(region,animated:true)
           
           // 現在位置表示の有効化
           mapView.showsUserLocation = true
           // 現在位置設定（デバイスの動きとしてこの時の一回だけ中心位置が現在位置で更新される）
           mapView.userTrackingMode = .follow
           
       }
    
    //タッチダウンした時にCallする関数 @ついているとストーリーボードで参照できる
    @IBAction func trackingBtnThouchDown(_ sender: AnyObject) {
        
        switch mapView.userTrackingMode {
           
           case .followWithHeading:
               mapView.userTrackingMode = .follow
               break
           default:
               mapView.userTrackingMode = .followWithHeading
               break
           }
        
        print("tracking Button Thouch Down!")
    }
    

    //var i :Int
    var i = 9
    var backConst = 1
    
    
        
    //let iValue = Int.random(in: 1 ... 5)
    
    
    //現在情報位置を受信する
       //delegate設定すると位置が変化する度に関数がCallさwwれるオーバーライドみたいな仕組み
       func locationManager(_ manager: CLLocationManager, didUpdateLocations locations:[CLLocation]){
           
           // 自分の移動速度（秒速）を少数第2位の時速に変換
           let speed: Double = floor((locations.last!.speed * 3.6)*100)/100
           
           print("速度" ,speed ,"m/s")
           
           
       
           let annotation = MKPointAnnotation()
                  
                  annotation.coordinate = CLLocationCoordinate2DMake(35.662230,139.704380)
        
        //　順方向　35.617696, 139.776177
        // 　逆方向　35.619724,139.774525
        // 雨天の場合　35.619820,139.776681
        //　渋谷ver 35.662857,139.704937
        
                  
                  mapView.addAnnotation(annotation)
           
                   
           
           
                  
       //自分と目的地の距離を算出
                  let distance = calcDistance(mapView.userLocation.coordinate, annotation.coordinate)
                  print("distance : " + distance.description)
                  print("軽度、緯度",mapView.userLocation.coordinate)
        
        var distance2: Double = atof(distance.description)
        print("カウント値i",i)
        
        let iValue = Int.random(in: 1 ... 2)
        
        print("ランダム値",iValue)
               
       
        
        
        
    //フェーズ１ 30>x>15 7秒に１回　強度No7 同時振動1個
            if(distance2 < 30 && distance2 > 15){
                   
                  
                        
                        i = i + 1
                        //sleep(5);
                        if (i % 7 == 0){
                        print("フェーズ１　30>x>15 7秒に１回　強度No7 同時振動1個")
                        //phazeFlow(ill: iValue, kyoudo: 0x7 )
                        phazeFlowKosu(ill: iValue, kyoudo: 0x7)
                            
                        }
                    }
                
    //フェーズ2　15>x>7 3秒に１回　強度No6 同時振動2個
            else if(distance2 < 15 && distance2 > 7) {
                            
                         i = i + 1
                            
                        if (i % 3 == 0){
                            
                             print("フェーズ2　15>x>7 3秒に１回　強度No6 同時振動2個")
                            //複数振動
                            //phazeFlow(ill: iValue, kyoudo: 0x6)
                            phazeFlowKosu(ill: iValue, kyoudo: 0x6)
                            }
                            
                        //sendMessage_unit(GID: 0x6,NID:0x7,SID:g_sid,VEL:g_sint,LID:g_led)
                        //sleep(3);
                        //phaze2()
                }
                    
            
     
      //フェーズ3 7>x>4 3秒に１回　強度No5 同時振動4個
            else if (distance2 < 7 && distance2 > 4){
                            
                            i = i + 1
                                                           
                            if (i % 3 == 0){
                                
                                    print("フェーズ3 7>x>4 3秒に１回　強度No5 同時振動4個")
                                    //複数振動
                                    //phazeFlow(ill: iValue, kyoudo: 0x5)
                                    phazeFlowKosu(ill: iValue, kyoudo: 0x5)
                                }
                                
                
            }
            
                    
             
     //フェーズ4 4>x>2 1秒に１回　強度No4 同時振動8個
            else if (distance2 < 4 && distance2 > 2){
                                         
                            i = i + 1
                                                                    
                            if (i % 1 == 0){
                                                  
                            print("フェーズ4 4>x>2 1秒に１回　強度No4 同時振動8個")
                            //複数振動
                            //phazeFlow(ill: iValue, kyoudo: 0x4)
                            phazeFlowKosu(ill: iValue, kyoudo: 0x4)
                                         }
                                         
                                  
            }
                    
                     
                                     
                            
                                
                                
                            /*
                            else if (distance2 < 10 && distance2 > 5 && backConst == 1 ){
                                i = i + 1
                                //sendMessage_unit(GID: 0x6,NID:0x7,SID:g_sid,VEL:g_sint,LID:g_led)
                                //sendMessage_unit(GID: 0xE,NID:0x7,SID:g_sid,VEL:g_sint,LID:g_led)
                                if(i % 1 == 0 ){
                                print("2以上4未満")
                                //sleep(1);
                                //phaze1(ill : iValue)
                                //phaze2(ill : iValue)
                                //phazeFlow(ill : iValue)
                                sendMessage_unit(GID: 0x5,NID:0x3,SID:g_sid,VEL:g_sint,LID:g_led)
                                
                                }
                            }
                           
                                
                            else if (distance2 < 10 && distance2 > 5 && backConst >= 2 ){
                                i = i + 1
                                //sendMessage_unit(GID: 0x6,NID:0x7,SID:g_sid,VEL:g_sint,LID:g_led)
                                //sendMessage_unit(GID: 0xE,NID:0x7,SID:g_sid,VEL:g_sint,LID:g_led)
                                if(i % 3 == 0 ){
                                print("10以上20未満")
                                //sleep(1);
                                //phaze1(ill : iValue)
                                //phaze2(ill : iValue)
                                //phaze3(ill : iValue)
                                //phazeFlow(ill : iValue)
                                sendMessage_unit(GID: 0x5,NID:0x3,SID:g_sid,VEL:g_sint,LID:g_led)
                                
                                
                                }
                            }
                            
                             
 
                            else if (distance2 < 5 && distance2 > 3 && backConst == 1){
                                print("静まりフェーズ")
                            }
                                
                            else if (distance2 < 5 && distance2 > 3 && backConst <= 2){
                                 i = i + 1
                                 if(i % 2 == 0 ){
                                    
                                 //phaze3(ill : iValue)
                                 //phazeFlow(ill : iValue)
                                 sendMessage_unit(GID: 0x5,NID:0x3,SID:g_sid,VEL:g_sint,LID:g_led)
                                 
                                 }
                            }
                            */
                            
     //フェーズ5 2>x 1秒に１回　強度No3 同時振動16個
        else if (distance2 < 2) {
                    i = i + 1
                                
                    if(i % 1 == 0){
                                    
                    print("フェーズ5 2>x 1秒に１回　強度No3 同時振動16個")
                                
                    phaze4()
                    backConst = backConst + 1
                  
                    //phazeFlow(ill: iValue, kyoudo: 0x3)
                    phazeFlowKosu(ill: iValue, kyoudo: 0x3)
                                }
                }
                            
                
                        
                
        
        
                                
                            
                                
                        
                        
                        
                
  

                    
                    
               
               
 
           
       
           
           //HeadingUpであれば、HeadingUp, FollowであればFollowで現在位置を更新する。
           switch mapView.userTrackingMode {
               case .followWithHeading:
                   mapView.userTrackingMode = .followWithHeading
                   break
           
               default:
                   mapView.userTrackingMode = .follow
                   break
               
               
               
          }
         
           
       }
    
    
    
    
    
    
    
    
    //以下シナスタジア関連
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataList.count
    }
        //pickerに表示する値を返すデリゲートメソッド.
    internal func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
           return dataList[row]
        /*let label = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 50))
        label.textAlignment = .center
        label.text = dataList[row]
        label.font = UIFont(name: dataList[row],size:6)
        return label*/
    }
    
    // pickerが選択された際に呼ばれるデリゲートメソッド.
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
           lable_sid.text = dataList[row]
        g_sid = UInt8(lable_sid.text!)!
    }
    
    
    
    
   @IBOutlet weak var tableView: UITableView!
   var cb_manager: CBCentralManager!
    var peripherals: [CBPeripheral] = []
    var cbPeripheral: CBPeripheral? = nil
    var connectPeripheral: CBPeripheral? = nil
    var writeCharacteristic: CBCharacteristic? = nil
    var g_sid: UInt8 = 0x5
    var g_sint: UInt8 = 0x5
    var g_led: UInt8 = 0x3B
    @IBOutlet weak var SID_INT_LABEL: UILabel!
    
    @IBOutlet weak var LED_ID: UILabel!
    
    var img1_b = UIImage(named:"背面")!
    var img1_f = UIImage(named:"前面")!
    @IBOutlet weak var soundID_picker: UIPickerView!
    
    @IBOutlet weak var lable_sid: UILabel!
    @IBOutlet weak var SoundID: UITextField!
    
    
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    
    
    @IBOutlet weak var BT6_8: UIButton!
    @IBOutlet weak var BT6_7: UIButton!
    @IBOutlet weak var BT6_6: UIButton!
    @IBOutlet weak var BT1_2: UIButton!
    
    @IBOutlet weak var BTC_1: UIButton!
    @IBOutlet weak var BT6_2: UIButton!
    @IBOutlet weak var BT6_3: UIButton!
    @IBOutlet weak var BT6_4: UIButton!
    @IBOutlet weak var BT4_1: UIButton!
    
    @IBOutlet weak var BT4_4: UIButton!
    @IBOutlet weak var BTE_2: UIButton!
    @IBOutlet weak var BTE_6: UIButton!
    @IBOutlet weak var BTE_7: UIButton!
    @IBOutlet weak var BTB_9: UIButton!
    
    @IBOutlet weak var BT3_8: UIButton!
    @IBOutlet weak var BTE_3: UIButton!
    @IBOutlet weak var BT4_5: UIButton!
    @IBOutlet weak var BT1_1: UIButton!
    //付け加え
    @IBOutlet weak var BT4_5A: UIButton!
    @IBOutlet weak var BT1_1A: UIButton!
    
    
    @IBOutlet weak var BT9_1: UIButton!
    @IBOutlet weak var BT9_4: UIButton!
    @IBOutlet weak var BT1_4: UIButton!
    //付け加え
    @IBOutlet weak var BT9_1A: UIButton!
    @IBOutlet weak var BT9_4A: UIButton!
    
    
    @IBOutlet weak var BT4_2: UIButton!
    @IBOutlet weak var BT6_5: UIButton!
    @IBOutlet weak var BT5_3: UIButton!
    @IBOutlet weak var BT4_2A: UIButton!
    //付け加え
    @IBOutlet weak var BT5_3A: UIButton!
    
    
    
    @IBOutlet weak var BTD_1: UIButton!
    @IBOutlet weak var BTD_4: UIButton!
    @IBOutlet weak var BTC_3: UIButton!
    
    //付け加え
    @IBOutlet weak var BTD_4A: UIButton!
    
    @IBOutlet weak var BTE_4: UIButton!
    
    @IBOutlet weak var BT3_9: UIButton!
    
    @IBOutlet weak var BT5_2: UIButton!
    
    //付け加え
    @IBOutlet weak var BT5_2A: UIButton!
    
    
    var isInButtonB = false;
    
   let dataList = [
        "1","2","3","4",
        "5","6","7","8",
        "9","10","11","12",
        "13","14",
        "15","16","17","18",
        "19","20","21","22",
        "23","24",
        "25","26","27","28",
        "29","30","31","32",
        "33","34",
        "35","36","37","38",
        "39","40","41","42",
        "43","44",
        "45","46","47","48",
        "49","50","51","52",
        "53","54",
        "55","56","57","58",
        "59","60","255"

    
    ]
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
       cb_manager.scanForPeripherals(withServices: nil, options: nil)
        print("state \(central.state)");
        //TODO.append("state")
        //tableView.reloadData()

    }
    
    
    @IBAction func testbt(_ sender: UIPanGestureRecognizer) {
        
        if BT6_6.frame.contains(sender.location(in: self.view)) {
                if !isInButtonB { // ←ButtonBの外側からドラッグしてきた場合のみ
                    print("Button6_6のに触れたら処理実行")
                    //sendMessage_unit(GID: 0xA,NID:0x1,SID:g_sid,VEL:g_sint,LID:g_led)
                    sendMessage_unit(GID: 0xC,NID:0x2,SID:g_sid,VEL:g_sint,LID:g_led)
                }
                isInButtonB = true

        }
        else if BT6_8.frame.contains(sender.location(in: self.view)) {
                if !isInButtonB { // ←ButtonBの外側からドラッグしてきた場合のみ
                       print("Button2_1のに触れたら処理実行")
                    sendMessage_unit(GID: 0x4,NID:0x3,SID:0xFF,VEL:g_sint,LID:0x3B)
                }
                isInButtonB = true

        }
        /*
        else if BT4_2A.frame.contains(sender.location(in: self.view)) {
                if !isInButtonB { // ←ButtonBの外側からドラッグしてきた場合のみ
                        print("Button2_1のに触れたら処理実行")
                    sendMessage_unit(GID: 0x4,NID:0x2,SID:0xFF,VEL:g_sint,LID:0x3B)
                }
                isInButtonB = true

        }
       
            
        else if BT4_5A.frame.contains(sender.location(in: self.view)) {
                       if !isInButtonB { // ←ButtonBの外側からドラッグしてきた場合のみ
                               print("Button2_1のに触れたら処理実行")
                           sendMessage_unit(GID: 0x4,NID:0x5,SID:0xFF,VEL:g_sint,LID:0x3B)
                       }
                       isInButtonB = true

        }
            
        else if BT5_3A.frame.contains(sender.location(in: self.view)) {
                       if !isInButtonB { // ←ButtonBの外側からドラッグしてきた場合のみ
                               print("Button2_1のに触れたら処理実行")
                           sendMessage_unit(GID: 0x5,NID:0x3,SID:0xFF,VEL:g_sint,LID:0x3B)
                       }
                       isInButtonB = true

        }
            
        else if BT9_1A.frame.contains(sender.location(in: self.view)) {
                           if !isInButtonB { // ←ButtonBの外側からドラッグしてきた場合のみ
                                   print("Button2_1のに触れたら処理実行")
                               sendMessage_unit(GID: 0x9,NID:0x1,SID:0xFF,VEL:g_sint,LID:0x3B)
                           }
                           isInButtonB = true

        }
            
        else if BT9_4A.frame.contains(sender.location(in: self.view)) {
                                  if !isInButtonB { // ←ButtonBの外側からドラッグしてきた場合のみ
                                          print("Button2_1のに触れたら処理実行")
                                      sendMessage_unit(GID: 0x9,NID:0x4,SID:0xFF,VEL:g_sint,LID:0x3B)
                                  }
                                  isInButtonB = true

        }
            
        else if BTD_4A.frame.contains(sender.location(in: self.view)) {
                                         if !isInButtonB { // ←ButtonBの外側からドラッグしてきた場合のみ
                                                 print("Button2_1のに触れたら処理実行")
                                             sendMessage_unit(GID: 0xD,NID:0x4,SID:0xFF,VEL:g_sint,LID:0x3B)
                                         }
                                         isInButtonB = true

               }
            
        else if BT5_2A.frame.contains(sender.location(in: self.view)) {
                                                if !isInButtonB { // ←ButtonBの外側からドラッグしてきた場合のみ
                                                        print("Button2_1のに触れたら処理実行")
                                                    sendMessage_unit(GID: 0x5,NID:0x2,SID:0xFF,VEL:g_sint,LID:0x3B)
                                                }
                                                isInButtonB = true

        }
            
        else if BT1_1A.frame.contains(sender.location(in: self.view)) {
                                                       if !isInButtonB { // ←ButtonBの外側からドラッグしてきた場合のみ
                                                               print("Button2_1のに触れたら処理実行")
                                                           sendMessage_unit(GID: 0x1,NID:0x1,SID:0xFF,VEL:g_sint,LID:0x3B)
                                                       }
                                                       isInButtonB = true

        }
 
        */
        
            
        
        else if BT6_7.frame.contains(sender.location(in: self.view)) {
                if !isInButtonB { // ←ButtonBの外側からドラッグしてきた場合のみ
                        print("ButtonC_5のに触れたら処理実行")
                    sendMessage_unit(GID: 0xC,NID:0x5,SID:g_sid,VEL:g_sint,LID:0x3B)
                }
                isInButtonB = true

        }
        else if BT1_2.frame.contains(sender.location(in: self.view)) {
                if !isInButtonB { // ←ButtonBの外側からドラッグしてきた場合のみ
                        print("Button1_2のに触れたら処理実行")
                    //sendMessage_unit(GID: 0x7,NID:0x1,SID:g_sid,VEL:g_sint,LID:g_led)
                    sendMessage_unit(GID: 0xD,NID:0x1,SID:g_sid,VEL:g_sint,LID:g_led)
                }
                    isInButtonB = true

        }
        
        else if BTC_1.frame.contains(sender.location(in: self.view)) {
                if !isInButtonB { // ←ButtonBの外側からドラッグしてきた場合のみ
                        print("Buttonc_4のに触れたら処理実行")
                    sendMessage_unit(GID: 0xC,NID:0x4,SID:g_sid,VEL:g_sint,LID:0x3B)
                }
                isInButtonB = true

        }
  
        else if BT3_8.frame.contains(sender.location(in: self.view)) {
                if !isInButtonB { // ←ButtonBの外側からドラッグしてきた場合のみ
                        print("Button5_1のに触れたら処理実行")
                    sendMessage_unit(GID: 0x5,NID:0x1,SID:g_sid,VEL:g_sint,LID:g_led)
                }
                    isInButtonB = true

        }
        else if BT4_1.frame.contains(sender.location(in: self.view)) {
                if !isInButtonB { // ←ButtonBの外側からドラッグしてきた場合のみ
                        print("Button3_9のに触れたら処理実行")
                    sendMessage_unit(GID: 0x4,NID:0x1,SID:g_sid,VEL:g_sint,LID:g_led)
                }
                    isInButtonB = true

        }
        else if BT6_2.frame.contains(sender.location(in: self.view)) {
                if !isInButtonB { // ←ButtonBの外側からドラッグしてきた場合のみ
                        print("Button3_9のに触れたら処理実行")
                    sendMessage_unit(GID: 0x4,NID:0x2,SID:g_sid,VEL:g_sint,LID:g_led)
                }
                    isInButtonB = true

        }
        else if BT6_4.frame.contains(sender.location(in: self.view)) {
                if !isInButtonB { // ←ButtonBの外側からドラッグしてきた場合のみ
                        print("Button6_4のに触れたら処理実行")
                    sendMessage_unit(GID: 0x6,NID:0x4,SID:g_sid,VEL:g_sint,LID:g_led)
                    }
                    isInButtonB = true

        }
//
         
            
        else if BT4_4.frame.contains(sender.location(in: self.view)) {
                if !isInButtonB { // ←ButtonBの外側からドラッグしてきた場合のみ
                        print("Button4_4のに触れたら処理実行")
                    sendMessage_unit(GID: 0x4,NID:0x4,SID:g_sid,VEL:g_sint,LID:g_led)
                }
                    isInButtonB = true

        }
        else if BTE_6.frame.contains(sender.location(in: self.view)) {
                if !isInButtonB { // ←ButtonBの外側からドラッグしてきた場合のみ
                        print("ButtonE_6のに触れたら処理実行")
                    sendMessage_unit(GID: 0xD,NID:0x4,SID:g_sid,VEL:g_sint,LID:g_led)
                }
                    isInButtonB = true

        }
        else if BTB_9.frame.contains(sender.location(in: self.view)) {
                if !isInButtonB { // ←ButtonBの外側からドラッグしてきた場合のみ
                        print("ButtonB_9のに触れたら処理実行")
                    sendMessage_unit(GID: 0xD,NID:0x5,SID:g_sid,VEL:g_sint,LID:g_led)
                }
                    isInButtonB = true

        }
        else if BT3_8.frame.contains(sender.location(in: self.view)) {
                if !isInButtonB { // ←ButtonBの外側からドラッグしてきた場合のみ
                        print("ButtonA_1のに触れたら処理実行")
                    sendMessage_unit(GID: 0x3,NID:0x8,SID:g_sid,VEL:g_sint,LID:g_led)
                }
                    isInButtonB = true

        }
        else if BT4_5.frame.contains(sender.location(in: self.view)) {
                if !isInButtonB { // ←ButtonBの外側からドラッグしてきた場合のみ
                        print("ButtonD_3のに触れたら処理実行")
                     sendMessage_unit(GID: 0x1,NID:0x1,SID:g_sid,VEL:g_sint,LID:g_led)
                }
                    isInButtonB = true

        }
        else if BTE_2.frame.contains(sender.location(in: self.view)) {
                if !isInButtonB { // ←ButtonBの外側からドラッグしてきた場合のみ
                        print("ButtonA_6のに触れたら処理実行")
                         sendMessage_unit(GID: 0xE,NID:0x2,SID:g_sid,VEL:g_sint,LID:g_led)
                    }
                        isInButtonB = true

            }
        else if BTE_7.frame.contains(sender.location(in: self.view)) {
            if !isInButtonB { // ←ButtonBの外側からドラッグしてきた場合のみ
                    print("ButtonA_6のに触れたら処理実行")
                        sendMessage_unit(GID: 0xE,NID:0x7,SID:g_sid,VEL:g_sint,LID:g_led)
                }
                        isInButtonB = true

        }
        else if BTE_3.frame.contains(sender.location(in: self.view)) {
            if !isInButtonB { // ←ButtonBの外側からドラッグしてきた場合のみ
                print("ButtonA_6のに触れたら処理実行")
                    sendMessage_unit(GID: 0x5,NID:0x3,SID:g_sid,VEL:g_sint,LID:g_led)
            }
                    isInButtonB = true

        }
        else if BT1_1.frame.contains(sender.location(in: self.view)) {
                if !isInButtonB { // ←ButtonBの外側からドラッグしてきた場合のみ
                print("Button1_1のに触れたら処理実行")
                    sendMessage_unit(GID: 0x5,NID:0x4,SID:g_sid,VEL:g_sint,LID:g_led)
                }
                    isInButtonB = true

        }
            
            
        else if BT9_1.frame.contains(sender.location(in: self.view)) {
                    if !isInButtonB { // ←ButtonBの外側からドラッグしてきた場合のみ
                            print("ButtonC_1のに触れたら処理実行")
                        sendMessage_unit(GID: 0x4,NID:0x5,SID:g_sid,VEL:g_sint,LID:g_led)
                    }
                        isInButtonB = true

        }
        else if BT9_4.frame.contains(sender.location(in: self.view)) {
                if !isInButtonB { // ←ButtonBの外側からドラッグしてきた場合のみ
                        print("Button1_5のに触れたら処理実行")
                    sendMessage_unit(GID: 0x1,NID:0x5,SID:g_sid,VEL:g_sint,LID:g_led)
                }
                    isInButtonB = true

        }
        else if BT1_4.frame.contains(sender.location(in: self.view)) {
                if !isInButtonB { // ←ButtonBの外側からドラッグしてきた場合のみ
                        print("ButtonE_8のに触れたら処理実行")
                    sendMessage_unit(GID: 0x1,NID:0x4,SID:g_sid,VEL:g_sint,LID:g_led)
                }
                    isInButtonB = true

        }
        else if BTD_1.frame.contains(sender.location(in: self.view)) {
                if !isInButtonB { // ←ButtonBの外側からドラッグしてきた場合のみ
                        print("Button6_1のに触れたら処理実行")
                    sendMessage_unit(GID: 0x9,NID:0x1,SID:g_sid,VEL:g_sint,LID:g_led)
                }
                    isInButtonB = true

        }
        else if BTD_4.frame.contains(sender.location(in: self.view)) {
                if !isInButtonB { // ←ButtonBの外側からドラッグしてきた場合のみ
                        print("ButtonD_4のに触れたら処理実行")
                    sendMessage_unit(GID: 0xC,NID:0x1,SID:g_sid,VEL:g_sint,LID:g_led)
                }
                    isInButtonB = true

        }
        else if BTC_3.frame.contains(sender.location(in: self.view)) {
                if !isInButtonB { // ←ButtonBの外側からドラッグしてきた場合のみ
                        print("Button6_8のに触れたら処理実行")
                    sendMessage_unit(GID: 0xC,NID:0x3,SID:g_sid,VEL:g_sint,LID:g_led)
                }
                    isInButtonB = true

        }
        else if BT4_2.frame.contains(sender.location(in: self.view)) {
                if !isInButtonB { // ←ButtonBの外側からドラッグしてきた場合のみ
                        print("Button6_7のに触れたら処理実行")
                    sendMessage_unit(GID: 0x6,NID:0x7,SID:g_sid,VEL:g_sint,LID:g_led)
                }
                    isInButtonB = true

        }
        else if BT6_5.frame.contains(sender.location(in: self.view)) {
                    if !isInButtonB { // ←ButtonBの外側からドラッグしてきた場合のみ
                            print("Button6_8のに触れたら処理実行")
                        sendMessage_unit(GID: 0x5,NID:0x3,SID:g_sid,VEL:g_sint,LID:g_led)
                    }
                        isInButtonB = true

            }
            else if BT5_3.frame.contains(sender.location(in: self.view)) {
                               if !isInButtonB { // ←ButtonBの外側からドラッグしてきた場合のみ
                                       print("Button6_8のに触れたら処理実行")
                                   sendMessage_unit(GID: 0x9,NID:0x4,SID:g_sid,VEL:g_sint,LID:g_led)
                               }
                                   isInButtonB = true

                       }
            else if BTE_4.frame.contains(sender.location(in: self.view)) {
                    if !isInButtonB { // ←ButtonBの外側からドラッグしてきた場合のみ
                            print("Button6_8のに触れたら処理実行")
                        sendMessage_unit(GID: 0xE,NID:0x4,SID:g_sid,VEL:g_sint,LID:g_led)
                    }
                        isInButtonB = true

            }
            else if BT3_9.frame.contains(sender.location(in: self.view)) {
                    if !isInButtonB { // ←ButtonBの外側からドラッグしてきた場合のみ
                            print("Button6_8のに触れたら処理実行")
                        sendMessage_unit(GID: 0x6,NID:0x6,SID:g_sid,VEL:g_sint,LID:g_led)
                    }
                        isInButtonB = true

            }
            else if BT5_2.frame.contains(sender.location(in: self.view)) {
                    if !isInButtonB { // ←ButtonBの外側からドラッグしてきた場合のみ
                            print("Button9_2のに触れたら処理実行")
                        sendMessage_unit(GID: 0x9,NID:0x5,SID:g_sid,VEL:g_sint,LID:g_led)
                    }
                        isInButtonB = true

            }
            else if BT6_3.frame.contains(sender.location(in: self.view)) {
                    if !isInButtonB { // ←ButtonBの外側からドラッグしてきた場合のみ
                            print("Button6_8のに触れたら処理実行")
                        sendMessage_unit(GID: 0x6,NID:0x3,SID:g_sid,VEL:g_sint,LID:g_led)
                    }
                        isInButtonB = true

            }
        else { // ButtonBの内側でドラッグしても何もしない
                          isInButtonB = false
                      }
    }
    @IBAction func BT接続(_ sender: Any) {
        
        scanStart()
              //          sendMessage(message: "f2ffff003a")
    }
    
    
    @IBAction func change_slider(_ sender: UISlider) {
        let slidervalue:Int = Int(sender.value)
        SID_INT_LABEL.text = String(slidervalue)
        g_sint = UInt8(slidervalue)
        
    }
    
    @IBAction func change_slider_led(_ sender: UISlider) {
        
        let slidervalue:Int = Int(sender.value)
        LED_ID.text = String(slidervalue)
        g_led = UInt8(slidervalue)
        
    }
    
    @IBAction func Button1(_ sender: Any) {
        //TODO.append("state")
        tableView.reloadData()
    }
    
    @IBAction func segment1(_ sender: Any) {
        
        switch (sender as AnyObject).selectedSegmentIndex {
        case 0:
             g_sid = 27
             sendMessage_unit(GID: 0x1,NID:0x2,SID:g_sid,VEL:g_sint,LID:g_led)
             
             usleep(20);
             
             sendMessage_unit(GID: 0xE,NID:0x3,SID:g_sid,VEL:g_sint,LID:g_led)
             //g_sid = 0x5
             
         case 1:
              g_sid = 27
              sendMessage_unit(GID: 0x4,NID:0x1,SID:g_sid,VEL:g_sint,LID:g_led)
                         
              usleep(20);
                         
              sendMessage_unit(GID: 0x5,NID:0x1,SID:g_sid,VEL:g_sint,LID:g_led)
         case 2:
             g_sid = 27
             sendMessage_unit(GID: 0x1,NID:0x5,SID:g_sid,VEL:g_sint,LID:g_led)
             
             usleep(20);
             
             sendMessage_unit(GID: 0xE,NID:0x7,SID:g_sid,VEL:g_sint,LID:g_led)
            
        case 3:
            g_sid = 27
                
            sendMessage_unit(GID: 0x6,NID:0x2,SID:g_sid,VEL:g_sint,LID:g_led)
                
            usleep(20);
                
            sendMessage_unit(GID: 0x6,NID:0x4,SID:g_sid,VEL:g_sint,LID:g_led)
          
        default:
            print("")
        
        
        }
    }
    
    @IBAction func seg_sid(_ sender: Any) {
        switch (sender as AnyObject).selectedSegmentIndex {
        case 0:
             g_sid = 8
             g_sint = 5
             
              sendMessage_unit(GID: 0xC,NID:0x2,SID:g_sid,VEL:g_sint,LID:g_led)
                
                usleep(500);
                
                sendMessage_unit(GID: 0xC,NID:0x5,SID:g_sid,VEL:g_sint,LID:g_led)
               
               usleep(500);
               
               sendMessage_unit(GID: 0xC,NID:0x4,SID:g_sid,VEL:g_sint,LID:g_led)

              usleep(500);
              
              sendMessage_unit(GID: 0x4,NID:0x1,SID:g_sid,VEL:g_sint,LID:g_led)
              
             usleep(500);
             
             sendMessage_unit(GID: 0x6,NID:0x7,SID:g_sid,VEL:g_sint,LID:g_led)
              
             usleep(500);
         
             sendMessage_unit(GID: 0x4,NID:0x4,SID:g_sid,VEL:g_sint,LID:g_led)
                
                usleep(500);
                
                sendMessage_unit(GID: 0xD,NID:0x3,SID:g_sid,VEL:g_sint,LID:g_led)
               
               usleep(500);
               
               sendMessage_unit(GID: 0xD,NID:0x1,SID:g_sid,VEL:g_sint,LID:g_led)

              usleep(500);
              
              sendMessage_unit(GID: 0xD,NID:0x5,SID:g_sid,VEL:g_sint,LID:g_led)
              
             usleep(500);
             
             sendMessage_unit(GID: 0x5,NID:0x1,SID:g_sid,VEL:g_sint,LID:g_led)
             usleep(500);
             
             sendMessage_unit(GID: 0x5,NID:0x4,SID:g_sid,VEL:g_sint,LID:g_led)
             
            usleep(500);
            
            sendMessage_unit(GID: 0xE,NID:0x2,SID:g_sid,VEL:g_sint,LID:g_led)
              
          case 1:
             g_sid = 46
             g_sint = 0
                 sendMessage_unit(GID: 0x4,NID:0x4,SID:g_sid,VEL:g_sint,LID:g_led)
                
                usleep(100);
                
                sendMessage_unit(GID: 0xE,NID:0x2,SID:g_sid,VEL:g_sint,LID:g_led)
               
               usleep(100);
               
               sendMessage_unit(GID: 0x6,NID:0x7,SID:g_sid,VEL:g_sint,LID:g_led)

              usleep(100);
             sendMessage_unit(GID: 0x5,NID:0x4,SID:g_sid,VEL:g_sint,LID:g_led)
               
               usleep(100);
               
               sendMessage_unit(GID: 0x4,NID:0x1,SID:g_sid,VEL:g_sint,LID:g_led)
              
              usleep(100);
              
              sendMessage_unit(GID: 0x5,NID:0x1,SID:g_sid,VEL:g_sint,LID:g_led)

             usleep(300);
             
                 sendMessage_unit(GID: 0x4,NID:0x1,SID:g_sid,VEL:g_sint,LID:g_led)
                
                usleep(100);
                
                sendMessage_unit(GID: 0x5,NID:0x1,SID:g_sid,VEL:g_sint,LID:g_led)
               
               usleep(100);
               
               sendMessage_unit(GID: 0x6,NID:0x7,SID:g_sid,VEL:g_sint,LID:g_led)

              usleep(100);
             sendMessage_unit(GID: 0x5,NID:0x4,SID:g_sid,VEL:g_sint,LID:g_led)
               
               usleep(100);
               
               sendMessage_unit(GID: 0x4,NID:0x4,SID:g_sid,VEL:g_sint,LID:g_led)
              
              usleep(100);
              
              sendMessage_unit(GID: 0xE,NID:0x2,SID:g_sid,VEL:g_sint,LID:g_led)

             usleep(300);
             
             
                 sendMessage_unit(GID: 0x4,NID:0x4,SID:g_sid,VEL:g_sint,LID:g_led)
                
                usleep(100);
                
                sendMessage_unit(GID: 0xE,NID:0x2,SID:g_sid,VEL:g_sint,LID:g_led)
               
               usleep(100);
               
               sendMessage_unit(GID: 0x6,NID:0x7,SID:g_sid,VEL:g_sint,LID:g_led)

              usleep(100);
             sendMessage_unit(GID: 0x5,NID:0x4,SID:g_sid,VEL:g_sint,LID:g_led)
               
               usleep(100);
               
               sendMessage_unit(GID: 0x4,NID:0x1,SID:g_sid,VEL:g_sint,LID:g_led)
              
              usleep(100);
              
              sendMessage_unit(GID: 0x5,NID:0x1,SID:g_sid,VEL:g_sint,LID:g_led)

             usleep(300);
             
                 sendMessage_unit(GID: 0x4,NID:0x1,SID:g_sid,VEL:g_sint,LID:g_led)
                
                usleep(100);
                
                sendMessage_unit(GID: 0x5,NID:0x1,SID:g_sid,VEL:g_sint,LID:g_led)
               
               usleep(100);
               
               sendMessage_unit(GID: 0x6,NID:0x7,SID:g_sid,VEL:g_sint,LID:g_led)

              usleep(100);
             sendMessage_unit(GID: 0x5,NID:0x4,SID:g_sid,VEL:g_sint,LID:g_led)
               
               usleep(100);
               
               sendMessage_unit(GID: 0x4,NID:0x4,SID:g_sid,VEL:g_sint,LID:g_led)
              
              usleep(100);
              
              sendMessage_unit(GID: 0xE,NID:0x2,SID:g_sid,VEL:g_sint,LID:g_led)


             
          case 2:
             g_sid = 42
             g_sint = 0
             
             sendMessage_unit(GID: 0x1,NID:0x2,SID:g_sid,VEL:g_sint,LID:g_led)
             
             usleep(20);
             
             sendMessage_unit(GID: 0xE,NID:0x3,SID:g_sid,VEL:g_sint,LID:g_led)
             
             usleep(500);
             
             sendMessage_unit(GID: 0x1,NID:0x5,SID:g_sid,VEL:g_sint,LID:g_led)
             
             usleep(20);
             
             sendMessage_unit(GID: 0xE,NID:0x7,SID:g_sid,VEL:g_sint,LID:g_led)
             
             usleep(500);
             
             sendMessage_unit(GID: 0x5,NID:0x1,SID:g_sid,VEL:g_sint,LID:g_led)
             
             usleep(20);
             
             sendMessage_unit(GID: 0x4,NID:0x1,SID:g_sid,VEL:g_sint,LID:g_led)
             usleep(500);
             
             sendMessage_unit(GID: 0x1,NID:0x2,SID:g_sid,VEL:g_sint,LID:g_led)
             
             usleep(20);
             
             sendMessage_unit(GID: 0xE,NID:0x3,SID:g_sid,VEL:g_sint,LID:g_led)
            
         default:
             print("")
        }
    }
    
    @IBAction func test2(_ sender: Any) {
        print("enter")
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //以下GPSアプリ用
        //地図の初期化
        initMap()
        
        //delegateを登録する
        locManager = CLLocationManager()
        locManager.delegate = self
        
        
        // 位置情報の使用の許可を求め、許可されればCLLocationManagerの現在位置更新を開始する
        locManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .authorizedWhenInUse:
                // 座標の表示
                locManager.startUpdatingLocation()
                break
            default:
                break
            }
            
        }
        
        
        
        cb_manager = CBCentralManager(delegate: self, queue: nil)
        
        image1.image = img1_f
        image2.image = img1_b
        
        SID_INT_LABEL.text = "5"

        soundID_picker.delegate = self
        soundID_picker.dataSource = self
        soundID_picker.showsSelectionIndicator = true
        
        //cb_manager.scanForPeripherals(withServices: nil, options: nil)
        
        //scanStart()
        // Do any additional setup after loading the view.
    }
    
    func scanStart() {
        //if manager!.isScanning == false {
            // サービスのUUIDを指定しない
            //cb_manager.scanForPeripherals(withServices: nil, options: nil)
            
            // サービスのUUIDを指定する
        let service = [CBUUID(string: Const.Bluetooth.Service.kUUID)]
        
        cb_manager!.scanForPeripherals(withServices: service, options: nil)
        //}
    }
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        peripherals.append(peripheral)
        print("peripheral \(String(describing: peripheral.name))");
        if peripheral.name != nil && peripheral.name == "Body Sonic Prototype" {
            cbPeripheral = peripheral
            //manager?.stopScan()
            cb_manager.connect(peripheral, options: nil)
            //break;
        }
        else if
        peripheral.name != nil && peripheral.name == "Body Sonic" {
            cbPeripheral = peripheral
            //manager?.stopScan()
            cb_manager.connect(peripheral, options: nil)
            //break;
        }
        
    }
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
           print("接続成功")
           connectPeripheral = peripheral
           connectPeripheral?.delegate = self as? CBPeripheralDelegate
           // 指定のサービスを探索
           if let peripheral = self.connectPeripheral {
               peripheral.discoverServices([CBUUID(string: Const.Bluetooth.Service.kUUID)])
           }
           // スキャン停止処理
           //stopBluetoothScan()
            cb_manager.stopScan()
            //peripheral.discoverServices(nil)//サービス探索を開始する
        //peripheral.discoverCharacteristics(nil, for: connectPeripheral?.services)
    
        
    
       }
    
    /// キャリアクタリスティク発見時に呼ばれる
    /*func peripheral(_ peripheral: CBPeripheral,
                    didDiscoverCharacteristicsFor service: CBService,
                    error: Error?) {

        if error != nil {
            print(error.debugDescription)
            return
        }

        peripheral.setNotifyValue(true,
                                  for: (service.characteristics?.first)!)
    }*/
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        let serviceUUID: CBUUID = CBUUID(string: Const.Bluetooth.Service.kUUID)
        for service in cbPeripheral!.services! {
            if(service.uuid == serviceUUID) {
                cbPeripheral?.discoverCharacteristics(nil, for: service)
             }
        }
    }
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        let serviceUUID: CBUUID = CBUUID(string: Const.Bluetooth.Service.kUUID)
        for characreristic in service.characteristics!{
            if(service.uuid == serviceUUID) {
                //Notificationを受け取るハンドラ
                peripheral.setNotifyValue(true, for: (service.characteristics?.first)!)
            }
            
            if(service.uuid == serviceUUID) {
                writeCharacteristic = characreristic
                sendMessage(message: "f2ffff003a")
            }
        }
        
    }
    
    func peripheral(peripheral: CBPeripheral, didDiscoverServices error: NSError?) {

        if let error = error {
            print("error: \(error)")
            return
        }

        let services = peripheral.services
        print("Found \(String(describing: services?.count)) services! :\(String(describing: services))")
    }
    
    func  sendMessage_unit(GID: UInt8,NID:UInt8,SID:UInt8,VEL:UInt8,LID:UInt8) {
    
        let data1 :UInt8 = GID << 4 | NID
        //let data = command.data(using: String.Encoding.utf8, allowLossyConversion:true)
        
        
        let byteArray: [UInt8] = [ 0xF2, data1, SID, VEL, LID]
        let data = Data(bytes: byteArray)
        //ar value: UInt = 0xF2FFFF003A
        //let data: NSDate = NSDate(bytes: &value,length: 5)
        
        //CBUUID(string: Const.Bluetooth.Service.kUUID)
        
        if writeCharacteristic != nil
        {
                cbPeripheral!.writeValue(data , for: writeCharacteristic!, type: .withResponse)

        }
        else
        {
            print("Couldn't Send")
        }
            
    }
    func  sendMessage(message: String) {
        let command = message
        //let data = command.data(using: String.Encoding.utf8, allowLossyConversion:true)
        let byteArray: [UInt8] = [ 0xF2, 0xFF, 0xFF, 0x00, 0x3A]
        let data = Data(bytes: byteArray)
        //ar value: UInt = 0xF2FFFF003A
        //let data: NSDate = NSDate(bytes: &value,length: 5)
        
        //CBUUID(string: Const.Bluetooth.Service.kUUID)
        
        if writeCharacteristic != nil
        {
                cbPeripheral!.writeValue(data , for: writeCharacteristic!, type: .withResponse)

        }
        else
        {
            print("Couldn't Send")
        }
            
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

      //  return TODO.count
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // セルを取得する
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        // セルに表示する値を設定する
       // cell.textLabel!.text = TODO[indexPath.row]
        print("state");
        return cell
    }

    
 
    
    
    func phaze1_1(ill1 : Int , kyoudo : UInt8){
        
        if (ill1 == 1){
        sendMessage_unit(GID:0xD,NID:0x1,SID:g_sid,VEL:kyoudo,LID:g_led)
        }
        
        else if (ill1 == 2){
        usleep(3000)
        sendMessage_unit(GID: 0xD,NID:0x1,SID:g_sid,VEL:g_sint,LID:g_led)
        }
        
        else if (ill1 == 3){
        usleep(6000)
        sendMessage_unit(GID: 0x9,NID:0x4,SID:g_sid,VEL:g_sint,LID:g_led)
        }
        
        else if (ill1 == 4){
        usleep(9000)
        sendMessage_unit(GID: 0xD,NID:0x4,SID:g_sid,VEL:g_sint,LID:g_led)
        }
        
        else if (ill1 == 5){
        usleep(12000)
        sendMessage_unit(GID: 0x1,NID:0x4,SID:g_sid,VEL:g_sint,LID:g_led)
        }
            
        else if (ill1 == 6){
        usleep(15000)
        sendMessage_unit(GID: 0xC,NID:0x3,SID:g_sid,VEL:g_sint,LID:g_led)
        }
        
        
        else if (ill1 == 7){
        usleep(18000)
        sendMessage_unit(GID: 0xE,NID:0x3,SID:g_sid,VEL:g_sint,LID:g_led)
        }
        
        else if (ill1 == 8){
         usleep(21000)
        sendMessage_unit(GID: 0xD,NID:0x2,SID:g_sid,VEL:g_sint,LID:g_led)
        }
        
        else if (ill1 == 9){
         usleep(21500)
        sendMessage_unit(GID: 0x4,NID:0x5,SID:g_sid,VEL:g_sint,LID:g_led)
        }
        
        else if (ill1 == 10){
         usleep(22000)
         sendMessage_unit(GID: 0x1,NID:0x1,SID:g_sid,VEL:g_sint,LID:g_led)
        }
        
        else if (ill1 == 11){
         usleep(22000)
         sendMessage_unit(GID: 0x5,NID:0x3,SID:g_sid,VEL:g_sint,LID:g_led)
        }
        
        else if (ill1 == 12){
         usleep(22000)
         sendMessage_unit(GID: 0x5,NID:0x2,SID:g_sid,VEL:g_sint,LID:g_led)
        }
        
    }
    
    
    
    //Phaze1の１個ずらし
    func phaze1_2(ill : Int){
        
        if (ill == 1){
        sendMessage_unit(GID: 0x1,NID:0x1,SID:g_sid,VEL:g_sint,LID:g_led)
        }
            
        else if (ill == 2){
        sendMessage_unit(GID: 0x4,NID:0x5,SID:g_sid,VEL:g_sint,LID:g_led)
        }
        
        else if (ill == 3){
        sendMessage_unit(GID: 0xD,NID:0x2,SID:g_sid,VEL:g_sint,LID:g_led)
        }
                  
        else if (ill == 4){
        usleep(3000)
        sendMessage_unit(GID: 0x9,NID:0x1,SID:g_sid,VEL:g_sint,LID:g_led)
        }
                  
        else if (ill == 5){
        usleep(6000)
        sendMessage_unit(GID: 0xD,NID:0x1,SID:g_sid,VEL:g_sint,LID:g_led)
        }
                  
        else if (ill == 6){
        usleep(9000)
        sendMessage_unit(GID: 0x9,NID:0x4,SID:g_sid,VEL:g_sint,LID:g_led)
        }
                
        else if (ill == 7){
        usleep(12000)
        sendMessage_unit(GID: 0xD,NID:0x4,SID:g_sid,VEL:g_sint,LID:g_led)
        }
                      
        else if (ill == 8){
        usleep(15000)
        sendMessage_unit(GID: 0x1,NID:0x4,SID:g_sid,VEL:g_sint,LID:g_led)
        }
                  
                  
        else if (ill == 9){
        usleep(18000)
        sendMessage_unit(GID: 0xC,NID:0x3,SID:g_sid,VEL:g_sint,LID:g_led)
        }
                  
        else if (ill == 10){
        usleep(21000)
        sendMessage_unit(GID: 0xE,NID:0x3,SID:g_sid,VEL:g_sint,LID:g_led)
        }
        
       }
    
   //Phaze1の2個ずらし
      func phaze3(ill : Int){
          
          if (ill == 2){
          sendMessage_unit(GID: 0x1,NID:0x1,SID:g_sid,VEL:g_sint,LID:g_led)
          }
              
          else if (ill == 3){
          sendMessage_unit(GID: 0x4,NID:0x5,SID:g_sid,VEL:g_sint,LID:g_led)
          }
          
          else if (ill == 4){
          sendMessage_unit(GID: 0xD,NID:0x2,SID:g_sid,VEL:g_sint,LID:g_led)
          }
                    
          else if (ill == 5){
          usleep(3000)
          sendMessage_unit(GID: 0x9,NID:0x1,SID:g_sid,VEL:g_sint,LID:g_led)
          }
                    
          else if (ill == 6){
          usleep(6000)
          sendMessage_unit(GID: 0xD,NID:0x1,SID:g_sid,VEL:g_sint,LID:g_led)
          }
                    
          else if (ill == 7){
          usleep(9000)
          sendMessage_unit(GID: 0x9,NID:0x4,SID:g_sid,VEL:g_sint,LID:g_led)
          }
                  
          else if (ill == 8){
          usleep(12000)
          sendMessage_unit(GID: 0xD,NID:0x4,SID:g_sid,VEL:g_sint,LID:g_led)
          }
                        
          else if (ill == 9){
          usleep(15000)
          sendMessage_unit(GID: 0x1,NID:0x4,SID:g_sid,VEL:g_sint,LID:g_led)
          }
                    
                    
          else if (ill == 10){
          usleep(18000)
          sendMessage_unit(GID: 0xC,NID:0x3,SID:g_sid,VEL:g_sint,LID:g_led)
          }
                    
          else if (ill == 1){
          usleep(21000)
          sendMessage_unit(GID: 0xE,NID:0x3,SID:g_sid,VEL:g_sint,LID:g_led)
          }
          
         }
    
    
    
    
    func phaze4(){
             sendMessage_unit(GID: 0x6,NID:0x2,SID:g_sid,VEL:g_sint,LID:g_led)
             sendMessage_unit(GID: 0xE,NID:0x2,SID:g_sid,VEL:g_sint,LID:g_led)
             sendMessage_unit(GID: 0x6,NID:0x3,SID:g_sid,VEL:g_sint,LID:g_led)
             sendMessage_unit(GID: 0xE,NID:0x6,SID:g_sid,VEL:g_sint,LID:g_led)
             sendMessage_unit(GID: 0x6,NID:0x4,SID:g_sid,VEL:g_sint,LID:g_led)
             sendMessage_unit(GID: 0xE,NID:0x7,SID:g_sid,VEL:g_sint,LID:g_led)
             sendMessage_unit(GID: 0x4,NID:0x2,SID:g_sid,VEL:g_sint,LID:g_led)
             sendMessage_unit(GID: 0xE,NID:0x4,SID:g_sid,VEL:g_sint,LID:g_led)
             sendMessage_unit(GID: 0xC,NID:0x5,SID:g_sid,VEL:g_sint,LID:g_led)
             sendMessage_unit(GID: 0x1,NID:0x5,SID:g_sid,VEL:g_sint,LID:g_led)
             
         }
    
    
    func phazeFlowKosu(ill : Int, kyoudo : UInt8){
             
        if (ill == 1 || ill == 2){
            
             sendMessage_unit(GID: 0xE,NID:0x3,SID:g_sid,VEL:kyoudo,LID:g_led)
             usleep (10000);
            if (kyoudo == 0x6){
             sendMessage_unit(GID: 0x1,NID:0x1,SID:g_sid,VEL:kyoudo,LID:g_led)
             usleep (100000);
            }
            if (kyoudo == 0x5){
                sendMessage_unit(GID: 0x1,NID:0x1,SID:g_sid,VEL:kyoudo,LID:g_led)
                usleep (100000);
                sendMessage_unit(GID: 0x9,NID:0x4,SID:g_sid,VEL:kyoudo,LID:g_led)
                usleep (10000);
                sendMessage_unit(GID: 0xD,NID:0x4,SID:g_sid,VEL:kyoudo,LID:g_led)
                usleep (100000);
                }
            if (kyoudo == 0x4 || kyoudo == 0x3 ){
                sendMessage_unit(GID: 0x1,NID:0x1,SID:g_sid,VEL:kyoudo,LID:g_led)
                usleep (100000);
                sendMessage_unit(GID: 0x9,NID:0x4,SID:g_sid,VEL:kyoudo,LID:g_led)
                usleep (10000);
                sendMessage_unit(GID: 0xD,NID:0x4,SID:g_sid,VEL:kyoudo,LID:g_led)
                usleep (100000);
                sendMessage_unit(GID: 0x9,NID:0x1,SID:g_sid,VEL:kyoudo,LID:g_led)
                sendMessage_unit(GID: 0xD,NID:0x1,SID:g_sid,VEL:kyoudo,LID:g_led)
                sendMessage_unit(GID: 0xE,NID:0x3,SID:g_sid,VEL:kyoudo,LID:g_led)
                sendMessage_unit(GID: 0xD,NID:0x2,SID:g_sid,VEL:kyoudo,LID:g_led)
            }
             
            
             
             /*sendMessage_unit(GID: 0xD,NID:0x1,SID:g_sid,VEL:kyoudo,LID:g_led)
             sendMessage_unit(GID: 0xE,NID:0x3,SID:g_sid,VEL:kyoudo,LID:g_led)
             sendMessage_unit(GID: 0xD,NID:0x2,SID:g_sid,VEL:kyoudo,LID:g_led)
             usleep (100000);
             sendMessage_unit(GID: 0x4,NID:0x5,SID:g_sid,VEL:kyoudo,LID:g_led)
             sendMessage_unit(GID: 0x1,NID:0x1,SID:g_sid,VEL:kyoudo,LID:g_led)
            */
            
        }
        
        if (ill == 3 || ill == 4 ){
             sendMessage_unit(GID: 0x5,NID:0x2,SID:g_sid,VEL:kyoudo,LID:g_led)
             usleep (50000);
            if (kyoudo == 0x6){
             sendMessage_unit(GID: 0x5,NID:0x2,SID:g_sid,VEL:kyoudo,LID:g_led)
             usleep (100000);
            }
            if (kyoudo == 0x5){
                sendMessage_unit(GID: 0x5,NID:0x2,SID:g_sid,VEL:kyoudo,LID:g_led)
                usleep (100000);
                sendMessage_unit(GID: 0x9,NID:0x4,SID:g_sid,VEL:kyoudo,LID:g_led)
                usleep (50000);
                sendMessage_unit(GID: 0xD,NID:0x4,SID:g_sid,VEL:kyoudo,LID:g_led)
                usleep (100000);
                       }
            if (kyoudo == 0x4 || kyoudo == 0x3){
                sendMessage_unit(GID: 0x5,NID:0x2,SID:g_sid,VEL:kyoudo,LID:g_led)
                usleep (100000);
                sendMessage_unit(GID: 0x9,NID:0x4,SID:g_sid,VEL:kyoudo,LID:g_led)
                usleep (50000);
                sendMessage_unit(GID: 0xD,NID:0x4,SID:g_sid,VEL:kyoudo,LID:g_led)
                usleep (100000);
                sendMessage_unit(GID: 0x9,NID:0x1,SID:g_sid,VEL:kyoudo,LID:g_led)
                           
                sendMessage_unit(GID: 0xD,NID:0x1,SID:g_sid,VEL:kyoudo,LID:g_led)
                sendMessage_unit(GID: 0xE,NID:0x3,SID:g_sid,VEL:kyoudo,LID:g_led)
                sendMessage_unit(GID: 0xD,NID:0x2,SID:g_sid,VEL:kyoudo,LID:g_led)
                
                   }
            
            /*
             sendMessage_unit(GID: 0x9,NID:0x1,SID:g_sid,VEL:kyoudo,LID:g_led)
             
             sendMessage_unit(GID: 0xD,NID:0x1,SID:g_sid,VEL:kyoudo,LID:g_led)
             sendMessage_unit(GID: 0xE,NID:0x3,SID:g_sid,VEL:kyoudo,LID:g_led)
             sendMessage_unit(GID: 0xD,NID:0x2,SID:g_sid,VEL:kyoudo,LID:g_led)
             usleep (200000);
             sendMessage_unit(GID: 0x4,NID:0x5,SID:g_sid,VEL:kyoudo,LID:g_led)
             sendMessage_unit(GID: 0x1,NID:0x1,SID:g_sid,VEL:kyoudo,LID:g_led)
            */
        }
        
        //脇腹
        if (ill == 5 || ill == 6){
             sendMessage_unit(GID: 0x5,NID:0x3,SID:g_sid,VEL:kyoudo,LID:g_led)
             usleep (50000);
            if (kyoudo == 0x6){
             sendMessage_unit(GID: 0x4,NID:0x2,SID:g_sid,VEL:kyoudo,LID:g_led)
             usleep (100000);
            }
            if (kyoudo == 0x5){
             sendMessage_unit(GID: 0x4,NID:0x2,SID:g_sid,VEL:kyoudo,LID:g_led)
             usleep (100000);
             sendMessage_unit(GID: 0xE,NID:0x4,SID:g_sid,VEL:kyoudo,LID:g_led)
             usleep (50000);
             sendMessage_unit(GID: 0xD,NID:0x4,SID:g_sid,VEL:kyoudo,LID:g_led)
             usleep (100000);
            }
            if (kyoudo == 0x4 || kyoudo == 0x3){
            sendMessage_unit(GID: 0x4,NID:0x2,SID:g_sid,VEL:kyoudo,LID:g_led)
            usleep (100000);
            sendMessage_unit(GID: 0xE,NID:0x4,SID:g_sid,VEL:kyoudo,LID:g_led)
            usleep (50000);
            sendMessage_unit(GID: 0x1,NID:0x5,SID:g_sid,VEL:kyoudo,LID:g_led)
            usleep (100000);
            sendMessage_unit(GID: 0xC,NID:0x5,SID:g_sid,VEL:kyoudo,LID:g_led)
            sendMessage_unit(GID: 0xD,NID:0x1,SID:g_sid,VEL:kyoudo,LID:g_led)
            sendMessage_unit(GID: 0xE,NID:0x3,SID:g_sid,VEL:kyoudo,LID:g_led)
            sendMessage_unit(GID: 0xD,NID:0x2,SID:g_sid,VEL:kyoudo,LID:g_led)
            }
            
            
            /*
             usleep (250000);
             sendMessage_unit(GID: 0x4,NID:0x5,SID:g_sid,VEL:kyoudo,LID:g_led)
             sendMessage_unit(GID: 0x1,NID:0x1,SID:g_sid,VEL:kyoudo,LID:g_led)
            */
            
            //インナー側を責めてくる
            //前から　//近傍　這いまわる　感じ
        }
        
        if (ill == 7 || ill == 8){
            sendMessage_unit(GID: 0xD,NID:0x2,SID:g_sid,VEL:kyoudo,LID:g_led)
            usleep (50000);
            if (kyoudo == 0x6){
            sendMessage_unit(GID: 0xC,NID:0x3,SID:g_sid,VEL:kyoudo,LID:g_led)
            usleep (100000);
            }
            if (kyoudo == 0x5){
            sendMessage_unit(GID: 0xC,NID:0x3,SID:g_sid,VEL:kyoudo,LID:g_led)
            usleep (100000);
            sendMessage_unit(GID: 0x9,NID:0x4,SID:g_sid,VEL:kyoudo,LID:g_led)
            usleep (50000);
            sendMessage_unit(GID: 0xD,NID:0x4,SID:g_sid,VEL:kyoudo,LID:g_led)
            usleep (100000);
            }
            if (kyoudo == 0x4 || kyoudo == 0x3){
            sendMessage_unit(GID: 0xC,NID:0x3,SID:g_sid,VEL:kyoudo,LID:g_led)
            usleep (100000);
            sendMessage_unit(GID: 0x9,NID:0x4,SID:g_sid,VEL:kyoudo,LID:g_led)
            usleep (50000);
            sendMessage_unit(GID: 0xD,NID:0x4,SID:g_sid,VEL:kyoudo,LID:g_led)
            usleep (100000);
            sendMessage_unit(GID: 0x9,NID:0x1,SID:g_sid,VEL:kyoudo,LID:g_led)
            sendMessage_unit(GID: 0xD,NID:0x1,SID:g_sid,VEL:kyoudo,LID:g_led)
            sendMessage_unit(GID: 0xE,NID:0x3,SID:g_sid,VEL:kyoudo,LID:g_led)
            sendMessage_unit(GID: 0xD,NID:0x2,SID:g_sid,VEL:kyoudo,LID:g_led)
            usleep (200000);
            }
            
           /*
            sendMessage_unit(GID: 0x4,NID:0x5,SID:g_sid,VEL:kyoudo,LID:g_led)
            sendMessage_unit(GID: 0x1,NID:0x1,SID:g_sid,VEL:kyoudo,LID:g_led)
            usleep (200000);
            sendMessage_unit(GID: 0x5,NID:0x3,SID:g_sid,VEL:kyoudo,LID:g_led)
            sendMessage_unit(GID: 0x5,NID:0x2,SID:g_sid,VEL:kyoudo,LID:g_led)
            */
        }
        
        if (ill == 9 || ill == 10){
            sendMessage_unit(GID: 0x4,NID:0x5,SID:g_sid,VEL:kyoudo,LID:g_led)
            
            if (kyoudo == 0x6){
            sendMessage_unit(GID: 0xC,NID:0x3,SID:g_sid,VEL:kyoudo,LID:g_led)
            }
            if (kyoudo == 0x5){
            sendMessage_unit(GID: 0xC,NID:0x3,SID:g_sid,VEL:kyoudo,LID:g_led)
            sendMessage_unit(GID: 0x9,NID:0x4,SID:g_sid,VEL:kyoudo,LID:g_led)
            sendMessage_unit(GID: 0xD,NID:0x4,SID:g_sid,VEL:kyoudo,LID:g_led)
            }
            if (kyoudo == 0x4 || kyoudo == 0x3){
            sendMessage_unit(GID: 0xC,NID:0x3,SID:g_sid,VEL:kyoudo,LID:g_led)
            sendMessage_unit(GID: 0x9,NID:0x4,SID:g_sid,VEL:kyoudo,LID:g_led)
            sendMessage_unit(GID: 0xD,NID:0x4,SID:g_sid,VEL:kyoudo,LID:g_led)
            sendMessage_unit(GID: 0x9,NID:0x4,SID:g_sid,VEL:kyoudo,LID:g_led)
            sendMessage_unit(GID: 0xD,NID:0x4,SID:g_sid,VEL:kyoudo,LID:g_led)
            sendMessage_unit(GID: 0x9,NID:0x1,SID:g_sid,VEL:kyoudo,LID:g_led)
            sendMessage_unit(GID: 0xD,NID:0x1,SID:g_sid,VEL:kyoudo,LID:g_led)
            }
            
            /*
            sendMessage_unit(GID: 0x9,NID:0x4,SID:g_sid,VEL:kyoudo,LID:g_led)
      
            sendMessage_unit(GID: 0xD,NID:0x4,SID:g_sid,VEL:kyoudo,LID:g_led)
     
            sendMessage_unit(GID: 0x9,NID:0x1,SID:g_sid,VEL:kyoudo,LID:g_led)
                           
            sendMessage_unit(GID: 0xD,NID:0x1,SID:g_sid,VEL:kyoudo,LID:g_led)
            sendMessage_unit(GID: 0xE,NID:0x3,SID:g_sid,VEL:kyoudo,LID:g_led)
            sendMessage_unit(GID: 0xD,NID:0x2,SID:g_sid,VEL:kyoudo,LID:g_led)
         
            sendMessage_unit(GID: 0x4,NID:0x5,SID:g_sid,VEL:kyoudo,LID:g_led)
            sendMessage_unit(GID: 0x1,NID:0x1,SID:g_sid,VEL:kyoudo,LID:g_led)
            */
            
            }
        
             
    }
    
    
      func phazeFlow(ill : Int, kyoudo : UInt8){
               
          if (ill == 1 || ill == 2){
              
               sendMessage_unit(GID: 0x1,NID:0x4,SID:g_sid,VEL:kyoudo,LID:g_led)
               usleep (10000);
               sendMessage_unit(GID: 0xC,NID:0x3,SID:g_sid,VEL:kyoudo,LID:g_led)
               usleep (100000);
            
          
                sendMessage_unit(GID: 0x9,NID:0x4,SID:g_sid,VEL:kyoudo,LID:g_led)
                usleep (10000);
                sendMessage_unit(GID: 0xD,NID:0x4,SID:g_sid,VEL:kyoudo,LID:g_led)
                usleep (100000);
                sendMessage_unit(GID: 0x9,NID:0x1,SID:g_sid,VEL:kyoudo,LID:g_led)
                sendMessage_unit(GID: 0xD,NID:0x1,SID:g_sid,VEL:kyoudo,LID:g_led)
                sendMessage_unit(GID: 0xE,NID:0x3,SID:g_sid,VEL:kyoudo,LID:g_led)
                sendMessage_unit(GID: 0xD,NID:0x2,SID:g_sid,VEL:kyoudo,LID:g_led)
                usleep (100000);
                sendMessage_unit(GID: 0x4,NID:0x5,SID:g_sid,VEL:kyoudo,LID:g_led)
                sendMessage_unit(GID: 0x1,NID:0x1,SID:g_sid,VEL:kyoudo,LID:g_led)
               
               /*sendMessage_unit(GID: 0xD,NID:0x1,SID:g_sid,VEL:kyoudo,LID:g_led)
               sendMessage_unit(GID: 0xE,NID:0x3,SID:g_sid,VEL:kyoudo,LID:g_led)
               sendMessage_unit(GID: 0xD,NID:0x2,SID:g_sid,VEL:kyoudo,LID:g_led)
               usleep (100000);
               sendMessage_unit(GID: 0x4,NID:0x5,SID:g_sid,VEL:kyoudo,LID:g_led)
               sendMessage_unit(GID: 0x1,NID:0x1,SID:g_sid,VEL:kyoudo,LID:g_led)
              */
              
          }
          
          if (ill == 3 || ill == 4 ){
               sendMessage_unit(GID: 0x1,NID:0x4,SID:g_sid,VEL:kyoudo,LID:g_led)
               usleep (50000);
               sendMessage_unit(GID: 0xC,NID:0x3,SID:g_sid,VEL:kyoudo,LID:g_led)
               usleep (100000);
               sendMessage_unit(GID: 0x9,NID:0x4,SID:g_sid,VEL:kyoudo,LID:g_led)
               usleep (50000);
               sendMessage_unit(GID: 0xD,NID:0x4,SID:g_sid,VEL:kyoudo,LID:g_led)
               usleep (100000);
               sendMessage_unit(GID: 0x9,NID:0x1,SID:g_sid,VEL:kyoudo,LID:g_led)
               
               sendMessage_unit(GID: 0xD,NID:0x1,SID:g_sid,VEL:kyoudo,LID:g_led)
               sendMessage_unit(GID: 0xE,NID:0x3,SID:g_sid,VEL:kyoudo,LID:g_led)
               sendMessage_unit(GID: 0xD,NID:0x2,SID:g_sid,VEL:kyoudo,LID:g_led)
               usleep (200000);
               sendMessage_unit(GID: 0x4,NID:0x5,SID:g_sid,VEL:kyoudo,LID:g_led)
               sendMessage_unit(GID: 0x1,NID:0x1,SID:g_sid,VEL:kyoudo,LID:g_led)
          }
          
          //脇腹
          if (ill == 5 || ill == 6){
               sendMessage_unit(GID: 0xE,NID:0x4,SID:g_sid,VEL:kyoudo,LID:g_led)
               usleep (50000);
               sendMessage_unit(GID: 0x4,NID:0x2,SID:g_sid,VEL:kyoudo,LID:g_led)
               usleep (100000);
               sendMessage_unit(GID: 0x9,NID:0x4,SID:g_sid,VEL:kyoudo,LID:g_led)
               usleep (50000);
               sendMessage_unit(GID: 0xD,NID:0x4,SID:g_sid,VEL:kyoudo,LID:g_led)
               usleep (100000);
               sendMessage_unit(GID: 0x9,NID:0x1,SID:g_sid,VEL:kyoudo,LID:g_led)
               
               sendMessage_unit(GID: 0xD,NID:0x1,SID:g_sid,VEL:kyoudo,LID:g_led)
               sendMessage_unit(GID: 0xE,NID:0x3,SID:g_sid,VEL:kyoudo,LID:g_led)
               sendMessage_unit(GID: 0xD,NID:0x2,SID:g_sid,VEL:kyoudo,LID:g_led)
               usleep (250000);
               sendMessage_unit(GID: 0x4,NID:0x5,SID:g_sid,VEL:kyoudo,LID:g_led)
               sendMessage_unit(GID: 0x1,NID:0x1,SID:g_sid,VEL:kyoudo,LID:g_led)
          }
          
          if (ill == 7 || ill == 8){
              sendMessage_unit(GID: 0x1,NID:0x4,SID:g_sid,VEL:kyoudo,LID:g_led)
              usleep (50000);
              sendMessage_unit(GID: 0xC,NID:0x3,SID:g_sid,VEL:kyoudo,LID:g_led)
              usleep (100000);
              sendMessage_unit(GID: 0x9,NID:0x4,SID:g_sid,VEL:kyoudo,LID:g_led)
              usleep (50000);
              sendMessage_unit(GID: 0xD,NID:0x4,SID:g_sid,VEL:kyoudo,LID:g_led)
              usleep (100000);
              sendMessage_unit(GID: 0x9,NID:0x1,SID:g_sid,VEL:kyoudo,LID:g_led)
                      
              sendMessage_unit(GID: 0xD,NID:0x1,SID:g_sid,VEL:kyoudo,LID:g_led)
              sendMessage_unit(GID: 0xE,NID:0x3,SID:g_sid,VEL:kyoudo,LID:g_led)
              sendMessage_unit(GID: 0xD,NID:0x2,SID:g_sid,VEL:kyoudo,LID:g_led)
              usleep (200000);
              sendMessage_unit(GID: 0x4,NID:0x5,SID:g_sid,VEL:kyoudo,LID:g_led)
              sendMessage_unit(GID: 0x1,NID:0x1,SID:g_sid,VEL:kyoudo,LID:g_led)
              usleep (200000);
              sendMessage_unit(GID: 0x5,NID:0x3,SID:g_sid,VEL:kyoudo,LID:g_led)
              sendMessage_unit(GID: 0x5,NID:0x2,SID:g_sid,VEL:kyoudo,LID:g_led)
          }
          
          if (ill == 9 || ill == 10){
              sendMessage_unit(GID: 0x1,NID:0x4,SID:g_sid,VEL:kyoudo,LID:g_led)
          
              sendMessage_unit(GID: 0xC,NID:0x3,SID:g_sid,VEL:kyoudo,LID:g_led)
          
              sendMessage_unit(GID: 0x9,NID:0x4,SID:g_sid,VEL:kyoudo,LID:g_led)
        
              sendMessage_unit(GID: 0xD,NID:0x4,SID:g_sid,VEL:kyoudo,LID:g_led)
       
              sendMessage_unit(GID: 0x9,NID:0x1,SID:g_sid,VEL:kyoudo,LID:g_led)
                             
              sendMessage_unit(GID: 0xD,NID:0x1,SID:g_sid,VEL:kyoudo,LID:g_led)
              sendMessage_unit(GID: 0xE,NID:0x3,SID:g_sid,VEL:kyoudo,LID:g_led)
              sendMessage_unit(GID: 0xD,NID:0x2,SID:g_sid,VEL:kyoudo,LID:g_led)
           
              sendMessage_unit(GID: 0x4,NID:0x5,SID:g_sid,VEL:kyoudo,LID:g_led)
              sendMessage_unit(GID: 0x1,NID:0x1,SID:g_sid,VEL:kyoudo,LID:g_led)
    
              
              }
          
               
      }
    
    
    func phazeSindou(kyoudo : UInt8){
        
        sendMessage_unit(GID: 0x4,NID:0x4,SID:g_sid,VEL:kyoudo,LID:g_led)
                       
                usleep(100);
        //0.01秒
                usleep (10000);
                       
        sendMessage_unit(GID: 0xE,NID:0x2,SID:g_sid,VEL:kyoudo,LID:g_led)
                      
                usleep(100);
                      
        sendMessage_unit(GID: 0x6,NID:0x7,SID:g_sid,VEL:kyoudo,LID:g_led)

                usleep(100);
        
        sendMessage_unit(GID: 0x5,NID:0x4,SID:g_sid,VEL:kyoudo,LID:g_led)
                      
                usleep(100);
                      
        sendMessage_unit(GID: 0x4,NID:0x1,SID:g_sid,VEL:kyoudo,LID:g_led)
                     
                usleep(100);
                     
        sendMessage_unit(GID: 0x5,NID:0x1,SID:g_sid,VEL:kyoudo,LID:g_led)

                usleep(300);
                    
        sendMessage_unit(GID: 0x4,NID:0x1,SID:g_sid,VEL:kyoudo,LID:g_led)
                       
                usleep(100);
                       
        sendMessage_unit(GID: 0x5,NID:0x1,SID:g_sid,VEL:kyoudo,LID:g_led)
                      
                usleep(100);
                      
        sendMessage_unit(GID: 0x6,NID:0x7,SID:g_sid,VEL:kyoudo,LID:g_led)

                usleep(100);
        sendMessage_unit(GID: 0x5,NID:0x4,SID:g_sid,VEL:kyoudo,LID:g_led)
                      
                usleep(100);
                      
        sendMessage_unit(GID: 0x4,NID:0x4,SID:g_sid,VEL:kyoudo,LID:g_led)
                     
                usleep(100);
                     
        sendMessage_unit(GID: 0xE,NID:0x2,SID:g_sid,VEL:kyoudo,LID:g_led)

                usleep(300);
                    
                    
        sendMessage_unit(GID: 0x4,NID:0x4,SID:g_sid,VEL:kyoudo,LID:g_led)
                       
                usleep(100);
                       
        sendMessage_unit(GID: 0xE,NID:0x2,SID:g_sid,VEL:kyoudo,LID:g_led)
                      
                usleep(100);
                      
        sendMessage_unit(GID: 0x6,NID:0x7,SID:g_sid,VEL:kyoudo,LID:g_led)

                usleep(100);
        
        sendMessage_unit(GID: 0x5,NID:0x4,SID:g_sid,VEL:kyoudo,LID:g_led)
                      
                usleep(100);
                      
        sendMessage_unit(GID: 0x4,NID:0x1,SID:g_sid,VEL:kyoudo,LID:g_led)
                     
                usleep(100);
                     
        sendMessage_unit(GID: 0x5,NID:0x1,SID:g_sid,VEL:kyoudo,LID:g_led)

                usleep(300);
                    
        sendMessage_unit(GID: 0x4,NID:0x1,SID:g_sid,VEL:kyoudo,LID:g_led)
                       
                usleep(100);
                       
        sendMessage_unit(GID: 0x5,NID:0x1,SID:g_sid,VEL:kyoudo,LID:g_led)
                      
                usleep(100);
                      
        sendMessage_unit(GID: 0x6,NID:0x7,SID:g_sid,VEL:kyoudo,LID:g_led)

                usleep(100);
        
        sendMessage_unit(GID: 0x5,NID:0x4,SID:g_sid,VEL:kyoudo,LID:g_led)
                      
                usleep(100);
                      
        sendMessage_unit(GID: 0x4,NID:0x4,SID:g_sid,VEL:kyoudo,LID:g_led)
                     
                usleep(100);
                     
        sendMessage_unit(GID: 0xE,NID:0x2,SID:g_sid,VEL:kyoudo,LID:g_led)

    }
    
    
    

}

