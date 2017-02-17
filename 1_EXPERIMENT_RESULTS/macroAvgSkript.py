# The script MUST contain a function named azureml_main
# which is the entry point for this module.

# imports up here can be used to 
import pandas as pd

# The entry point function can contain up to two input arguments:
#   Param<dataframe1>: a pandas.DataFrame
#   Param<dataframe2>: a pandas.DataFrame
def azureml_main(dataframe1 = None, dataframe2 = None):

    # Execution logic goes here
    print('Input pandas.DataFrame #1:\r\n\r\n{0}'.format(dataframe1))
    df = dataframe1
    # If a zip file is connected to the third input port is connected,
    # it is unzipped under ".\Script Bundle". This directory is added
    # to sys.path. Therefore, if your zip file contains a Python file
    # mymodule.py you can import it using:
    # import mymodule
    df = df.drop(df.index[[0,1,2,3,4,5,6,7,8,9,11]])
    df = df.ix[:,[4,7,10,13,16,19,22,25,28,31]]
    df["meanPrecision"] = df.mean(axis=1)
    df["stdPrecision"] = df.std(axis=1)
    # Return value must be of a sequence of pandas.DataFrame
    return df,
