//
//  ViewController.swift
//  AboutMeStoryboards
//
//  Created by user on 6/11/23.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var todos: [TodoItem] = [TodoItem(name: "Test todo item")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubview(tableView)
        constraintTableView()
        configureTableView()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(openAlert))
    }
    
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    @objc func openAlert() {
        let alert = UIAlertController(title: "Create todo", message: "", preferredStyle: .alert)
        alert.addTextField()
        let saveButton = UIAlertAction(title: "Save", style: .default) { _ in
            if let textName = alert.textFields?.first?.text {
                self.addTodo(name: textName)
            }
        }
        alert.addAction(saveButton)
        let cancelButton = UIAlertAction(title: "Cancel", style: .destructive)
        alert.addAction(cancelButton)
        
        present(alert, animated: true)
    }
    
    func addTodo(name: String) {
        todos.append(TodoItem(name: name))
        tableView.reloadData()
    }
    
    func constraintTableView() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "todoCell")
    }
    
    // MARK: - Table View Methods

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "todoCell")
        let todoItem = todos[indexPath.row]
        
        cell.textLabel?.text = todoItem.name
        cell.accessoryType = .checkmark
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            todos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

