
object part2 {
  
  def main(args: Array[String]) {
    val t1 = Node(new A(10), List(Node(new A(9), List(Leaf(new A(7)), 
                                  Leaf(new A(6)))), Node(new A(8), 
                                  List(Leaf(new A(5)), Leaf(new A(4))))))
    println("t1 = "+t1)
 //  println("breadthFirst(t1) =" + breadthFirst(t1))
    println("sumTreeA(t1) = " + sumTreeA(t1));
    val t2 = t1.map((a:A)=>new A(a.value*2))
    println("t2 = "+t2)
//    println("breadthFirst(t2) =" + breadthFirst(t2))
    println("sumTreeA(t2) = " + sumTreeA(t2));
    val t3 = Node(new B(5,5), List(Node(new B(5,4), List(Leaf(new B(3,4)), 
                                  Leaf(new B(1,5)))), Node(new B(4,4), 
                                   List(Leaf(new B(3,2)), Leaf(new B(4,0))))))
    println("t3 = "+t3)
//    println("breadthFirst(t3) =" + breadthFirst(t3))
    println("sumTreeA(t3) = " + sumTreeA(t3));
  }
  
  //def breadthfirst[T](t : Tree[T]): List[T]{
  //val newL = List[T]()
  
//    def breadthfirst[T](t : Tree[T]): List[T] = t match{
//      case (Leaf(x))  => x
//      case (Node(x, children)) => x    
//      
//
//    }
  //}
  def reduce[T] (f:(T,T)=>T,b:T,L:List[T]):T = L match {
    case (x::xs) => f(x,reduce[T](f,b,xs))
    case _ => b
}
  
def sumTreeA(t: Tree[A]):A = t match {
  case (Leaf(x)) => x
  case (Node(x,children)) => x + (reduce[A](((y:A,z:A)=>y + z),new A(0),children.map((p:Tree[A])=>sumTreeA(p))))
  }
}

abstract class Tree[+T]{
  def map[B](f: T => B): Tree[B]
}

case class Leaf[+T](x : T) extends Tree[T]{
  
  override def toString() = "Leaf (" + x + ")";
  override def map[B](f: T => B): Tree[B] = Leaf(f(x))  
  
}

case class Node[T](x:T, children:List[Tree[T]]) extends Tree[T]{
  override def toString() = "Node("+ x + "," + children.toString() + ")"
  override def map[T2](f: T => T2): Tree[T2] = Node(f(x), children.map((c: Tree[T]) => c.map(f)))
  }

class A(x:Int) {
  def value = x
  def +(other:A):A = new A(value + other.value)
  override def toString() = "A("+ x + ")"
  }

class B(x:Int, y:Int) extends A(x+y) {
  override def value = x + y;
  override def toString() = "B("+ x + "," + y + ")"
}







