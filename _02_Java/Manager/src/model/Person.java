package model;

public class Person {
    private String fullName;
    private int age;
    private String address;

    public Person() {
    }

    public Person(String fullName, int age, String address) {
        this.fullName = fullName;
        this.age = age;
        this.address = address;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    @Override
    public String toString() {
        return "Person{" +
                "fullName='" + fullName + '\'' +
                ", age=" + age +
                ", address='" + address + '\'' +
                '}';
    }
}
