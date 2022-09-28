//
//  ViewController.swift
//  iCat
//
//  Created by Elizabeth Hvorost on 15.09.22.
//

import UIKit

extension CGRect
{
    func hasIntersectionWith(_ rects: [CGRect]) -> Bool
    {
        for eachFrame in rects
        {
            if self.intersects(eachFrame)
            {
                return true
            }
        }
        return false
    }
}

class ViewController: UIViewController
{
    @IBOutlet weak var buttonDown: UIButton!
    @IBOutlet weak var buttonUp: UIButton!
    @IBOutlet weak var buttonLeft: UIButton!
    @IBOutlet weak var buttonRight: UIButton!
    
    let width: CGFloat = 80
    let height: CGFloat = 80
    let offset: CGFloat = UIScreen.main.bounds.height * 0.1
    let myCircle = UIView()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.backgroundColor = .gray
       
        self.myCircle.frame = CGRect(x: UIScreen.main.bounds.width * 0.5 - self.width * 0.5,
                                y: UIScreen.main.bounds.height * 0.5 - self.height * 0.5,
                                width: self.width,
                                height: self.height)
        self.myCircle.backgroundColor = .orange
        self.myCircle.layer.cornerRadius = self.width * 0.5
        self.view.addSubview(self.myCircle)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(circleWasTapped))
        self.myCircle.addGestureRecognizer(tapGesture)
    }
    
    private func screenContains(rect: CGRect) -> Bool
    {
        let safeAreaRect = self.view.safeAreaLayoutGuide.layoutFrame
        if CGRectContainsRect(safeAreaRect, rect)
        {
            return true
        }
        return false
    }
    
    @objc private func circleWasTapped()
    {
        let randomRed = Double.random(in: 0.0...1.0)
        let randomGreen = Double.random(in: 0.0...1.0)
        let randomBlue = Double.random(in: 0.0...1.0)

        let maxX = UIScreen.main.bounds.width - self.width
        let randomX = Double.random(in: 0...maxX)
        let maxY = UIScreen.main.bounds.height - self.height
        let randomY = Double.random(in: 0...maxY)
        var frame = self.myCircle.frame
        frame.origin = CGPoint(x: randomX, y: randomY)
        
        UIView.animate(withDuration: 0.1) { [weak self] in
            self?.myCircle.frame = frame
            self?.myCircle.backgroundColor = UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1)
        }
    }
    
    @IBAction func buttonDownPressed(_ sender: Any)
    {
        var frame = self.myCircle.frame
        frame.origin = CGPoint(x: frame.origin.x, y: frame.origin.y + self.offset)
        let buttonFrames = [self.buttonDown.frame, self.buttonUp.frame, self.buttonRight.frame, self.buttonLeft.frame]
        if self.screenContains(rect: frame) && frame.hasIntersectionWith(buttonFrames) == false
        {
            UIView.animate(withDuration: 0.1) { [weak self] in
                self?.myCircle.frame = frame
            }
        }
    }
    
    @IBAction func buttonUpPressed(_ sender: Any)
    {
        var frame = self.myCircle.frame
        frame.origin = CGPoint(x: frame.origin.x, y: frame.origin.y - self.offset)
        let buttonFrames = [self.buttonDown.frame, self.buttonUp.frame, self.buttonRight.frame, self.buttonLeft.frame]
        if self.screenContains(rect: frame) && frame.hasIntersectionWith(buttonFrames) == false
        {
            UIView.animate(withDuration: 0.1) { [weak self] in
                self?.myCircle.frame = frame
            }
        }
    }
    
    @IBAction func buttonLeftPressed(_ sender: Any)
    {
        var frame = self.myCircle.frame
        frame.origin = CGPoint(x: frame.origin.x - self.offset, y: frame.origin.y)
        let buttonFrames = [self.buttonDown.frame, self.buttonUp.frame, self.buttonRight.frame, self.buttonLeft.frame]
        if self.screenContains(rect: frame) && frame.hasIntersectionWith(buttonFrames) == false
        {
            UIView.animate(withDuration: 0.1) { [weak self] in
                self?.myCircle.frame = frame
            }
        }
    }
    
    @IBAction func buttonRightPressed(_ sender: Any)
    {
        var frame = self.myCircle.frame
        frame.origin = CGPoint(x: frame.origin.x + self.offset, y: frame.origin.y)
        let buttonFrames = [self.buttonDown.frame, self.buttonUp.frame, self.buttonRight.frame, self.buttonLeft.frame]
        if self.screenContains(rect: frame) && frame.hasIntersectionWith(buttonFrames) == false
        {
            UIView.animate(withDuration: 0.1) { [weak self] in
                self?.myCircle.frame = frame
            }
        }
    }
}

