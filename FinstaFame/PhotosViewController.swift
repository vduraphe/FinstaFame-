//
//  PhotosViewController.swift
//  FinstaFame
//
//  Created by Vaidehi Duraphe on 3/8/17.
//  Copyright © 2017 Vaidehi Duraphe. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var postPic: UIImage?

    @IBOutlet weak var caption: UITextField!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func postPhoto(_ sender: AnyObject) {
        Post.postUserImage(image: postPic, withCaption: caption.text) { (success: Bool, error: Error?) -> Void in
            if(success){
                print("image posted")
            }
            if(error != nil){
                print(error?.localizedDescription)
            }
        }
        caption.text = ""
        
        self.dismiss(animated: true) { () -> Void in
            print("return to feed")
        }

    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        // Get the image captured by the UIImagePickerController
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        postPic = originalImage
        if postPic == nil {
            print("nil early")
        } else {
            print("not nil early")
        }
        dismiss(animated: true, completion: nil)
    }

    @IBAction func onCancel(_ sender: AnyObject) {
        
        self.dismiss(animated: true) { () -> Void in
            print("go back to feed screen")
        }

    }
 
    @IBAction func chooseImage(_ sender: AnyObject) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        self.present(vc, animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
