//
//  SplashViewController.swift
//  SportApp
//
//  Created by ahmed on 09/02/2023.
//

import UIKit
import Lottie
class SplashViewController: UIViewController {

        var animationView : LottieAnimationView?
        override func viewDidLoad() {
            super.viewDidLoad()
            animationView = .init(name: "splash")
            animationView?.frame = view.bounds
            animationView?.loopMode = .loop
            guard let animationView = animationView else {return}
            view.addSubview(animationView)
            animationView.play()
            navigationToNextScene()
        }
        

        func navigationToNextScene(){
            DispatchQueue.main.asyncAfter(deadline: .now()+3){
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ViewController")
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
            }
        }
}
