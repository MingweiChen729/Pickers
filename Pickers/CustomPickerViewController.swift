//
//  CustomPickerViewController.swift
//  Pickers
//
//  Created by Chen Mingwei on 31/05/2016.
//  Copyright © 2016 Chen Mingwei. All rights reserved.
//

import UIKit
import AudioToolbox

class CustomPickerViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var winLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    
    private var winSoundID: SystemSoundID = 0
    private var crunchSoundID: SystemSoundID = 0
    
    private var images:[UIImage]!
    private enum WinType {
        case Nowin, Small, Jumbo, Jackpot
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        images = [
                    UIImage(named: "seven")!,
                    UIImage(named: "bar")!,
                    UIImage(named: "crown")!,
                    UIImage(named: "cherry")!,
                    UIImage(named: "lemon")!,
                    UIImage(named: "apple")!,
        ]
        
        winLabel.text = " "
        arc4random_stir()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func spin(sender: UIButton) {
        var win = WinType.Nowin
        var numInRow = -1
        var lastVal = -1
        
        winLabel.text = " "
        
        for i in 0..<5 {
            let newValue = Int(arc4random_uniform(UInt32(images.count)))
            
            if (newValue == lastVal) {
                numInRow+=1
            } else {
                numInRow = 1
            }
            lastVal = newValue
            
            picker.selectRow(newValue, inComponent: i, animated: true)
            picker.reloadComponent(i)
            
            if (numInRow == 3) {
                win = .Small
            }
            
            if (numInRow == 4 ) {
                win = .Jumbo
            }
            
            if (numInRow == 5) {
                win = .Jackpot
            }
        }
        
        let winMessage: String!
        switch win {
        case .Small:
            winMessage = "You win 5 Pounds!"
        case .Jumbo:
            winMessage = "You win 50 Pounds!"
        case .Jackpot:
            winMessage = "You win Jackpot!!!"
        case.Nowin:
            winMessage = "Better Luck Next Time"
        }
        
        if crunchSoundID == 0 {
            let soundURL = NSBundle.mainBundle().URLForResource("crunch", withExtension: "wav")! as CFURLRef
            AudioServicesCreateSystemSoundID(soundURL, &crunchSoundID)
        }
        AudioServicesPlaySystemSound(crunchSoundID)
        
        if win != WinType.Nowin {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(0.5 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) {
                self.playWinSound(winMessage)
            }
            
        } else {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(1.5 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) {
                self.winLabel.text = winMessage
                self.showButton()
            }
            
        }
        
        button.hidden = true
        winLabel.text = " "
    }
    
    // MARK:-
    // MARK: Picker Datasource methods
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 5
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return images.count
    }
    
    // MARK: Picker Delegate methods
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        let image = images[row]
        let imageView = UIImageView(image: image)
        return imageView
    }
    
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 64
    }
    
    func showButton() {
        button.hidden = false
    }
    
    func playWinSound(winMessage: String) {
        if winSoundID == 0 {
            let soundURL = NSBundle.mainBundle().URLForResource("win", withExtension: "wav")! as CFURLRef
            AudioServicesCreateSystemSoundID(soundURL, &winSoundID)
        }
        
        AudioServicesPlaySystemSound(winSoundID)
        winLabel.text = winMessage
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(1.5 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) {
            self.showButton()
        }
    }
}
