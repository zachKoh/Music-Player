//
//  AbstractPlayerViewController.swift
//
//  Created by Admin on 14/02/2024.
//

import UIKit

class AbstractPlayerViewController: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Usage example:
        let randomString = "Always"
        let imageSize = CGSize(width: 200, height: 200)

        if let generatedImage = generateImage(from: randomString, size: imageSize) {
            // Use the generated image
            // For example, display it in an image view
            let imageView = UIImageView(image: generatedImage)
            image.addSubview(imageView)
        } else {
            print("Failed to generate image")
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        //Initial colors
        gradientLayer.colors = [UIColor.black.cgColor, UIColor.darkGray.cgColor]
        
        let string = "Daniel Caesar"
        
        let newColors = [
            generateColor(from: string),
            generateColorUsingFNV1a(from: string)
        ]

        gradientLayer.setColors(newColors,
                                animated: true,
                                withDuration: 2,
                                timingFunctionName: .linear)

        view.layer.insertSublayer(gradientLayer, at:0)
    }
    
    func generateImage(from string: String, size: CGSize) -> UIImage? {
        // Create a graphics context
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        defer { UIGraphicsEndImageContext() }
        
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        
        // Use a hash function to generate a numeric value from the string data (DJB2 hash function)
        let data = string.data(using: .utf8)!
        var hashValue: UInt64 = 5381
        for byte in data {
            hashValue = 127 * (hashValue & 0x00ffffffffffffff) + UInt64(byte)
        }
        
        // Use the hash value to determine drawing parameters
        let randomRed = CGFloat((hashValue & 0xFF0000) >> 16) / 255.0
        let randomGreen = CGFloat((hashValue & 0x00FF00) >> 8) / 255.0
        let randomBlue = CGFloat(hashValue & 0x0000FF) / 255.0
        
        let randomColor = UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
        
        // Set the fill color
        context.setFillColor(randomColor.cgColor)
        
        // Draw a rectangle filling the entire context
        context.fill(CGRect(origin: .zero, size: size))
        
        // Use hash components to determine the number and type of shapes
        let numberOfShapes = Int((hashValue & 0xFF) % 5) + 10 // Random number of shapes (1 to 5)
        
        for i in 0..<numberOfShapes {
            let shapeType = Int((hashValue & 0x0F) % 3) // Determine shape type (0: circle, 1: square, 2: triangle)
            
            let shapeSize = CGFloat((hashValue & 0xFFF) % 50) + 20 // Random shape size (20 to 70)
            let xPos = CGFloat((hashValue >> 16) % UInt64(size.width - shapeSize) + UInt64(3^i))
            let yPos = CGFloat((hashValue >> 32) % UInt64(size.height - shapeSize) + UInt64(3^i))
            
            let shapeRect = CGRect(x: xPos, y: yPos, width: shapeSize, height: shapeSize)
            
            switch shapeType {
            case 0:
                context.setFillColor(UIColor.white.cgColor)
                context.fillEllipse(in: shapeRect)
            case 1:
                context.setFillColor(UIColor.black.cgColor)
                context.fill(shapeRect)
            case 2:
                let trianglePath = UIBezierPath()
                trianglePath.move(to: CGPoint(x: shapeRect.midX, y: shapeRect.minY))
                trianglePath.addLine(to: CGPoint(x: shapeRect.minX, y: shapeRect.maxY))
                trianglePath.addLine(to: CGPoint(x: shapeRect.maxX, y: shapeRect.maxY))
                trianglePath.close()
                context.setFillColor(UIColor.gray.cgColor)
                context.addPath(trianglePath.cgPath)
                context.fillPath()
            default:
                break
            }
        }
        
        // Create an image from the context
        let image = UIGraphicsGetImageFromCurrentImageContext()
        return image
    }
    
    func generateColor(from string: String) -> CGColor {
        let data = string.data(using: .utf8)!
        
        // Use a hash function to generate a numeric value from the string data (DJB2 hash function)
        var hashValue: UInt64 = 5381
        for byte in data {
            hashValue = 127 * (hashValue & 0x00ffffffffffffff) + UInt64(byte)
        }
        
        // Use the hash value to determine color components
        let red = CGFloat((hashValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hashValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(hashValue & 0x0000FF) / 255.0
        
        let color = UIColor(red: red, green: green, blue: blue, alpha: 1.0).cgColor
        return color
    }
    
    func generateColorUsingFNV1a(from string: String) -> CGColor {
        let data = string.data(using: .utf8)!
        
        // Use FNV-1a hash function to generate a numeric value from the string data
        var hash: UInt64 = 14695981039346656037
        let fnvPrime: UInt64 = 1099511628211
        
        for byte in data {
            hash ^= UInt64(byte)
            hash = hash &* fnvPrime
        }
        
        // Use the hash value to determine color components
        let red = CGFloat((hash & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hash & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(hash & 0x0000FF) / 255.0
        
        let color = UIColor(red: red, green: green, blue: blue, alpha: 1.0).cgColor
        return color
    }

}

extension CAGradientLayer {
    
    func setColors(_ newColors: [CGColor],
                   animated: Bool = true,
                   withDuration duration: TimeInterval = 0,
                   timingFunctionName name: CAMediaTimingFunctionName? = nil) {
        
        if !animated {
            self.colors = newColors
            return
        }
        
        let colorAnimation = CABasicAnimation(keyPath: "colors")
        colorAnimation.fromValue = colors
        colorAnimation.toValue = newColors
        colorAnimation.duration = duration
        colorAnimation.isRemovedOnCompletion = false
        colorAnimation.fillMode = CAMediaTimingFillMode.forwards
        colorAnimation.timingFunction = CAMediaTimingFunction(name: name ?? .linear)

        add(colorAnimation, forKey: "colorsChangeAnimation")
    }
}
