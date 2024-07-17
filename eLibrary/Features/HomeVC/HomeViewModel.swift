//
//  HomeViewModel.swift
//  eLibrary
//
//  Created by Myron Kampourakis on 15/7/24.
//

import UIKit

final class HomeViewModel {
    
    weak var view: FormDemoViewInput?
    
    init() {}
    
    private func handleTableCell(bookData: Book) {
        guard let view = view else { return }
        let tableCell = view.dataSource.getValue(
            of: TextInputFormField.self,
            byKey: FormFieldKey.tableCell()
        )
        view.navigate(NavigationItem(page: .readScreen(bookData: bookData), navigationStyle: .push(animated: true)))
    }
    
    func searchBooks(query: String) {
        NetworkingClient.booksSearch(query: query) { response in
            var homeViewFields: [TextInputFormField] = []
            response?.items.forEach { data in
                let viewModel = TextInputViewModel(bookData: data,title: data.title,author: data.authors ?? [""], desc: data.desc ?? "", image: data.imurl ?? URL(fileURLWithPath: ""))
                let formField = TextInputFormField(key: FormFieldKey.tableCell(), viewModel: viewModel)
                formField.delegate = self
                homeViewFields.append(formField)
            }
            let sections: [FormSection] = [
                .init(
                    key: FormSectionKey.otherField(),
                    fields: homeViewFields
                )
            ]
            self.view?.dataSource.updateSections(sections)
            self.view?.dataSource.fields.forEach {
                $0.delegate = self
            }
        }
    }
}

// MARK: - FormDemoViewOutput

extension HomeViewModel: FormDemoViewOutput {
    
    func viewDidLoad() {
        view?.configure()
        searchBooks(query: "swift") // Default search
    }
    
    func searchBooks(with query: String) {
        searchBooks(query: query)
    }
}

extension HomeViewModel: FormFieldDelegate {
    
    func fieldDidTap(_ field: any FormField, bookData: Book) {
        switch field.key {
        case FormFieldKey.tableCell.rawValue:
            handleTableCell(bookData: bookData)
        default: break
        }
    }
}

// MARK: - Form Keys

extension HomeViewModel {
    
    enum FormSectionKey: String {
        case otherField
        
        func callAsFunction() -> String { rawValue }
    }
    
    enum FormFieldKey: String {
        case tableCell
        
        func callAsFunction() -> String { rawValue }
    }
}
