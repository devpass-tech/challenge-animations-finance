//
//  DragGestureProtocol.swift
//  FinanceApp
//
//  Created by Paolo Prodossimo Lopes on 26/07/22.
//

import UIKit

protocol DragGestureDelegate: AnyObject {
    func dragGestureDismissed(_ view: UIView, at position: VerticalPosition, dragGesture: DragGestureProtocol)
}

protocol DragGestureProtocol {
    var delegate: DragGestureDelegate? { get set }
    func handle(_ view: UIView, for gesture: UIPanGestureRecognizer)
}
