import os

os.environ["SPARK_HOME"] = "/home/mjw3/Downloads/spark-2.3.1-bin-hadoop2.7"

from pyspark import SparkContext

if __name__ == "__main__":
    sc = SparkContext.getOrCreate()

    numbers = sc.textFile("/home/mjw3/PycharmProjects/MergeSort/input", 1).flatMap(lambda x: x.split(" ")).map(lambda x: (int(x), int(x)))
    numbers = numbers.sortByKey().keys()
    numbers.saveAsTextFile("output3")
    sc.stop()

    #



