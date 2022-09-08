//
//  AddTaskViewController.swift
//  GoodList
//
//  Created by Mohammad Azam on 2/27/19.
//  Copyright © 2019 Mohammad Azam. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class AddTaskViewController: UIViewController {
    
    private var taskSubject = PublishSubject<Task>()
    
    var taskSubjectObservable: Observable<Task> {
        return taskSubject.asObserver()
    }
    
    @IBOutlet weak var prioritySegmentedControl: UISegmentedControl!
    @IBOutlet weak var taskTitleTextField: UITextField!
    
    @IBAction func onSaveAction(_ sender: UIButton) {
        guard let priority = Priority(rawValue: self.prioritySegmentedControl.selectedSegmentIndex),
              let title = self.taskTitleTextField.text
        else { return }
        
        let task = Task(title: title, priority: priority)
        self.taskSubject.onNext(task)
        self.dismiss(animated: true)
    }
}
