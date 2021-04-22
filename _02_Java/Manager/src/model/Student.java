package model;

public class Student extends Person {
    private float gpa;

    public Student() {
    }

    public Student(String fullName, int age, String address, float gpa) {
        super(fullName, age, address);
        this.gpa = gpa;
    }

    public float getGpa() {
        return gpa;
    }

    public void setGpa(float gpa) {
        this.gpa = gpa;
    }

    @Override
    public String toString() {
        return super.toString() + " / Student{" +
                "gpa=" + gpa +
                '}';
    }
}
