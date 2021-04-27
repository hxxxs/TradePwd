//
//  TradePassword.swift
//  TradePwd
//
//  Created by LL on 2019/12/10.
//  Copyright © 2019 hxxxxs. All rights reserved.
//

import UIKit

open class TradePassword: UIView {
    
    public enum ClosureEvent {
        case submit
        case close
        case forgetPwd
    }
    
    static public func show(completion: @escaping (ClosureEvent, String) -> Void) {
        let v = TradePassword(frame: UIScreen.main.bounds)
        v.tradeInputView.completion = {[weak v] text in
            v?.removeFromSuperview()
            completion(.submit, text)
        }
        v.closure = completion
        
        UIApplication.shared.windows.first?.addSubview(v)
    }
    
    public var closure: ((ClosureEvent, String) -> Void)?
    
    private lazy var topView: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor(white: 0, alpha: 0.3)
        btn.addTarget(self, action: #selector(closeClick), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private lazy var contentView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.white
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.text = "请输入交易密码"
        l.textColor = UIColor(red: 0x66 / 0xff, green: 0x66 / 0xff, blue: 0x66 / 0xff, alpha: 1)
        l.font = UIFont.systemFont(ofSize: 17)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private lazy var topLine: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor(red: 0xf0 / 0xff, green: 0xf0 / 0xff, blue: 0xf0 / 0xff, alpha: 1)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private lazy var closeButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("×", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        btn.setTitleColor(UIColor(red: 0x66 / 0xff, green: 0x66 / 0xff, blue: 0x66 / 0xff, alpha: 1), for: .normal)
        btn.addTarget(self, action: #selector(closeClick), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private lazy var tradeInputView = TextEntryView()
    
    private lazy var forgetPwdButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("忘记密码?", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn.setTitleColor(UIColor(red: 0x66 / 0xff, green: 0x66 / 0xff, blue: 0x66 / 0xff, alpha: 1), for: .normal)
        btn.addTarget(self, action: #selector(forgetPasswordClick), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configUI()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configUI()
    }
    
    @objc private func forgetPasswordClick(_ button: UIButton) {
        removeFromSuperview()
        closure?(.forgetPwd, "")
    }
    
    @objc private func closeClick(_ button: UIButton) {
        removeFromSuperview()
        closure?(.close, "")
    }
    
    private func configUI() {
        backgroundColor = .clear
        addSubview(topView)
        addSubview(contentView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(topLine)
        contentView.addSubview(closeButton)
        contentView.addSubview(tradeInputView)
        contentView.addSubview(forgetPwdButton)
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        topView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        topView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        topView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        
        contentView.topAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        contentView.heightAnchor.constraint(equalToConstant: 500).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        topLine.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15).isActive = true
        topLine.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15).isActive = true
        topLine.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15).isActive = true
        topLine.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
        closeButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        closeButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
        
        tradeInputView.topAnchor.constraint(equalTo: topLine.bottomAnchor, constant: 15).isActive = true
        tradeInputView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 30).isActive = true
        tradeInputView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -30).isActive = true
        tradeInputView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        forgetPwdButton.topAnchor.constraint(equalTo: tradeInputView.bottomAnchor, constant: 15).isActive = true
        forgetPwdButton.rightAnchor.constraint(equalTo: tradeInputView.rightAnchor).isActive = true
    }
}

open class TextEntryView: UIView, UITextFieldDelegate {
    
    public var completion: ((String) -> Void)?
    public var isSecureTextEntry = true
    
    private var textField: UITextField = {
        let tf = UITextField()
        tf.textColor = .clear
        tf.tintColor = .clear
        tf.layer.borderColor = UIColor(red: 0xe7 / 0xff, green: 0xe7 / 0xff, blue: 0xe7 / 0xff, alpha: 1).cgColor
        tf.layer.borderWidth = 1
        tf.keyboardType = .numberPad
        tf.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private var lineLayers = [CALayer]()
    
    private lazy var displayView: UIStackView = {
        let v = UIStackView()
        v.axis = .horizontal
        for i in 0...5 {
            let l = UILabel()
            l.textColor = UIColor.black
            l.textAlignment = .center
            l.font = UIFont.systemFont(ofSize: 25)
            v.addArrangedSubview(l)
        }
        v.distribution = .fillEqually
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configUI()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configUI()
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        textField.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        textField.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        textField.topAnchor.constraint(equalTo: topAnchor).isActive = true
        textField.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        displayView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        displayView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        displayView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        displayView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        let w = bounds.width / 6
        let h = bounds.height
        for (i, layer) in lineLayers.enumerated() {
            layer.frame = CGRect(x: CGFloat(i + 1) * w, y: 0, width: 1, height: h)
        }
    }
    
    private func configUI() {
        let borderColor = UIColor(red: 0xe7 / 0xff, green: 0xe7 / 0xff, blue: 0xe7 / 0xff, alpha: 1).cgColor
        translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        addSubview(textField)
        
        textField.becomeFirstResponder()
        
        for _ in 0...4 {
            let lineLayer = CALayer()
            lineLayer.backgroundColor = borderColor
            textField.layer.addSublayer(lineLayer)
            lineLayers.append(lineLayer)
        }
        
        textField.addSubview(displayView)
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else { return }
        _ = displayView.arrangedSubviews.map { ($0 as! UILabel).text = "" }
        
        if isSecureTextEntry {
            for i in 0..<text.count {
                (displayView.arrangedSubviews[i] as! UILabel).text = "●"
            }
        } else {
            for (i, s) in text.enumerated() {
                (displayView.arrangedSubviews[i] as! UILabel).text = "\(s)"
            }
        }
        
        if text.count == 6 {
            completion?(text)
        }
    }

    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text as NSString? else { return true }
        return text.replacingCharacters(in: range, with: string).count <= 6
    }
}
