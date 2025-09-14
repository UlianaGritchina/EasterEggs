
import CoreMotion
import SpriteKit

@MainActor final class EasterEggsScene: SKScene {
    
    // MARK: Constants
    
    private let motionManager = CMMotionManager()
    private let sceneStyle: SceneStyle
    
    // MARK: Variables
    
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
    
    // MARK: Computed properties
    
    var score: Int = 0 {
        didSet { scoreLabel.text = "Score: \(score)" }
    }
    
    // MARK: Override methods
    
    override func didMove(to view: SKView) {
        motionManager.startAccelerometerUpdates()
        addBackground()
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
    
    private func setupGravity() {
        if let accelerometerData = motionManager.accelerometerData {
            physicsWorld.gravity = CGVector(
                dx: accelerometerData.acceleration.x * 12,
                dy: accelerometerData.acceleration.y * 12
            )
        }
    }
    
    private func addBackground() {
        if let uiImage = UIImage(named: sceneStyle.backgroundImage, in: sceneStyle.isCustom ? .main : .module, with: nil) {
            let background = SKSpriteNode(texture: SKTexture(image: uiImage))
            background.size = self.frame.size
            background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
            background.zPosition = -1
            addChild(background)
            
            if sceneStyle == .christmas {
                addSnowfall()
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
        if let uiImage = UIImage(
            named: randomEggName(),
            in: sceneStyle.isCustom ? .main : .module,
            with: nil
        ) {
            let egg = SKSpriteNode(texture: SKTexture(image: uiImage))
            egg.name = "egg"
            egg.position = location
            egg.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 27, height: 31))
            egg.physicsBody?.restitution = 0.0
            egg.size = CGSize(width: 45, height: 45)
            egg.position.x = location.x
            egg.position.y = location.y
            return egg
        } else {
            return SKSpriteNode()
        }
    }
    
    private func addSnowfall() {
        if let emitterPath: String = Bundle.module.path(forResource: "Snow", ofType: "sks"),
           let snowNode = NSKeyedUnarchiver.unarchiveObject(withFile: emitterPath) as? SKEmitterNode,
           let snowflakeImage = UIImage(named: "spark", in: .module, with: nil){
            snowNode.position = CGPointMake(CGRectGetMidX(self.frame), self.frame.height)
            snowNode.particleTexture = SKTexture(image: snowflakeImage)
            snowNode.name = "snowNode"
            snowNode.targetNode = self
            addChild(snowNode)
        }
    }
    
    private func randomEggName() -> String {
        sceneStyle.easterEggsImagesSet.randomElement() ?? ""
    }
}
