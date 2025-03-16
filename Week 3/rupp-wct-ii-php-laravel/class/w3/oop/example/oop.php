<?php

interface Shape{
    public function getArea();
}

class Ciricle implements Shape{
    private float $radius;
    public function __construct($radius){
        $this->radius = $radius;
    }
    public function getArea(){
        return 3.14 * $this->radius * $this->radius;
    }
}

$circle = new Ciricle(5);
echo $circle->getArea()."\n";

// Abstract class is a class that cannot be instantiated.
// Inheriting class must implement all abstract methods.
abstract class Entity {
    abstract public function doSomething();
}

class Person extends Entity{
    private string $name;
    private int $age;
    // Constructor is a special method that is called when an object is created.
    // Useful for initializing an object's properties.
    public function __construct($name, $age){
        $this->name = $name;
        $this->age = $age;
    }
    public function showProperty(){
        echo "Name: $this->name, Age: $this->age\n";
    }

    public function doSomething(){
        echo "I am doing something\n";
    }
}

// Inheritance
class God extends Person{
    public function showPower(){
        echo "I am God :$this->name\n";
    }
}



$person = new Person("John", 25);
$person->showProperty();
$person->doSomething();

$god = new God("God", 1000000);
$god->showProperty();
$god->showPower();


?>
