//
//  ViewController.swift
//  ThirdLesson
//
//  Created by Максим Окунеев on 09.07.2023.
//

import UIKit


//На экране квадратная вью и слайдер. Вью перемещается из левого края в правый с поворотом и увеличением.
//
//- В конечной точке вью должна быть справа (минус отступ), увеличится в 1.5 раза и повернуться на 90 градусов.
//- Когда отпускаем слайдер, анимация идет до конца с текущего места.
//- Слева и справа отступы layout margins. Отступ как для квадратной вью, так и для слайдера.

class ViewController: UIViewController {
    
    lazy var backView: UIView = {
        let view = UIView()
         return view
    }()
    
    lazy var lessonView: UIView = {
       let view = UIView()
    
        view.layer.cornerRadius = 5
        view.backgroundColor = .blue

        
        return view
    }()
    
    lazy var slider: UISlider = {
        let slider = UISlider()
        slider.isContinuous = true
     
        slider.addTarget(self, action: #selector(valueChanged), for: .valueChanged)
        slider.addTarget(self, action: #selector(touchUpOutside), for: .touchUpInside)

        return slider
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
       
        setupView()
    }
    
    func setupView() {
        self.view.addSubview(backView)
        backView.addSubview(lessonView)
        backView.addSubview(slider)
       
        backView.translatesAutoresizingMaskIntoConstraints = false
        lessonView.translatesAutoresizingMaskIntoConstraints = false
        slider.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            backView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            backView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            backView.heightAnchor.constraint(equalToConstant: 300),
         
            
            lessonView.topAnchor.constraint(equalTo: backView.topAnchor, constant: 50),
            lessonView.leftAnchor.constraint(equalTo: backView.leftAnchor),
            lessonView.widthAnchor.constraint(equalToConstant: 80),
            lessonView.heightAnchor.constraint(equalToConstant: 80),
            
            slider.topAnchor.constraint(equalTo: view.topAnchor, constant: 225),
            slider.leftAnchor.constraint(equalTo: backView.leftAnchor),
            slider.rightAnchor.constraint(equalTo: backView.rightAnchor)

        ])
    }
    
    @objc func valueChanged() {
        startAnimation()
    }
    
    @objc func touchUpOutside() {
        if self.slider.value != 1 {
            self.slider.setValue(1, animated: true)
            startAnimation()
        }
    }
    
    func startAnimation() {
        UIView.animate(withDuration: 1) {
            let rotate = CGAffineTransformMakeRotation(CGFloat(self.slider.value * .pi/2))
            let scaleAndRotate = rotate
                .scaledBy(
                    x: 1 + (0.5 * CGFloat(self.slider.value)),
                    y: 1 + (0.5 * CGFloat(self.slider.value))
                )
            self.lessonView.transform = scaleAndRotate
            
            let width = self.backView.frame.width - 100
            
            self.lessonView.layer.position = CGPoint(x: CGFloat(self.slider.value) * width + 40, y: 100)
        }
    }
}
