//
//  FormViewController.swift
//  eLibrary
//
//  Created by Myron Kampourakis on 15/7/24.
//

import UIKit

protocol FormViewInput: AnyObject {

    func reloadTableView(at indexPaths: [IndexPath])
}

class FormViewController: UIViewController {
    let dataSource = FormDataSource()
    var isPlain = false
    var tableView = UITableView(frame: .zero, style: .grouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = isPlain ? UITableView(frame: .zero, style: .plain) : UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        configure()
    }
}

// MARK: - Configure

extension FormViewController {

    private func configure() {
        setUpLayout()
        setUpViews()
    }

    private func setUpLayout() {
        view.addSubview(tableView)
    }

    private func setUpViews() {
        tableView.backgroundColor = .systemGroupedBackground
        tableView.delegate = self
        tableView.dataSource = self
        dataSource.delegate = self
    }
}

// MARK: - FormDataSourceDelegate

extension FormViewController: FormDataSourceDelegate {

    func dataSourceDidChangeSections(_ dataSource: FormDataSource) {
        for section in dataSource.sections {
            section.header?.register(for: tableView)
            for field in section.fields {
                field.register(for: tableView)
            }
        }
    }

    func dataSourceDidReloadTableView(_ dataSource: FormDataSource) {
        tableView.reloadData()
    }

    func dataSource(_ dataSource: FormDataSource, didUpdateAt indexPaths: [IndexPath]) {
        tableView.reloadRows(at: indexPaths, with: .automatic)
    }

    func dataSource(_ dataSource: FormDataSource, didInsertAt indexPaths: [IndexPath]) {
        tableView.insertRows(at: indexPaths, with: .automatic)
    }

    func dataSource(_ dataSource: FormDataSource, didRemoveAt indexPaths: [IndexPath]) {
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }

    func dataSource(_ dataSource: FormDataSource, didInsertSectionAt sections: IndexSet) {
        tableView.performBatchUpdates {
            tableView.insertSections(sections, with: .fade)
        }
    }

    func dataSource(_ dataSource: FormDataSource, didRemoveSectionAt sections: IndexSet) {
        tableView.deleteSections(sections, with: .fade)
    }
}

// MARK: - FormViewInput

extension FormViewController: FormViewInput {

    func reloadTableView(at indexPaths: [IndexPath]) {
        tableView.reloadRows(at: indexPaths, with: .automatic)
    }
}

// MARK: - UITableViewDataSource

extension FormViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        dataSource.sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.sections[section].fields.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let field = dataSource.sections[indexPath.section].fields[indexPath.row]
        return field.dequeue(for: tableView, at: indexPath)
    }
}

// MARK: - UITableViewDelegate

extension FormViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let field = dataSource.sections[indexPath.section].fields[indexPath.row]
        return field.height
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        dataSource.sections[section].header?.dequeue(for: tableView, in: section)
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let header = dataSource.sections[section].header else { return .zero }
        return header.height
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let field = dataSource.sections[indexPath.section].fields[indexPath.row]
        field.tableView(tableView, didSelectRowAt: indexPath)
    }
}

