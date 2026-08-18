import CoreMotion
import SpriteKit

@MainActor
final class EasterEggsScene: SKScene {

    // MARK: Constants

    private let motionManager = CMMotionManager()
    private let sceneStyle: SceneStyle

    // MARK: Variables

    private var lastExplosionTime: TimeInterval = 0

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
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
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
        addEgg(touch.location(in: self))
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            addEgg(touch.location(in: self))
        }
    }

    override func update(_ currentTime: TimeInterval) {
        setupGravity()
        checkForShake(currentTime)
    }

    // MARK: Gravity

    private func setupGravity() {
        guard let data = motionManager.accelerometerData else { return }

        physicsWorld.gravity = CGVector(
            dx: data.acceleration.x * 12,
            dy: data.acceleration.y * 12
        )
    }

    // MARK: Shake Detection

    private func checkForShake(_ currentTime: TimeInterval) {
        guard currentTime - lastExplosionTime > 2 else { return }
        guard let data = motionManager.accelerometerData else { return }

        let x = data.acceleration.x
        let y = data.acceleration.y
        let z = data.acceleration.z

        let magnitude = sqrt(x * x + y * y + z * z)

        guard magnitude > 2.2 else { return }

        lastExplosionTime = currentTime
        
        Task {
            try await Task.sleep(nanoseconds: 1_000_000_000)
            explodeEggs()
        }
    }

    // MARK: Background

    private func addBackground() {
        guard let uiImage = UIImage(
            named: sceneStyle.backgroundImage,
            in: sceneStyle.isCustom ? .main : .module,
            with: nil
        ) else {
            return
        }

        let background = SKSpriteNode(texture: SKTexture(image: uiImage))
        background.size = frame.size
        background.position = CGPoint(
            x: frame.midX,
            y: frame.midY
        )
        background.zPosition = -1

        addChild(background)

        if sceneStyle == .christmas {
            addSnowfall()
        }
    }

    private func addScoreLabel() {
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.text = "Score: 0"
        scoreLabel.horizontalAlignmentMode = .center
        scoreLabel.position = CGPoint(
            x: size.width / 2,
            y: size.height - size.height / 10
        )
        scoreLabel.zPosition = 1

        addChild(scoreLabel)
    }

    // MARK: Eggs

    private func addEgg(_ location: CGPoint) {
        let egg = generateEgg(location)

        addChild(egg)
        score += 1

        DispatchQueue.main.asyncAfter(deadline: .now() + 10) { [weak self, weak egg] in
            guard
                let self,
                let egg,
                egg.parent != nil
            else {
                return
            }

            egg.removeFromParent()
            self.score -= 1
        }
    }

    private func generateEgg(_ location: CGPoint) -> SKSpriteNode {
        guard let uiImage = UIImage(
            named: randomEggName(),
            in: sceneStyle.isCustom ? .main : .module,
            with: nil
        ) else {
            return SKSpriteNode()
        }

        let egg = SKSpriteNode(texture: SKTexture(image: uiImage))

        egg.name = "egg"
        egg.size = CGSize(width: 45, height: 45)
        egg.position = location

        egg.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 27, height: 31))
        egg.physicsBody?.restitution = 0
        egg.physicsBody?.allowsRotation = true

        return egg
    }

    private func randomEggName() -> String {
        sceneStyle.easterEggsImagesSet.randomElement() ?? ""
    }

    // MARK: Explosion

    private func explodeEggs() {
        enumerateChildNodes(withName: "egg") { node, _ in
            guard let body = node.physicsBody else { return }

            let impulse = CGVector(
                dx: CGFloat.random(in: -25...25),
                dy: CGFloat.random(in: 15...40)
            )

            body.applyImpulse(impulse)
            body.applyAngularImpulse(CGFloat.random(in: -5...5))
        }
        score = 0
    }
}
