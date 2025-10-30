function add(num1, num2)
    num3 = num1 + num2
    println("add: $num1 + $num2 = $num3")

    Base.write("/tmp/output.txt", string(num3))
    try
        faasr_put_file("/tmp/output.txt", "add_output.txt")
    catch e 
        println("Exception with faasr_put_file: $(typeof(e)) $(e) ")
    end
end
