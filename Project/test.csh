
#>> CaioSHell - Tests


#>> Simple commands
echo " 1. Simple commands ";;
echo "Hello, CaioSHell!";;
pwd;;

#>> Variables
echo " Variables ";;
define var name = "Alice";;
echo @name;;
define var n = 42;;
echo @n;;

#>> Arithmetic
echo " Arithmetic ";;
define var a = 10;;
define var b = 3;;
define var sum  = @a + @b;;
define var diff = @a - @b;;
define var prod = @a * @b;;
define var quot = @a # @b;;
echo @sum;;
echo @diff;;
echo @prod;;
echo @quot;;

#>> String concatenation
echo " String concatenation ";;
define var s1 = "Hello, ";;
define var s2 = "World!";;
define var msg = @s1 + @s2;;
echo @msg;;

#>> Function definition and call
echo " Functions ";;
define function greet(person) {
    echo @person;
};;
greet("Alice");;
greet("Bob");;

#>> Function with arithmetic
echo " Function with arithmetic ";;
define function double(x) {
    define var result = @x * 2;
    echo @result;
};;
double(5);;
double(21);;

#>> Pipes
echo " Pipes ";;
echo "hello world" | wc -w;;
ls / | grep tmp;;

#>> And (&&)
echo " And (&&) ";;
(echo "first") && (echo "second");;

#>>If / else
echo "If / else ";;
if (test 1 "-eq" 1) {
    echo "condition true";
} else {
    echo "condition false";
};;
if (test 1 "-eq" 2) {
    echo "should not print";
} else {
    echo "correctly false";
};;

#>> For loop
echo " For loop ";;
for (@item in ["alpha", "beta", "gamma"]) {
    echo @item;
};;

#>> While loop
echo " While loop ";;
define var i = 0;;
while (test @i "-lt" 3) {
    echo @i;
    i = @i + 1;
};;

#>> Variable reassignment
echo " Variable reassignment ";;
define var counter = 100;;
counter = @counter + 1;;
echo @counter;;

#>> Pass
echo " Pass ";;
if (test 0 "-eq" 1) {
    echo "unreachable";
} else {
    pass;
};;
echo "pass ok";;

#>>Files with dots in name
echo "File paths with dots ";;
cat /etc/hostname;;

#>> Flags (dash args)
echo " Command flags ";;
ls -l /tmp;;

#>> cd
echo "cd ";;
cd /tmp;;
pwd;;
cd /;;
pwd;;

echo " All tests done ";;
