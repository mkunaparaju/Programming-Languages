
import java.util.ArrayList;
import java.util.Iterator;

/**
 * @author mkunaparaju
 *
 */

public class Part1 {
	static void test() {
		ASet<A> s1 = new MySet<A>();
		for(int i = 0; i < 6; i += 2) {
		    s1.add(new A(i));
		    s1.add(new A(i*2));
		}
		System.out.println("s1 = "+ s1);
		System.out.println("pow(s1) =" + powerSet(s1));

		ASet<A> s2 = new MySet<A>();
		s2.add(new B(1,2));
		s2.add(new B(2,2));
		s2.add(new B(3,3));
		System.out.println("s2 = " + s2);
		System.out.println("s1.union(s2) = " + s1.union(s2));
		System.out.println("s1.difference(s2) = " + s1.difference(s2));
		System.out.println("s1.intersection(s2) = " + s1.intersection(s2));
		ASet<A> s3 = s1.difference(s2);
		System.out.println("s3 = " + s3);
		System.out.println("s3.lessThan(s1) is " + s3.lessThan(s1));
		System.out.println("s1.subset(s1) is " + s1.subset(s1));
		System.out.println("s1.lessThan(s1) is " + s1.lessThan(s1));
		System.out.println("s1.equalTo(s1.union(s1)) is " + s1.equalTo(s1.union(s1)));
		ASet<A> s4 = new MySet<A>();
		s4.add(new A(3));	
		s4.add(new A(4));
		s4.add(new A(6));
		System.out.println(s2 + " equalTo " + s4 + " is " + s2.equalTo(s4));
	    }


	    public static void main(String[] args) {
		test();
	    }
	    	
//	    static <T extends LessOrEqual<T>> ASet<ASet<T>> powerSet(ASet<T> s) {
//	      	ASet<ASet<T>> powerSet = new MySet<ASet<T>>();
//	    	powerSet.add(new MySet<T>());
//	    	Iterator<T> it = s.iterator();
//	    	
//	    	while(it.hasNext())
//	    	{
//	    		T elem = it.next();
//	    		ASet<ASet<T>> newps = new MySet<ASet<T>>();
//	    		Iterator<ASet<T>> pit = powerSet.iterator();
//	    		while(pit.hasNext())
//	    		{
//	    			ASet<T> subset = pit.next(); 
//	    			newps.add(subset);
//	    			ASet<T> newsubset = subset;
//	    			newsubset.add(elem);
//	    			newps.add(newsubset);
//	    			
//	    		}
//	    		powerSet = newps;
//	    		
//	    	}	
//	    	return powerSet; 
//	    
//	    }
	    
	    static <T extends LessOrEqual<T>> ASet<ASet<T>> powerSet(ASet<T> s) {
	    
	    	ASet<ASet<T>> powerSet = new MySet<ASet<T>>();
//	    	powerSet.add(new MySet<T>());
	    	powerSet.add(s);
	    	//System.out.println(powerSet);
	    	Iterator<ASet<T>> pit = powerSet.iterator();	
	    	Iterator<T> it = s.iterator();
	    	
	    	while(it.hasNext())
	    	{
	    		T inElem = it.next();
	    		ASet<ASet<T>> newps = new MySet<ASet<T>>();
	    		
	    		while(pit.hasNext())
	    		{
	    			ASet<T> subset = pit.next();
	    			ASet<T> newss = subset;
	    			
	    			newss.add(inElem);
	    			newps.add(newss);
	    		}
	    		powerSet = newps; 		
	    	}	    	
	    	return powerSet;	 
	    }	
	    
	   
}

	    
	    
	    


interface LessOrEqual<T> {

	
	boolean lessThan(T x);
	boolean equalTo(T x);
}

interface ASet<T extends LessOrEqual<T>> extends LessOrEqual<ASet<T>>, Iterable<T>
{
	T get();
	void add(T x);
	boolean empty();
	boolean member(T x);
	boolean subset(ASet<T> x);
	ASet<T> union(ASet<T> x);
	ASet<T> intersection(ASet<T> x);
	ASet<T> difference(ASet<T> x);
	boolean lessThan(ASet<T> s1);
	boolean equalTo(ASet<T> s1);
}

class MySet<T extends LessOrEqual<T>> implements ASet<T>
{
	public ArrayList<T> mylist;
	public MySet()
	{
		mylist = new ArrayList<T>();

	}
	@Override
	public String toString()
	{
		String stmt = "";
		if(!mylist.isEmpty())
		{
			stmt = stmt + "[";
			for(int i =0; i< mylist.size(); i++)
			{
				 stmt = stmt + mylist.get(i) + " ";
			}
			stmt = stmt + "]";
		}
		return stmt;
	}
//	@Override
//	public boolean lessThan(T x) {
//		
//		return false;
//		//return (if(this < x) ? true : false);
//	}

	
//	@Override
//	public boolean equalTo(T x) {	
//            
//		return (this == x);
//	}
	

	
	@Override
	public Iterator<T> iterator() {
		// TODO Auto-generated method stub
		return mylist.iterator();
	}

	@Override
	public T get() {		
		return mylist.get(0);
	}

	@Override
	public void add(T x) {
		if(!member(x)){
            mylist.add(x);
         }
		
	}

	@Override
	public boolean empty() {
		
		return mylist.isEmpty();
	}

	@Override
	public boolean member(T x) {
		if(this.empty())
		{
			return false;
		}
            for(T e: mylist){
                if(e.equalTo(x)){
                    return true;
                }
            }
		return false;
	}

	@Override
	public boolean subset(ASet<T> x) {
		for (T e: this.mylist){
			//System.out.println("s3 " + e);
			Iterator<T> mylistiter = x.iterator();
			while(mylistiter.hasNext()){
				T a = mylistiter.next();
				//System.out.println("s1 " + a);
                if(!e.equalTo(a)){
                    return false;
                }
                else
                {
                	return true; 
                }
             }
        }
        return true;
	}

	@Override
	public ASet<T> union(ASet<T> x) {
		Iterator<T> mylistiter = x.iterator();
		ArrayList<T> newli = new ArrayList<T>();
		for(T e : this.mylist)
		{
			newli.add(e);
		}
		MySet<T> newMySet = new MySet<T>();
		newMySet.mylist = newli;
		while(mylistiter.hasNext())
		{
			T member =mylistiter.next(); 
			if(!newMySet.member(member)){
			newli.add(member);}
		}
		return newMySet;
	}

	@Override
	public ASet<T> intersection(ASet<T> x) {
        MySet<T> newset = new MySet<T>();       
        ArrayList<T> newli = this.mylist;
        for(T present : newli){
        	Iterator<T> mylistiter = x.iterator();
            while(mylistiter.hasNext()){
            	T nextelem =  mylistiter.next();       
                if(nextelem.equalTo(present)){
                    newset.add(nextelem);
                }
            }
            
}
return newset;
}
	@Override
	public ASet<T> difference(ASet<T> x) {
		MySet<T> newset = new MySet<T>();
		boolean check = false;
		for (T e : this)
		{
			if(!x.member(e))
			{
				newset.add(e);
			}
		}
		return newset;
	}
	@Override
	public boolean lessThan(ASet<T> s1) {
		if(this != s1)
		return this.subset(s1);
		else 
			return false;
	}
	@Override
	public boolean equalTo(ASet<T> s1) {
		return ((this.subset(s1)) && s1.subset(this));
	}
	
	
}


class A implements LessOrEqual<A>
{

		int x;
		public A(int x)
		{
			this.x = x;
		}
	
	@Override
	public boolean lessThan(A obj) {
		A newA = (A)obj;		
		return (this.x < newA.x);
	}
	@Override
	public boolean equalTo(A obj) {
		A newA = (A)obj;		
		return (this.x == newA.x);
	}
	
	@Override
	public String toString()
	{
		return "A[" + this.x + "]";
	}
}

class B extends A{
    private int x; 
    private int y;
    private int sum;
    public B(int x, int y) {
        super(x+y);
        this.x = x;
        this.y = y;
        this.sum = x+y;
    }
    
   
    public boolean lessThan(B elem) {
        if(this.sum<(elem.x+elem.y)){
            return true;
        }
        else{
            return false;
        }
    }

  
    public boolean equalTo(B elem) {
        if(this.sum==(elem.x+elem.y)){
            return true;
        }
        else{
            return false;
        }
    }
    
    public String toString()
    {
    	return "B(" + this.x + ", " + this.y + ")";
    }
   
}



