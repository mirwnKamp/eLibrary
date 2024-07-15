//
//  FormHeader.swift
//  eLibrary
//
//  Created by Myron Kampourakis on 15/7/24.
//

import UIKit

protocol FormHeader: AnyObject {

    var key: String { get }
    var height: CGFloat { get }

    func register(for tableView: UITableView)
    func dequeue(for tableView: UITableView, in section: Int) -> UIView?
}
