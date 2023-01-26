//
//  SupportRequestViewModel.swift
//  ValuationApp
//
//  Created by Evgeny on 12.12.22.
//

import Foundation
import RxRelay
import Firebase
import RxSwift

class SupportRequestViewModel {
    var requestArray = BehaviorRelay<[Support]>(value: [])
    var ref: DatabaseReference!

    func loadData() {
        var requestArr: [Support] = []

        ref = Database.database().reference()
        ref.child("support_request").observeSingleEvent(of: .value, with: { (snapshot) in
            if let value = snapshot.value as? [String : NSDictionary] {
                for (_, value) in value {

                    let request: Support = Support(message: value["message"] as! String, user: value["user"] as! String)
                        requestArr.append(request)
                    print(request)
                }
                self.requestArray.accept(requestArr)
            }
        }) { error in
        print(error.localizedDescription)
        }
    }
}
