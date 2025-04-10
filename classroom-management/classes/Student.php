<?php
class Student {
    private $name;
    private $age;
    private $grade;
        #constructor
    public function __construct($name, $age, $grade) {
        $this->name = $name;
        $this->age = $age;
        if (!is_numeric($grade) || $grade < 1 || $grade > 12) {
            throw new Exception("Grade must be between 1 and 12");
        }
        $this->grade = $grade;
    }
 #getters
    public function getName() {
        return $this->name;
    }
#setters
    public function getAge() {
        return $this->age;
    }
#setters
    public function getGrade() {
        return $this->grade;
    }

    public static function addStudent($student) {
        $students = self::getAllStudents();
        $students[] = $student;
        self::saveStudents($students);
    }

    public static function editStudent($index, $student) {
        $students = self::getAllStudents();
        if (isset($students[$index])) {
            $students[$index] = $student;
            self::saveStudents($students);
        }
    }

    public static function deleteStudent($index) {
        $students = self::getAllStudents();
        if (isset($students[$index])) {
            unset($students[$index]);
            self::saveStudents(array_values($students));
        }
    }

    public static function getAllStudents() {
        if (file_exists('../students.json')) {
            $data = file_get_contents('../students.json');
            return json_decode($data, true);
        }
        return [];
    }

    private static function saveStudents($students) {
        file_put_contents('../students.json', json_encode($students, JSON_PRETTY_PRINT));
    }
}
?>