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
    
    private func handlePhoneCall() {
        guard let view = view else { return }
        let phoneCall = view.dataSource.getValue(
            of: TextInputFormField.self,
            byKey: FormFieldKey.phoneCall()
        )
        if phoneCall {
        }
    }
    
    private func handleLogout() {
        guard let view = view else { return }
        let logout = view.dataSource.getValue(
            of: TextInputFormField.self,
            byKey: FormFieldKey.logout()
        )
        if logout {

        }
    }
    
    func callPhone(phoneNumber: String?) {
        if let phoneNumber = phoneNumber, let url = URL(string: "tel://\(phoneNumber)") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
         }
    }
    
    func searchBooks(query: String) {
            NetworkingClient.booksSearch(query: query) { response in
                var homeViewFields: [TextInputFormField] = []
                response?.items.forEach { data in
                    let viewModel = TextInputViewModel(title: data.title,author: data.authors ?? [""], desc: data.desc ?? "", image: data.imurl ?? URL(fileURLWithPath: ""))
                    let formField = TextInputFormField(key: FormFieldKey.phoneCall(), viewModel: viewModel)
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
    
    func fieldDidTap(_ field: any FormField) {
        switch field.key {
        case FormFieldKey.phoneCall.rawValue:
            handlePhoneCall()
        case FormFieldKey.logout.rawValue:
            handleLogout()
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
        case phoneCall
        case logout
        
        func callAsFunction() -> String { rawValue }
    }
}
