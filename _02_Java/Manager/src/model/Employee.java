package model;

public class Employee {
    private int id;
    private String lastName;
    private String firstName;
    private float salary;

    public Employee(){
    }

    public Employee(int id, String lastName, String firstName, float salary) {
        this.id = id;
        this.lastName = lastName;
        this.firstName = firstName;
        this.salary = salary;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public float getSalary() {
        return salary;
    }

    public void setSalary(float salary) {
        this.salary = salary;
    }

    public String getFullName(){
        return firstName + " " + lastName;
    }

    @Override
    public String toString() {
        return "Employee{" +
                "id = " + id +
                ", fullName = " + getFullName() +
                ", salary = " + salary +
                '}';
    }
}
