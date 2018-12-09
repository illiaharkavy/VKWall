//
//  ViewController.swift
//  Wall
//
//  Created by ILLIA HARKAVY on 12/9/18.
//  Copyright © 2018 ILLIA HARKAVY. All rights reserved.
//

import UIKit
import Moya

class ViewController: UIViewController {

    let provider = MoyaProvider<VK>()
    
    private var state: State = .pending {
        didSet {
            switch state {
            case .pending:
                title = "VK Wall Search"
                inputContainerView.isHidden = false
                tableView.isHidden = true
                activityIndicator.isHidden = true
                activityIndicator.stopAnimating()
                errorContainerView.isHidden = true
                navigationItem.leftBarButtonItem = nil
            case .loading(let id):
                title = id
                activityIndicator.isHidden = false
                activityIndicator.startAnimating()
                tableView.isHidden = true
                inputContainerView.isHidden = true
                errorContainerView.isHidden = true
                navigationItem.leftBarButtonItem = nil
            case .ready(let id, _):
                title = id
                tableView.isHidden = false
                tableView.reloadData()
                inputContainerView.isHidden = true
                activityIndicator.isHidden = true
                activityIndicator.stopAnimating()
                errorContainerView.isHidden = true
                let retryBarButtonItem = UIBarButtonItem(title: "Retry",
                                                         style: .plain,
                                                         target: self,
                                                         action: #selector(retryButtonTapped(_:)))
                navigationItem.leftBarButtonItem = retryBarButtonItem
            case .error(let id):
                title = id
                errorContainerView.isHidden = false
                tableView.isHidden = true
                inputContainerView.isHidden = true
                activityIndicator.isHidden = true
                activityIndicator.stopAnimating()
                navigationItem.leftBarButtonItem = nil
            }
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var inputContainerView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var errorContainerView: UIView!
    @IBOutlet weak var requestTypeSegmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        state = .pending
    }
    
    func requestPosts(for id: String) {
        guard !id.isEmpty else { return }
        state = .loading(id)
        let encodedText = id.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!
        let type: VK.RequestType = requestTypeSegmentedControl.selectedSegmentIndex == 0 ? .ownerID : .domain
        provider.request(.wallPosts(string: encodedText, type: type, count: 50)) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                do {
                    let posts = try response.map(VKResponse<Post>.self).response.items
                    self.state = .ready(id, posts)
                } catch {
                    print(error)
                    self.state = .error(id)
                }
            case .failure:
                self.state = .error(id)
            }
        }
    }
    
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        textField.resignFirstResponder()
        requestPosts(for: textField.text!)
    }
    
    @IBAction func tapGestureRecognized(_ sender: UITapGestureRecognizer) {
        textField.resignFirstResponder()
    }
    
    @IBAction @objc func retryButtonTapped(_ sender: Any) {
        state = .pending
    }
    
    enum State {
        case pending
        case loading(String)
        case ready(String, [Post])
        case error(String)
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard case .ready(_, let posts) = state else { return 0 }
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        guard case .ready(_, let posts) = state else { return cell }
        let post = posts[indexPath.row]
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = post.text ?? "No Text"
        return cell
    }
    
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text {
            requestPosts(for: text)
        }
        textField.resignFirstResponder()
        return true
    }
}
