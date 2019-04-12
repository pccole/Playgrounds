//: [Previous](@previous)

import Foundation

protocol Distribution {
    associatedtype Value
    
    func sample<G: RandomNumberGenerator>(using generator: inout G) -> Value
    func sample<G: RandomNumberGenerator>(count: Int, using generator: inout G) -> [Value]
}

extension Distribution {
    func sample() -> Value {
        var g = SystemRandomNumberGenerator()
        return sample(using: &g)
    }
    
    func sample(count: Int) -> [Value] {
        var g = SystemRandomNumberGenerator()
        return sample(count: count, using: &g)
    }
    
    func sample<G: RandomNumberGenerator>(count: Int, using generator: inout G) -> [Value] {
        var g = SystemRandomNumberGenerator()
        return (1...count).map { _ in sample(using: &g) }
    }
}

struct UniformDistribution: Distribution {
    typealias Value = Int
    
    var range: ClosedRange<Int>
    
    init(range: ClosedRange<Int>) {
        self.range = range
    }
    
    func sample<G>(using generator: inout G) -> Int where G : RandomNumberGenerator {
        return Int.random(in: range, using: &generator)
    }
}

let d6 = UniformDistribution(range: 1...6)
d6.sample()


struct NormalDistribution: Distribution {
    
    
    typealias Value = Double
    
    var mean, stdDev: Double
    
    private func generateRandomUniforms() -> (Double, Double) {
        let u1 = Double.random(in: Double.leastNormalMagnitude..<1.0)
        let u2 = Double.random(in: Double.leastNormalMagnitude..<1.0)
        return (u1, u2)
    }
    
    func sample() -> Double {
        let (u1, u2) = generateRandomUniforms()
        let z0 = (-2.0 * log(u1).squareRoot() * cos(2 * .pi * u2))
        return z0 * stdDev + mean
    }
    
    func sample<G: RandomNumberGenerator>(using generator: inout G) -> Double {
        let u1 = Double.random(in: Double.leastNormalMagnitude..<1.0, using: &generator)
        let u2 = Double.random(in: Double.leastNormalMagnitude..<1.0, using: &generator)
        let z0 = (-2.0 * log(u1).squareRoot() * cos(2 * .pi * u2))
        return z0 * stdDev + mean

    }
    
    func sample(count: Int) -> [Double] {
        precondition(count > 0, "count must be greater than zero")
        var result: [Double] = []
        result.reserveCapacity(count)
        
        for _ in 1...count/2 {
            let (u1, u2) = generateRandomUniforms()
            let z0 = (-2.0 * log(u1)).squareRoot() * cos(2 * .pi * u2)
            let z1 = (-2.0 * log(u1)).squareRoot() * sin(2 * .pi * u2)
            result.append(z0 * stdDev + mean)
            result.append(z1 * stdDev + mean)
        }
        
        if count % 2 == 1 {
            result.append(sample())
        }
        return result
    }
}

let iq = NormalDistribution(mean: 100, stdDev: 15)
iq.sample(count: 100)


// if you add a non-static associatedtype to the protocol even if the type is Self you can only use that
// protocol as a generic constraint



//: [Next](@next)
