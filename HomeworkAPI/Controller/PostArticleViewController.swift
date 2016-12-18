//
//  PostArticleViewController.swift
//  HomeworkAPI
//
//  Created by Pen DaraYuth on 16/12/16.
//  Copyright © 2016 Pen DaraYuth. All rights reserved.
//

import UIKit
import Alamofire

class PostArticleViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    var image:UIImage?
    var dataImage:String?
    var imagePickers:UIImagePickerController?
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextView!
    @IBOutlet weak var photoImageView: UIImageView!
    
    
    //Post Data
    func postData(postTitle: String, postDescription: String, postPhoto: String){
        
        let url = "http://120.136.24.174:1301/v1/api/articles?page=1&limit=15"
        
        //Data will post to API
        let myPost = ["TITLE": postTitle, "DESCRIPTION": postDescription, "IMAGE": postPhoto] as [String : Any]
        
        Alamofire.request(url, method: .post, parameters: myPost, encoding: JSONEncoding.default, headers: ["Authorization": "Basic QU1TQVBJQURNSU46QU1TQVBJUEBTU1dPUkQ="]).responseJSON { (response) in
            
            switch(response.result) {
            case .success(_):
                if response.result.value != nil{
                    print(response.result.value!)
                }
                break
            case .failure(_):
                print(response.result.error!)
                break
            }
        }
    }
    
    //Upload Image
    func uploadImage(image:UIImage) -> String
    {
        var d: String?
        
        let url = URL(string:"http://120.136.24.174:1301/v1/api/uploadfile/single")
        var request = URLRequest(url: url!)
        
        request.httpMethod = "POST"
        let boundary = generateBoundaryString()
        
        //define the multipart request type
        request.setValue("Basic QU1TQVBJQURNSU46QU1TQVBJUEBTU1dPUkQ=", forHTTPHeaderField: "Authorization")
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        let image_data = UIImagePNGRepresentation(image)
        let body = NSMutableData()
        let fname = ".jpg"
        let imageType = "image/png/jpg"
        
        //define the data post parameter
        body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
        body.append("Content-Disposition:form-data; name=\"FILE\"\r\n\r\n".data(using: String.Encoding.utf8)!)
        body.append("hi\r\n".data(using: String.Encoding.utf8)!)
        
        body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
        body.append("Content-Disposition:form-data; name=\"FILE\"; filename=\"\(fname)\"\r\n".data(using: String.Encoding.utf8)!)
        body.append("Content-Type: \(imageType)\r\n\r\n".data(using: String.Encoding.utf8)!)
        body.append(image_data!)
        body.append("\r\n".data(using: String.Encoding.utf8)!)
        
        body.append("--\(boundary)--\r\n".data(using: String.Encoding.utf8)!)
        
        request.httpBody = body as Data
        let pdata = body as Data
        
        let task = URLSession.shared.uploadTask(with: request, from: pdata) { (data, response, error) in
            
            let dat = try! JSONSerialization.jsonObject(with: pdata, options: []) as! [String:Any]
            d = (dat["DATA"] as! String)
            
            print("success --->")
            print(d!)
        }
        
        task.resume()
        
        if let url = d {
            return url
        }else{
            return "error"
        }
    }

    //Post Data
    func postDataToAPI() {
        if let image = photoImageView.image {
            uploadImage(image:image)
            postData(postTitle: titleTextField.text!, postDescription: descriptionTextField.text!, postPhoto:"")
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    
    //Post Button
    @IBAction func uploadButtonClick() {
        postDataToAPI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(PostArticleViewController.tapImage))
        singleTap.numberOfTapsRequired = 1
        self.photoImageView.isUserInteractionEnabled = true
        self.photoImageView.addGestureRecognizer(singleTap)
        
        imagePickers = UIImagePickerController()
        imagePickers?.delegate = self
        
        uploadButtonClick()
    }
    
    
    //Tap on Image
    func tapImage() {
        imagePickers?.allowsEditing = false
        imagePickers?.sourceType = .photoLibrary
        present(imagePickers!, animated: true, completion: nil)
    }
    
    //After picking photo, dismiss it
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] {
            photoImageView.image = image as? UIImage
            imagePickers?.dismiss(animated: true, completion: nil)
        }
    }
    
    
    func generateBoundaryString() -> String
    {
        return "Boundary-\(NSUUID().uuidString)"
    }

    private func FetchDataResponseHTTPEroro(errorResponse: HTTPURLResponse) {
        print("Server error code \(errorResponse.statusCode)")
        print("Server error \(errorResponse)")
    }
    
    func FetchErrorFromClient(errorMessage: NSError) {
        print("Error : \(errorMessage)")
    }
    
    private func FetchDataResponseSuccess(responseData: [String : AnyObject]) {
        print("Success \(responseData)")
    }

    
}


