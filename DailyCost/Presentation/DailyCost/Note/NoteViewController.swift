//
//  NoteViewController.swift
//  DailyCost
//
//  Created by Panji Yoga on 21/09/23.
//

import UIKit

class NoteViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var noteTableView: UITableView!
    @IBOutlet weak var containerAddNewNoteView: UIView!
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        shouldHideBackButtonText = true
        configureViews()
    }
    
    // MARK: - Methods
    private func configureViews() {
        title = "Note"
        
        containerAddNewNoteView.layer.cornerRadius = 12
        containerAddNewNoteView.layer.masksToBounds = true
        
        noteTableView.register(UINib(nibName: "NotesTableViewCell", bundle: nil), forCellReuseIdentifier: "NotesTableViewCell")
        noteTableView.dataSource = self
        noteTableView.delegate = self
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension NoteViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NotesTableViewCell", for: indexPath) as? NotesTableViewCell else { return UITableViewCell() }
        return cell
    }
}
