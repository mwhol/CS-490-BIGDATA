from pyspark.sql import SparkSession

spark = SparkSession \
    .builder \
    .appName("Python Spark SQL basic example") \
    .config("spark.some.config.option", "some-value") \
    .getOrCreate()

# import pyspark class Row from module sql
from pyspark.sql import *



print("\nRead Data from File")
df = spark.read.parquet("/home/khushal/PycharmProjects/Pyspark/myFile1.parquet")
df.show()

print("\nPrinting Schema of Stored Data")
df.printSchema()
print("\nShows Employee Table")
df.select("employees").show()
#df.select('firstName','lastName').show()


df.createOrReplaceTempView("people")
print("\nShows All Data in Tables")
sqlDF = spark.sql("SELECT * FROM people")
sqlDF.show()



