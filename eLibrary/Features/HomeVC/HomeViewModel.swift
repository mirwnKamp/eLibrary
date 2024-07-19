//
//  HomeViewModel.swift
//  eLibrary
//
//  Created by Myron Kampourakis on 15/7/24.
//

import UIKit

final class HomeViewModel {
    
    weak var view: FormDemoViewInput?
    private var homeViewFields: [TextInputFormField] = []
    
    init() {}
    
    private func handleTableCell(bookData: Book) {
        guard let view = view else { return }
//        let tableCell = view.dataSource.getValue(
//            of: TextInputFormField.self,
//            byKey: FormFieldKey.tableCell()
//        )
        view.navigate(NavigationItem(page: .readScreen(bookData: bookData), navigationStyle: .push(animated: true)))
    }
    
    func searchBooks(query: String, index: Int) {
        DispatchQueue.main.async {
            NetworkingClient.booksSearch(query: query, index: index) { [weak self] response in
                guard let strongSelf = self else { return }
                strongSelf.homeViewFields.removeAll()
                if let response = response {
                    response.items.forEach { data in
                        let viewModel = TextInputViewModel(bookData: data,title: data.title,author: data.authors ?? [""], desc: data.desc ?? "", image: data.imurl ?? URL(fileURLWithPath: ""))
                        let formField = TextInputFormField(key: FormFieldKey.tableCell(), viewModel: viewModel)
                        formField.delegate = self
                        strongSelf.homeViewFields.append(formField)
                    }
                } else {
                    print ("response is nil")
                }
                let sections: [FormSection] = [
                    .init(
                        key: FormSectionKey.otherField(),
                        fields: strongSelf.homeViewFields
                    )
                ]
                strongSelf.view?.dataSource.updateSections(sections)
                strongSelf.view?.dataSource.fields.forEach {
                    $0.delegate = self
                }
            }
        }
    }
    
    func loadMoreData(query: String, index: Int, completion: @escaping () -> Void) {
        DispatchQueue.main.async {
            NetworkingClient.booksSearch(query: query, index: index) { [weak self] response in
                guard let strongSelf = self else { return }
                if let response = response {
                    response.items.forEach { data in
                        let viewModel = TextInputViewModel(bookData: data,title: data.title,author: data.authors ?? [""], desc: data.desc ?? "", image: data.imurl ?? URL(fileURLWithPath: ""))
                        let formField = TextInputFormField(key: FormFieldKey.tableCell(), viewModel: viewModel)
                        formField.delegate = self
                        strongSelf.homeViewFields.append(formField)
                    }
                } else {
                    print ("response is nil")
                }
                let sections: [FormSection] = [
                    .init(
                        key: FormSectionKey.otherField(),
                        fields: strongSelf.homeViewFields
                    )
                ]
                strongSelf.view?.dataSource.updateSections(sections)
                strongSelf.view?.dataSource.fields.forEach {
                    $0.delegate = self
                }
                
                completion()
            }
        }
    }
}

// MARK: - FormDemoViewOutput

extension HomeViewModel: FormDemoViewOutput {
    
    func viewDidLoad(index: Int) {
        view?.configure()
        searchBooks(query: "swift", index: index) // Default search
    }
    
    func searchBooks(with query: String, index: Int) {
        searchBooks(query: query, index: index)
    }
    
    func loadMoreData(with query: String, index: Int, completion: @escaping () -> Void) {
        loadMoreData(query: query,index: index, completion: completion)
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
