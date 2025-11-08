function writeToFile(filename, content)
    open(filename,"a") do f
        write(f, content)
    end
end

function juliaRpcTest()
    writeToFile("output.txt", "content") 

    faasr_put_file("output.txt", "output.txt")
    faasr_get_file("remote_output.txt", "output.txt")

    content = read("remote_output.txt", String)
    if content != "content"
        faasr_exit("faasr_get doesnt match faasr_put")
    end

    writeToFile("results.txt", "SUCCESS: faasr_put/faasr_get\n")

    faasr_put_file("output.txt", "todelete.txt")
    faasr_delete_file("todelete.txt")
    try
        faasr_get_file("todelete.txt", "todelete.txt")
        if isfile("todelete.txt")
            faasr_exit("faasr_delete failed")
        end
    catch e
        writeToFile("results.txt", "SUCCESS: faasr_delete: $e\n")
    end

    log_msg = join([ 
        "folder list: $(faasr_get_folder_list())",
        "rank: $(faasr_rank())",
        "s3 creds: $(faasr_get_s3_creds())",
        "invocation id: $(faasr_invocation_id())"
    ], "\n")
    writeToFile("results.txt", log_msg)
    faasr_put_file("results.txt", "results.txt")

    faasr_log("All RPCs Passed")
    faasr_return(true)

end
