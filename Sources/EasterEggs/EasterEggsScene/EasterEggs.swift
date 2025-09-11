
import CoreMotion
import SpriteKit

@MainActor final class EasterEggsScene: SKScene {
    
    private let motionManager = CMMotionManager()
    private let month = NSCalendar.current.component(.month, from: Date())
    private let day = NSCalendar.current.component(.day, from: Date())
    
    private var eggsStyle: EggsStyle = .christmas
    
    var scoreLabel: SKLabelNode!
    
    var score: Int = 0 {
        didSet { scoreLabel.text = "Score: \(score)" }
    }
    
    override func didMove(to view: SKView) {
        motionManager.startAccelerometerUpdates()
        addBackgraund()
        addScoreLabel()
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        addEgg(location)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            addEgg(location)
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        setupGravity()
    }
    
    private func addBackgraund() {
        let background = SKSpriteNode(texture: SKTexture(image: UIImage(named: eggsStyle.backgroundImage, in: .module, with: nil)!))
        background.size = self.frame.size
        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        background.zPosition = -1
        addChild(background)
        
        if eggsStyle == .christmas {
            if let snow = SKEmitterNode(fileNamed: "Snow.sks") {
                snow.position = CGPointMake(CGRectGetMidX(self.frame), self.frame.height)
                addChild(snow)
            }
        }
    }
    
    private func addScoreLabel() {
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.text = "Score: 0"
        scoreLabel.horizontalAlignmentMode = .center
        scoreLabel.zPosition = 1
        scoreLabel.position = CGPoint(x: size.width / 2, y: size.height - size.height / 10)
        addChild(scoreLabel)
    }
    
    
    private func addEgg(_ location: CGPoint) {
        let egg = generateEgg(location)
        addChild(egg)
        score += 1
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            egg.removeFromParent()
            self.score -= 1
        }
    }
    
    private func generateEgg(_ location: CGPoint) -> SKSpriteNode {
        let egg =  SKSpriteNode(texture: SKTexture(image: UIImage(named: randomEggName(), in: .module, with: nil)!))
        egg.name = "egg"
        egg.position = location
        egg.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 32, height: 36))
        egg.physicsBody?.restitution = 0.0
        egg.size = CGSize(width: 50, height: 50)
        egg.position.x = location.x
        egg.position.y = location.y
        return egg
    }
    
    private func setupGravity() {
        if let accelerometerData = motionManager.accelerometerData {
            physicsWorld.gravity = CGVector(
                dx: accelerometerData.acceleration.x * 12,
                dy: accelerometerData.acceleration.y * 12
            )
        }
    }
    
    private func randomEggName() -> String {
        if eggsStyle == .christmas {
            return "egg\(Int.random(in: 1...11))-\(eggsStyle.rawValue)"
        } else {
            return "egg\(Int.random(in: 1...10))-\(eggsStyle.rawValue)"
        }
    }
}

class SnowFall: SKScene {
    override func sceneDidLoad() {
        size = UIScreen.main.bounds.size
        scaleMode = .aspectFill
        anchorPoint = CGPoint(x: 0.5, y: 1)
        backgroundColor = .clear
        let node = SKEmitterNode(fileNamed: "Snow.sks")!
        addChild(node)
    }
}
