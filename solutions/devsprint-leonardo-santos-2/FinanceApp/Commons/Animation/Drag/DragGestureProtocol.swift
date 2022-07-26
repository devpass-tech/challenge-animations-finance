//
//  DragGestureProtocol.swift
//  FinanceApp
//
//  Created by Paolo Prodossimo Lopes on 26/07/22.
//

import Foundation

protocol DragGestureHandlerDelegate: AnyObject {
    func dragGestureDismissed(_ view: UIView, at position: VerticalPosition, dragGesture: DragGestureProtocol)
}

protocol DragGestureProtocol {
    func handle(_ view: UIView, for gesture: UIPanGestureRecognizer)
}
