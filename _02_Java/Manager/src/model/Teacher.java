package model;

public class Teacher extends Person {
    private float salary;

    public Teacher() {
    }

    public Teacher(String fullName, int age, String address, float salary) {
        super(fullName, age, address);
        this.salary = salary;
    }

    public float getSalary() {
        return salary;
    }

    public void setSalary(float salary) {
        this.salary = salary;
    }

    @Override
    public String toString() {
        return super.toString() + " / Teacher{" +
                "salary=" + salary +
                '}';
    }
}
