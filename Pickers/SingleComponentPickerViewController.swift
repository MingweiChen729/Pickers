//
//  SingleComponentPickerViewController.swift
//  Pickers
//
//  Created by Chen Mingwei on 31/05/2016.
//  Copyright © 2016 Chen Mingwei. All rights reserved.
//

import UIKit

class SingleComponentPickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var singlePicker: UIPickerView!
    
    private let fruitNames = ["Apple","Orange","Banana","Grape","Watermelon","Kiwi","Avocado"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

    @IBAction func onButtonPressed(sender: UIButton) {
        
        let selected = fruitNames[singlePicker.selectedRowInComponent(0)]
        
        let message = "You have selected \(selected)"
        
        let alert = UIAlertController(title: "Fruit Selected", message: message, preferredStyle: .Alert)
        
        let action = UIAlertAction(title: "That is so true!", style: .Default, handler: nil)
        
        alert.addAction(action)
        
        presentViewController(alert, animated: true, completion: nil)
    }
    
    // MARK:-
    // MARK: Picker Datasource methods
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return fruitNames.count
    }
    
    //MARK: Picker Delegate methods
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return fruitNames[row]
    }
}
