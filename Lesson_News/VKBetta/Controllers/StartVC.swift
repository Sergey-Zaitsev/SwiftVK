//
//  StartVC.swift
//  VKBetta
//
//  Created by Сергей Зайцев on 14.07.2021.
//

import UIKit
import VK_ios_sdk

final class StartVC: UIViewController {
    let vkService = ServiceLocator.shared.vkService
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        vkService.setup(with: self)
    }
}

extension StartVC: VKServiceDelegate {
    
    func authorizationFinished() {
        performSegue(withIdentifier: "HomeSegue", sender: nil)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
    }
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        present(controller, animated: true, completion: nil);
    }
}

