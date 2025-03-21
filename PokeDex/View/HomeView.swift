//
//  HomeView.swift
//  PokeDex
//
//  Created by Ali Haidar on 3/21/25.
//

import SwiftUI
import XLPagerTabStrip
import Kingfisher

struct HomeView: View {
    var body: some View {
        
        PagerTabStripView()
            .padding(.top)
            .navigationBarBackButtonHidden()
    }
}

#Preview {
    HomeView()
}


class CustomPagerTabStripViewController: ButtonBarPagerTabStripViewController {
    
    override func viewDidLoad() {
        settings.style.buttonBarBackgroundColor = .black
        settings.style.buttonBarItemBackgroundColor = .black
        settings.style.selectedBarBackgroundColor = .white
            settings.style.buttonBarItemFont = .boldSystemFont(ofSize: 14)
            settings.style.selectedBarHeight = 2.0
            settings.style.buttonBarMinimumLineSpacing = 0
            settings.style.buttonBarItemTitleColor = .black
            settings.style.buttonBarItemsShouldFillAvailableWidth = true
            settings.style.buttonBarLeftContentInset = 0
            settings.style.buttonBarRightContentInset = 0

            changeCurrentIndexProgressive = { [weak self] (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
                guard changeCurrentIndex == true else { return }
                oldCell?.label.textColor = .white
                newCell?.label.textColor = .orange
            }
            super.viewDidLoad()
        }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        return [HomeViewController(), ProfileViewController()]
    }
}

class HomeViewController: UIViewController, IndicatorInfoProvider {
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Home")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        
        let homeTabView = HomeTab()
        let hostingController = UIHostingController(rootView: homeTabView)
        
        addChild(hostingController)
        view.addSubview(hostingController.view)
        
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        hostingController.didMove(toParent: self)
    }
}


class ProfileViewController: UIViewController, IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Profile")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        
        let homeTabView = ProfileTab()
        let hostingController = UIHostingController(rootView: homeTabView)
        
        addChild(hostingController)
        view.addSubview(hostingController.view)
        
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        hostingController.didMove(toParent: self)
    }
}

struct PagerTabStripView: View {
    var body: some View {
        PagerTabStripWrapper()
            .edgesIgnoringSafeArea(.top)
    }
}

struct PagerTabStripWrapper: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> CustomPagerTabStripViewController {
        return CustomPagerTabStripViewController()
    }
    
    func updateUIViewController(_ uiViewController: CustomPagerTabStripViewController, context: Context) {}
}

