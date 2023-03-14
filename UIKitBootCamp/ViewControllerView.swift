//
//  ViewControllerView.swift
//  UIKitBootCamp
//
//  Created by james seo on 2023/03/14.
//

import SwiftUI

struct ViewControllerView: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIViewController
    
    func makeUIViewController(context: Context) -> UIViewController {
        let vc = ViewController()
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        //
    }
}

struct ViewControllerView_Previews: PreviewProvider {
    static var previews: some View {
        ViewControllerView()
    }
}
