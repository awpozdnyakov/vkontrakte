//
//  BigPhotoController.swift
//  Vkontrakte
//
//  Created by Andrey Pozdnyakov on 02.12.2022.
//

import UIKit

class BigPhotoController: UIViewController {

    @IBOutlet var bigPhotoImage: UIImageView! {
        
        didSet {
            bigPhotoImage.isUserInteractionEnabled = true
        }
    }
    
    enum AnimationDirection {
        case left
        case right
    }
    
    private var animationDirection: AnimationDirection = .left
    
    private let additionalImageView = UIImageView()
    
    public var photos: [UIImage] = []
    public var selectedPhotoIndex: Int = 0
    
    private var propertyAnimator: UIViewPropertyAnimator!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard !photos.isEmpty else {return}
        bigPhotoImage.image = photos[selectedPhotoIndex]
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(leftSwipeFunc))
        leftSwipe.direction = .left
        bigPhotoImage.addGestureRecognizer(leftSwipe)
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(rightSwipeFunc))
        rightSwipe.direction = .right
        bigPhotoImage.addGestureRecognizer(rightSwipe)
        
        view.addSubview(additionalImageView)
        view.sendSubviewToBack(additionalImageView)
        additionalImageView.translatesAutoresizingMaskIntoConstraints = false
        additionalImageView.contentMode = .scaleAspectFit
        
        NSLayoutConstraint.activate([
            additionalImageView.leadingAnchor.constraint(equalTo: bigPhotoImage.leadingAnchor),
            additionalImageView.trailingAnchor.constraint(equalTo: bigPhotoImage.trailingAnchor),
            additionalImageView.topAnchor.constraint(equalTo: bigPhotoImage.topAnchor),
            additionalImageView.bottomAnchor.constraint(equalTo: bigPhotoImage.bottomAnchor)
        
        
        ])
        
        let panGR = UIPanGestureRecognizer(target: self, action: #selector(viewPanned))
        view.addGestureRecognizer(panGR)
        
    }
    
    @objc func viewPanned(_ panGestureRecognizer: UIPanGestureRecognizer) {
        
        switch panGestureRecognizer.state {
         
        case .began:
            if panGestureRecognizer.translation(in: view).x > 0 {
                guard selectedPhotoIndex >= 1 else {return}
                
                animationDirection = .right
                
                self.additionalImageView.transform = CGAffineTransform(translationX: -1.5*self.additionalImageView.bounds.width, y: 200).concatenating(CGAffineTransform(scaleX: 1.2, y: 1.2))
                self.additionalImageView.image = photos[selectedPhotoIndex - 1]
                
                propertyAnimator = UIViewPropertyAnimator(duration: 0.7, curve: .easeInOut, animations: {
                    self.bigPhotoImage.transform = CGAffineTransform(translationX: 1.5*self.bigPhotoImage.bounds.width, y: -200).concatenating(CGAffineTransform(scaleX: 0.6, y: 0.6))
                    self.additionalImageView.transform = .identity
                })
                propertyAnimator.addCompletion { position in
                    switch position {
                    
                    case .end:
                        self.selectedPhotoIndex -= 1
                        self.bigPhotoImage.image = self.photos[self.selectedPhotoIndex]
                        self.bigPhotoImage.transform = .identity
                        
                        self.additionalImageView.image = nil
                    case .start:
                        self.additionalImageView.transform = CGAffineTransform(translationX: -1.5*self.additionalImageView.bounds.width, y: 200).concatenating(CGAffineTransform(scaleX: 1.2, y: 1.2))
                    case .current:
                        break
                    @unknown default:
                        break
                    }
                }
                
            } else {
                guard selectedPhotoIndex + 1 < photos.count - 1 else {return}
                
                animationDirection = .left
                
                self.additionalImageView.transform = CGAffineTransform(translationX: 1.5*self.additionalImageView.bounds.width, y: 200).concatenating(CGAffineTransform(scaleX: 1.2, y: 1.2))
                self.additionalImageView.image = photos[selectedPhotoIndex + 1]
                
                propertyAnimator = UIViewPropertyAnimator(duration: 0.7, curve: .easeInOut, animations: {
                    self.bigPhotoImage.transform = CGAffineTransform(translationX: -1.5*self.bigPhotoImage.bounds.width, y: -200).concatenating(CGAffineTransform(scaleX: 0.6, y: 0.6))
                    self.additionalImageView.transform = .identity
                })
                propertyAnimator.addCompletion { position in
                    switch position {
                    
                    case .end:
                        self.selectedPhotoIndex += 1
                        self.bigPhotoImage.image = self.photos[self.selectedPhotoIndex]
                        self.bigPhotoImage.transform = .identity
                        
                        self.additionalImageView.image = nil
                    case .start:
                        self.additionalImageView.transform = CGAffineTransform(translationX:  1.5*self.additionalImageView.bounds.width, y: 200).concatenating(CGAffineTransform(scaleX: 1.2, y: 1.2))
                    case .current:
                        break
                    @unknown default:
                        break
                    }
                }
            }
        case .changed:
            switch animationDirection {
            case .right:
                let percent = min(max(0, panGestureRecognizer.translation(in: view).x/200), 1)
                propertyAnimator.fractionComplete = percent
            case .left:
                let percent = min(max(0, -panGestureRecognizer.translation(in: view).x/200), 1)
                propertyAnimator.fractionComplete = percent
            }
        case .ended:
            if propertyAnimator.fractionComplete > 0.33 {
                propertyAnimator.continueAnimation(withTimingParameters: nil, durationFactor: 0.5)
            } else {
                propertyAnimator.isReversed = true
                propertyAnimator.continueAnimation(withTimingParameters: nil, durationFactor: 0.5)
            }
        @unknown default:
            break
        }
        
    }
    
    @objc func leftSwipeFunc() {
        guard selectedPhotoIndex + 1 < photos.count - 1 else {
            selectedPhotoIndex = 0
            bigPhotoImage.image = photos[selectedPhotoIndex]
            return
        }
        
        additionalImageView.transform = CGAffineTransform(translationX: 1.5*additionalImageView.bounds.width, y: 200).concatenating(CGAffineTransform(scaleX: 1.2, y: 1.2))
        additionalImageView.image = photos[selectedPhotoIndex + 1]
        
        UIView.animateKeyframes(withDuration: 0.8,
                                delay: 0,
                                options: .beginFromCurrentState) {
            self.bigPhotoImage.transform = CGAffineTransform(translationX: -self.bigPhotoImage.bounds.width, y: -100).concatenating(CGAffineTransform(scaleX: 0.6, y: 0.6))
            self.additionalImageView.transform = .identity
        } completion: { _ in
            self.selectedPhotoIndex += 1
            self.bigPhotoImage.image = self.photos[self.selectedPhotoIndex]
            self.bigPhotoImage.transform = .identity
            
            self.additionalImageView.image = nil
        }
    }
    
    @objc func rightSwipeFunc() {
        guard selectedPhotoIndex > 1 else {
            selectedPhotoIndex = photos.count - 1
            bigPhotoImage.image = photos[selectedPhotoIndex]
            return
        }
        
        additionalImageView.transform = CGAffineTransform(translationX: -1.5*additionalImageView.bounds.width, y: 200).concatenating(CGAffineTransform(scaleX: 1.2, y: 1.2))
        additionalImageView.image = photos[selectedPhotoIndex - 1]
        
        UIView.animateKeyframes(withDuration: 0.8,
                                delay: 0,
                                options: .beginFromCurrentState) {
            self.bigPhotoImage.transform = CGAffineTransform(translationX: 1.5*self.bigPhotoImage.bounds.width, y: -100).concatenating(CGAffineTransform(scaleX: 0.6, y: 0.6))
            self.additionalImageView.transform = .identity
        } completion: { _ in
            self.selectedPhotoIndex -= 1
            self.bigPhotoImage.image = self.photos[self.selectedPhotoIndex]
            self.bigPhotoImage.transform = .identity
            
            self.additionalImageView.image = nil
        }
    }

}
