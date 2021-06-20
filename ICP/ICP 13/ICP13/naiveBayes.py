
# import os
# os.environ['PYSPARK_DRIVER_PYTHON'] = '/usr/local/lib/python3.7/'
# os.environ['PYSPARK_PYTHON'] = 'python3'

from pyspark.ml.feature import VectorAssembler
from pyspark.ml.classification import NaiveBayes
from pyspark.sql import SparkSession
from pyspark.ml.evaluation import MulticlassClassificationEvaluator

from pyspark.python.pyspark.shell import spark
# spark = SparkSession.builder.appName("Lab 4").getOrCreate()
spark.sparkContext.setLogLevel("WARN")

# Load training data
data = spark.read.load(path="Absenteeism_at_work.csv", format="csv", header=True, delimiter=';', schema="""
`ID` INT,
`Reason for absence` INT,
`Month of absence` INT,
`Day of the week` INT,
`Seasons` INT,
`Transportation expense` INT,
`Distance from Residence to Work` INT,
`Service time` INT,
`Age` INT,
`Work load Average/day` FLOAT,
`Hit target` INT,
`Disciplinary failure` INT,
`Education` INT,
`Son` INT,
`Social drinker` INT,
`Social smoker` INT,
`Pet` INT,
`Weight` INT,
`Height` INT,
`Body mass index` INT,
`Absenteeism time in hours` INT
""")

assembler = VectorAssembler(inputCols=[
    "Month of absence",
    "Day of the week",
    "Transportation expense",
    "Distance from Residence to Work",
    "Service time",
    "Age",
    "Work load Average/day",
    "Hit target",
    "Disciplinary failure",
    "Education",
    "Son",
    "Social drinker",
    "Social smoker",
    "Pet",
    "Weight",
    "Height",
    "Body mass index",
    "Absenteeism time in hours"
],outputCol="features")

data = data.withColumn("IndexedSeasons", data['Seasons'] - 1)
splits = data.randomSplit([0.6, 0.4])
train = assembler.transform(splits[0])
test = assembler.transform(splits[1])

train.select("IndexedSeasons", "features").show(truncate=False)
test.select("IndexedSeasons", "features").show(truncate=False)

nb = NaiveBayes(labelCol='IndexedSeasons')
model = nb.fit(train)

# select example rows to display.
predictions = model.transform(test)
predictions.select('IndexedSeasons', 'features', 'rawPrediction', 'prediction').show(20)

# compute accuracy on the test set
evaluator = MulticlassClassificationEvaluator(labelCol="IndexedSeasons", predictionCol="prediction", metricName="accuracy")
accuracy = evaluator.evaluate(predictions)
print("Test set accuracy = " + str(accuracy))