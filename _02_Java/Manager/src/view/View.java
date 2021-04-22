package view;

import model.Employee;
import model.Person;
import model.Student;
import model.Teacher;

import java.util.Arrays;

public class View {
    public static void main(String[] args) {
//        Bài 1a:
        System.out.println("Bài 1a:");
        Employee employee = new Employee(1, "Đặng", "Hoàng", 1000f);
        System.out.println(employee);
        System.out.println("====================================================================");

//        Bài 1b:
        System.out.println("Bài 1b:");
        Employee[] employees = new Employee[] {
                employee,
                new Employee(7,"Phan", "Trung", 800f),
                new Employee(3, "Dương", "Mạnh", 800f),
                new Employee(10, "Hoàng", "Khánh", 800f),
                new Employee(5, "Trần", "Hiệp", 800f),
                new Employee(6, "Nguyễn", "Bình", 800f),
                new Employee(2, "Nguyễn", "Khánh", 800f),
                new Employee(8, "Hồ", "Khanh", 800f),
                new Employee(9, "Huỳnh", "Quân", 1000f),
                new Employee(4, "Đậu", "Thùy", 1000f)
        };
        System.out.println("====================================================================");

//        Bài 1c: Sắp xếp tăng dần theo id
        System.out.println("Bài 1c:");
        Arrays.sort(employees, (e1, e2) -> e1.getId() - e2.getId());
        Arrays.stream(employees).forEach(System.out::println);
        System.out.println("====================================================================");

//        Bài 2a:
        System.out.println("Bài 2a: Nhập tt/");
        Person[] students = new Student[] {
                new Student("Dang Hoang", 23, "KTX DMC", 3.99f),
                new Student("Phan Trung", 23, "FOR, Dong Ke", 2.99f),
                new Student("Hoang Khanh", 23, "Dong Ke", 3.0f),
                new Student("Duong Manh", 22, "Nguyen Luong Bang", 2.5f),
                new Student("Tran Hiep", 22, "KTX DMC", 3.1f)
        };
        Teacher[] teachers = new Teacher[] {
                new Teacher("Nguyen A", 30, "BKDN", 500f),
                new Teacher("Nguyen B", 32, "BKDN", 700f),
                new Teacher("Nguyen C", 34, "BKDN", 900f),
                new Teacher("Nguyen D", 36, "BKDN", 950f),
                new Teacher("Nguyen E", 38, "BKDN", 1000f),
        };

//        Bài 2b:
        System.out.println("Bài 2b:");
        Arrays.stream(students).forEach(System.out::println);
        System.out.println("====================================================================");

//        Bài 2c:
        System.out.println("Bài 2c:");
        Arrays.stream(teachers).forEach(System.out::println);
        System.out.println("====================================================================");

//        Bài 2d:
        System.out.println("Bài 2d:");
        Arrays.stream(teachers).sorted((t1, t2) -> (int) (t2.getSalary() - t1.getSalary()))
                .limit(3).forEach(System.out::println);
        System.out.println("====================================================================");

//        Bài 2e:
        System.out.println("Bài 2e:");
        Arrays.sort(students, (s1, s2) -> s1.getAge() - s2.getAge());
        Arrays.stream(students).filter(s -> s.getAge() == students[0].getAge())
                .forEach(System.out::println);
    }
}
