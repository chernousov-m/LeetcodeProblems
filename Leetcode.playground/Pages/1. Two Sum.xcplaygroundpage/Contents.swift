import Foundation

class Solution {
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        var dictionary: [Int: Int] = [:]
        for (idx, num) in nums.enumerated() {
            if let index = dictionary[target - num] {
                return [index, idx]
            } else {
                dictionary[num] = idx
            }
        }
        return []
    }
}
