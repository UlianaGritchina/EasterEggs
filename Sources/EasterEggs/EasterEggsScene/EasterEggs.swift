
import CoreMotion
import SpriteKit

@MainActor final class EasterEggsScene: SKScene {
    
    private let motionManager = CMMotionManager()
    private let month = Calendar.current.component(.month, from: Date())
    private let day = Calendar.current.component(.day, from: Date())
    
    private let sceneStyle: SceneStyle
    
    var scoreLabel: SKLabelNode!
    
    override init(size: CGSize = CGSize(width: 300, height: 300)) {
        self.sceneStyle = .base
        super.init(size: size)
    }
    
    init(size: CGSize = CGSize(width: 300, height: 300), sceneStyle: SceneStyle) {
        self.sceneStyle = sceneStyle
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.sceneStyle = .base
        super.init(coder: aDecoder)
    }
    
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
        let background = SKSpriteNode(texture: SKTexture(image: UIImage(named: sceneStyle.backgroundImage, in: .module, with: nil)!))
        background.size = self.frame.size
        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        background.zPosition = -1
        addChild(background)
        
        if sceneStyle == .christmas {
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
        let egg = SKSpriteNode(texture: SKTexture(image: UIImage(named: randomEggName(), in: .module, with: nil)!))
        egg.name = "egg"
        egg.position = location
        egg.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 27, height: 31))
        egg.physicsBody?.restitution = 0.0
        egg.size = CGSize(width: 45, height: 45)
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
        switch sceneStyle {
        case .base, .winter, .spring, .summer, .autumn:
            "egg\(Int.random(in: 1...10))-base"
        case .halloween:
            "egg\(Int.random(in: 1...10))-\(sceneStyle.rawValue)"
        case .christmas:
            "egg\(Int.random(in: 1...11))-\(sceneStyle.rawValue)"
        }
    }
}

class SnowFallScene: SKScene {
    override func sceneDidLoad() {
        size = UIScreen.main.bounds.size
        scaleMode = .aspectFill
        anchorPoint = CGPoint(x: 0.5, y: 1)
        backgroundColor = .clear
        let node = SKEmitterNode(fileNamed: "Snow.sks")!
        addChild(node)
    }
}
