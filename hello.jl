import JSON
import Base

function hello()
    str = "Hello, world!"
    println(str)
    return JSON.json(Base.Dict("Result" => str))
