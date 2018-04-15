//
//  InitialSetupPageVC.swift
//  BBAHealth
//
//  Created by Christopher Lehrer on 22/03/2018.
//  Copyright © 2018 Episteme. All rights reserved.
//

import UIKit

class InitialSetupPageVC: UIPageViewController,  UIPageViewControllerDelegate, UIPageViewControllerDataSource  {


        var pageControl = UIPageControl()
    
    var isSetupComplete = false
        
        // MARK: UIPageViewControllerDataSource
        
        lazy var orderedViewControllers: [UIViewController] = {
            return [self.newVc(viewController: "initial1"),
                    self.newVc(viewController: "initial2"),self.newVc(viewController: "initial3")]
    

        }()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            self.dataSource = self
            self.delegate = self
            
            
            if let targetSavings = UserDefaults.standard.value(forKey: "targetSavings"){
                isSetupComplete = targetSavings as! Bool
                print(isSetupComplete)
                if isSetupComplete == true{
                    performSegue(withIdentifier: "StartAppTab", sender: nil)
                    
                }
            }else{
            
            // This sets up the first view that will show up on our page control
            if let firstViewController = orderedViewControllers.first {
                setViewControllers([firstViewController],
                                   direction: .forward,
                                   animated: true,
                                   completion: nil)
            }
            
                configurePageControl()}
            
            // Do any additional setup after loading the view.
        }
    
    
        
        
        
        
        
        func configurePageControl() {
            // The total number of pages that are available is based on how many available colors we have.
            pageControl = UIPageControl(frame: CGRect(x: 0,y: UIScreen.main.bounds.maxY - 100,width: UIScreen.main.bounds.width,height: 100))
            self.pageControl.numberOfPages = orderedViewControllers.count
            self.pageControl.currentPage = 0
            self.pageControl.tintColor = UIColor.black
            self.pageControl.pageIndicatorTintColor = UIColor.darkGray
            self.pageControl.currentPageIndicatorTintColor = UIColor.white
            self.pageControl.isUserInteractionEnabled = false
            
            self.view.addSubview(pageControl)
        }
        
        func newVc(viewController: String) -> UIViewController {
            return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: viewController)
        }
        
        
        // MARK: Delegate methords
        func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
            let pageContentViewController = pageViewController.viewControllers![0]
            self.pageControl.currentPage = orderedViewControllers.index(of: pageContentViewController)!
        }
        
        // MARK: Data source functions.
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
            guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
                return nil
            }
            
            let previousIndex = viewControllerIndex - 1
            
            // User is on the first view controller and swiped left to loop to
            // the last view controller.
            guard previousIndex >= 0 else {
                //return orderedViewControllers.last
                // Uncommment the line below, remove the line above if you don't want the page control to loop.
                return nil
            }
            
            guard orderedViewControllers.count > previousIndex else {
                return nil
            }
            
            return orderedViewControllers[previousIndex]
        }
        
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
            guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
                return nil
            }
            
            let nextIndex = viewControllerIndex + 1
            let orderedViewControllersCount = orderedViewControllers.count
            
            // User is on the last view controller and swiped right to loop to
            // the first view controller.
            guard orderedViewControllersCount != nextIndex else {
                //return orderedViewControllers.first
                // Uncommment the line below, remove the line above if you don't want the page control to loop.
                return nil
            }
            
            guard orderedViewControllersCount > nextIndex else {
                return nil
            }
            
            return orderedViewControllers[nextIndex]
        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            //self.tabBarController?.tabBar.barStyle = UIBarStyle.black
            UIApplication.shared.statusBarStyle = .lightContent
        }
        
        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillAppear(animated)
            self.tabBarController?.tabBar.barStyle = UIBarStyle.default
            UIApplication.shared.statusBarStyle = .default
        }
        
        
}

