function juliaRpcTest()
    open("output.txt","w") do f
        write(f, "content")
    end

    faasr_put_file("output.txt", "output.txt")
    faasr_get_file("remote_output.txt", "output.txt")

    content = read("remote_output.txt", String)
    if content != "content"
        faasr_exit("faasr_get doesnt match faasr_put")
    end

    faasr_put_file("output.txt", "todelete.txt")
    faasr_delete("todelete.txt")
    try
        faasr_get_file("todelete.txt", "todelete.txt")
        if isfile("todelete.txt")
            faasr_exit("faasr_delete failed")
        end
    catch e
        println("SUCCESS: Get fails on deleted file: $e")
    end

    faasr_log("Test log")
    println(faasr_get_folder_list())
    println(faasr_rank())
    println(faasr_get_s3_creds())
    println(faasr_invocation_id())

    println("All RPCs Passed")
    faasr_return()

end
