//: [Previous](@previous)
//: ### A Generic Function
//: The following exercises will use the `printIfUIResponder` function.
//:
func printIfUIResponder<T: UIResponder>(_ argument: T) {
    print(type(of: argument))
}

//: - Callout(Exercise):
//: Which of the following invocations will cause a compiler error? Make an educated guess before removing the comment annotations!
//:
import UIKit


printIfUIResponder(UIView())
// printIfUIResponder(UIFont())
printIfUIResponder(UILabel())

//: [Next](@next)
