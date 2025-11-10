function writeToFile(filename, content, mode="a")
    open(filename,mode) do f
        write(f, content)
    end
end

function juliaRpcTest()
    invocationId = faasr_invocation_id()
    resultsFile = "results_$invocationId.txt"

    writeToFile(resultsFile, "RESULTS: faasr_invocation_id: $invocationId\n", "w")

    writeToFile("output.txt", "content", "w") 
    faasr_put_file("output.txt", "output.txt")
    faasr_get_file("remote_output.txt", "output.txt")

    content = read("remote_output.txt", String)
    if content != "content"
        faasr_exit("faasr_get doesnt match faasr_put")
    end

    writeToFile(resultsFile, "SUCCESS: faasr_put\nSUCCESS: faasr_get\n")

    toDeleteFile = "todelete_$invocationId.txt"
    faasr_put_file("output.txt", toDeleteFile)
    faasr_delete_file(toDeleteFile)

    folderList = faasr_get_folder_list()
    writeToFile(resultsFile, "RESULTS: get_folder_list: $folderList\n")
    writeToFile(resultsFile, "RESULTS: rank: $(faasr_rank())\n")
    writeToFile(resultsFile, "RESULTS: get_s3_creds: $(faasr_get_s3_creds())\n")

    if toDeleteFile in folderList
        faasr_exit("faasr_delete_file failed to delete $toDeleteFile")
    else
        writeToFile(resultsFile, "SUCCESS: faasr_put\nSUCCESS: faasr_get\n")
    end 

    faasr_log("Testing faasr_log: $invocationId")

    writeToFile(resultsFile, "All RPCs Passed")
    faasr_put_file(resultsFile, resultsFile)
    faasr_return(true)

end
