public class ListNode: ExpressibleByArrayLiteral {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
    
    public required init(arrayLiteral elements: Int...) {
        var firstNode: ListNode!
        var currentNode: ListNode!
        elements.forEach { value in
            if firstNode == nil {
                firstNode = ListNode(value)
                currentNode = firstNode
            } else {
                currentNode.next = .init(value)
                currentNode = currentNode.next
            }
        }
        self.val = firstNode.val
        self.next = firstNode.next
    }
}
 
class Solution {
    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        var l1 = l1
        var l2 = l2
        let seq = AnySequence {
            AnyIterator { () -> (Int?, Int?)? in
                let l1Value = l1?.val
                let l2Value = l2?.val
                l2 = l2?.next
                l1 = l1?.next
                if l1Value ?? l2Value != nil {
                    return (l1Value, l2Value)
                } else {
                    return nil
                }
            }
        }
        var carry = false
        var firstNode = ListNode?.none
        var currentNode = ListNode?.none
        seq
            .lazy
            .map { tuple in
                let (l1, l2) = tuple
                let value = (l1 ?? 0) + (l2 ?? 0) + (carry ? 1 : 0)
                carry = value >= 10
                return value % 10
            }
            .forEach { value in
                if firstNode == nil {
                    firstNode = ListNode(value)
                    currentNode = firstNode
                } else {
                    currentNode?.next = ListNode(value)
                    currentNode = currentNode?.next
                }
            }
        if carry {
            currentNode?.next = .init(1)
        }
        return firstNode
    }
}
