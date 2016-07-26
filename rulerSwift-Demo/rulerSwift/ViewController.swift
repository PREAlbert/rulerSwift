//
//  ViewController.swift
//  rulerSwift
//
//  Created by Albert on 16/7/25.
//  Copyright © 2016年 Albert. All rights reserved.
//

import UIKit

class ViewController: UIViewController, FSRulerDelegate {

    @IBOutlet weak var rulerLable: UILabel!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?){
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }
    
    convenience init() {
        
        let nibNameOrNil = String?("ViewController")
        self.init(nibName: nibNameOrNil, bundle: nil)
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.view.backgroundColor = UIColor.red()
       // var ruler: rulerView = rulerView.frame(CGRect.init(x: 20, y: 220, width: UIScreen.main().bounds.size.width - 40, 140))
        let ruler: rulerView = rulerView.init(frame: CGRect.init(x: 20, y: 220, width: UIScreen.main().bounds.size.width - 40, height: 140))
        ruler.delegete = self
        ruler.showRulerScrollViewWithCount(200, average: 1, currentValue: 0, smallMode: true)
        self.view.addSubview(ruler)
        
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fsRuler(_ rulerScrollView: FSRulerScrollView) {
        self.rulerLable?.text = String(format: "当前刻度值：%.1f",rulerScrollView.rulerValue!)
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
