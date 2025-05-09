package myBeans;

public class Counter {
	private int count=0;
	public Counter() {}
		public void setCounter(int count) {
			this.count=count;
		}
		public int getCounter() {
			return ++count;
		}
	

}
