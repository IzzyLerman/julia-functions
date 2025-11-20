using CSV
using DataFrames

function createData()
    df = DataFrame(
        beta = [0.5],
        gamma = [0.1],
        N = [1000],
        S0 = [990.0],
        I0 = [10.0],
        R0 = [0.0],
        tmax = [160.0]
    )

    dataFile = "data.csv"
    CSV.write(dataFile, df)

    faasr_put_file(dataFile, dataFile)

end
