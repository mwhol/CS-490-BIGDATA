##  CS5542Big Data Apps and Analytics
##  **LAB ASSIGNMENT #3**
##  **Lab Submission Before July/16/2018**
##  **Part 1: Hadoop MapReduce Algorithm**
### Part A: Implement MapReduce algorithm for finding Facebook common friends problem and run the MapReduce job on Apache Spark.
This is our Mapper and Reducer Code:
```
def mapper(theString):
    theString = theString.split(" ")
    user = theString[0]
    friends = theString[1]
    keyvalues = []

    for char in friends:
        keyvalues.append((''.join(sorted(user+char)), friends.replace(char, "")))

    return keyvalues


def reducer(a, b):
    newString = ''
    for char in a:
        if char in b:
            newString += char
    return newString
```
### After creating the mapper and reducer, we had to run the dataset: dataset that given in the lab assignment 3 was really hard to understand because of this we had to create our input to show how well this mapper and reducer works 
### This is the how we run the input given by the lab assignment 3:
```
if __name__ == "__main__":
    mew = SparkContext.getOrCreate()
    lines = mew.textFile("C:\\Users\\Ndarkangel\\PycharmProjects\\Lab3\\Part1\\input", 1)
    newLines = lines.flatMap(mapper)
    newLines.saveAsTextFile("mapper")
    friends = newLines.reduceByKey(reducer)
    friends.coalesce(1).saveAsTextFile("reducer")
    mew.stop()


```
This want input to our database: 

![](https://github.com/ndarkangel2/Big_Data/blob/master/Source/Lab3/pictures/1.png)
 
This is the result from the mapper: 

![](https://github.com/ndarkangel2/Big_Data/blob/master/Source/Lab3/pictures/2.png)
 
This final output from the Reducer:

![](https://github.com/ndarkangel2/Big_Data/blob/master/Source/Lab3/pictures/3.png)
 
### You can see the input that given to us is hard to understand and we can load the full data because of this we create own input to give to mapper and reducer 
```
if __name__ == "__main__":
    facebook = SparkContext.getOrCreate()
    facebooklines = facebook.textFile("C:\\Users\\Ndarkangel\\PycharmProjects\\Lab3\\Part1\\facebook", 1)
    facebookNewLines = facebooklines.flatMap(mapper)
    facebookNewLines.saveAsTextFile("facebookmapper")
    facebookfriends = facebookNewLines.reduceByKey(reducer)
    facebookfriends.coalesce(1).saveAsTextFile("facebookreducer")
    facebook.stop()
```
This our input:
 
![](https://github.com/ndarkangel2/Big_Data/blob/master/Source/Lab3/pictures/4.png)
 
This is our result from the mapper: 

![](https://github.com/ndarkangel2/Big_Data/blob/master/Source/Lab3/pictures/5.png)

 
And this is our final output from the reducer: 

![](https://github.com/ndarkangel2/Big_Data/blob/master/Source/Lab3/pictures/6.png)

 

## Part 2: Spark Data Frames
### We need Create  a Spark  DataFrame  using  one  of  datasets,  trying  to  use  all  different StructType. This is the code we used to create this:
```
os.environ["HADOOP_HOME"]="C:\\Users\\Ndarkangel\\PycharmProjects\\winutils"
from operator import add
from pyspark.sql import *

spark = SparkSession.builder \
    .appName("Lab3") \
    .getOrCreate()

df = spark.read.load(path="WorldCupMatches.csv",
                     format='csv',
                     schema="""
Year INT,
Datetime STRING,
Stage STRING,
Stadium STRING,
City STRING,
`Home Team Name` STRING,
`Home Team Goals` INT,
`Away Team Goals`  INT,
`Away Team Name` STRING,
`Win conditions` STRING,
Attendance INT,
`Half-time Home Goals` INT,
`Half-time Away Goals` INT,
Referee     STRING,
`Assistant 1` STRING,
`Assistant 2` STRING,
RoundID     STRING,
MatchID     STRING,
`Home Team Initials` STRING,
`Away Team Initials` STRING
""",
                     option=('header', 'true'))
```
### Then we had to Register Temporary Table to use SQL on spark. This is the code we used:
```
df.registerTempTable("WorldCupMatches")
sqlContext = SQLContext(spark)
```


### Perform 10 intuitive questions in Dataset and perform any 5 queries in Spark RDD’s and Spark Data Frames. Compare the results (Total 20 Request)
### 5 Intuitive Request:
# 1. which year had highest scoring games (on average)
```
sqlContext.sql("SELECT year, MAX(`Home Team Goals`) HomeGoals, MAX(`Away Team Goals`) AwayGoals FROM WorldCupMatches WHERE year is not NULL GROUP BY year").show()
```
This is the result from request: 

![](https://github.com/ndarkangel2/Big_Data/blob/master/Source/Lab3/pictures/7.png)
 

# 2. average attendance
```
sqlContext.sql("SELECT AVG(Attendance) FROM WorldCupMatches").show()
```
This is the result from request: 

![](https://github.com/ndarkangel2/Big_Data/blob/master/Source/Lab3/pictures/8.png)
 
# 3. most common referee for each year
```
sqlContext.sql(
"SELECT year, referee, COUNT(Referee) as CNT FROM WorldCupMatches WHERE year is not NULL GROUP BY Referee, year ORDER By CNT DESC").show()
```
This is the result from request: 

![](https://github.com/ndarkangel2/Big_Data/blob/master/Source/Lab3/pictures/9.png)
 
# 4. list of all referees
```
sqlContext.sql("SELECT DISTINCT (referee) FROM WorldCupMatches").show()
```
This is the result from request: 

![](https://github.com/ndarkangel2/Big_Data/blob/master/Source/Lab3/pictures/10.png)

# 5. number of games descending by year
```
sqlContext.sql(
    "SELECT year, COUNT(1) as Games FROM WorldCupMatches WHERE year is not NULL GROUP BY year ORDER By Year DESC").show()
```
This is the result from request: 

![](https://github.com/ndarkangel2/Big_Data/blob/master/Source/Lab3/pictures/11.png)

###  We need  code so when we request data we don’t pull nulls in the CSV file
```
matches = df.rdd.filter(lambda x: x['Year'] is not None)
```
### This is the last 5 intuitive request using SQL and request same intuitive request using Spark RDD’s and Spark Data Frames
# 1. which city has hosted the most games
#SQL
```
sqlContext.sql("SELECT  City, COUNT(City) FROM WorldCupMatches Group by City").show()
```
This is the result from request: 

![](https://github.com/ndarkangel2/Big_Data/blob/master/Source/Lab3/pictures/12.png)

#SDF
```
df.groupBy("City").count().show()
```
This is the result from request:
 
![](https://github.com/ndarkangel2/Big_Data/blob/master/Source/Lab3/pictures/13.png)
#RDD
```
citiesMapped = matches.map(lambda x: (x['City'], 1))
countCities = citiesMapped.reduceByKey(add)
countCities.saveAsTextFile('countCities')
# print(countCities.collect())
```
This is the result from request:  

 ![](https://github.com/ndarkangel2/Big_Data/blob/master/Source/Lab3/pictures/14.png)
# 2. who was in group one each year
#SQL
```
sqlContext.sql("SELECT Year, `Home Team Name` AS Name FROM WorldCupMatches WHERE Stage = 'Group 1' UNION SELECT Year, `Away Team Name` AS Name FROM WorldCupMatches WHERE Stage = 'Group 1' ORDER By YEAR").show()
```
This is the result from request: 

 ![](https://github.com/ndarkangel2/Big_Data/blob/master/Source/Lab3/pictures/15.png)
#RDF
```
homeGroup1Df = df.select(df["Year"], df['Home Team Name'], df['Stage']).where(df['Stage'] == 'Group 1').withColumnRenamed("Home Team Name", "Name")
awayGroup1Df = df.select(df["Year"], df['Away Team Name'], df['Stage']).where(df['Stage'] == 'Group 1').withColumnRenamed("Away Team Name", "Name")
group1Df = homeGroup1Df.union(awayGroup1Df).drop('Stage').distinct()
group1Df.show()
```
This is the result from request: 

 ![](https://github.com/ndarkangel2/Big_Data/blob/master/Source/Lab3/pictures/16.png)
#RDD
```
def concatnames(a, b):
    return a + ', ' + b

group1 = matches.filter(lambda match: match['Stage'] == 'Group 1')
homeByYear = group1.map(lambda x: (x['Year'], x['Home Team Name']))
awayByYear = group1.map(lambda x: (x['Year'], x['Away Team Name']))
teamsByYear = homeByYear.union(awayByYear).distinct()
group1Teams = teamsByYear.reduceByKey(concatnames)
group1Teams.saveAsTextFile('group1Teams')
# print(group1Teams.collect())
```
This is the result from request: 

 ![](https://github.com/ndarkangel2/Big_Data/blob/master/Source/Lab3/pictures/17.png)
# 3. total attendance per year
#SQL
```
sqlContext.sql("SELECT Year,  SUM(Attendance)  FROM WorldCupMatches group by Year").show()
```
This is the result from request: 

![](https://github.com/ndarkangel2/Big_Data/blob/master/Source/Lab3/pictures/18.png)
#RDF
```
df.groupBy("Year").sum("Attendance").show()
```
This is the result from request: 

 ![](https://github.com/ndarkangel2/Big_Data/blob/master/Source/Lab3/pictures/19.png)

#RDD
```
filterAttendance = matches.filter(lambda x: x['Attendance'] is not None)
mapAttendance = filterAttendance.map(lambda x: (x['Year'], int(x['Attendance'])))
countAttendance = mapAttendance.reduceByKey(add)
countAttendance.saveAsTextFile('countAttendance')
# print(countAttendance.collect())
```
This is the result from request: 

![](https://github.com/ndarkangel2/Big_Data/blob/master/Source/Lab3/pictures/20.png)
# 4. which games had all goals in the second half
#SQL
```
sqlContext.sql("SELECT MatchID, (`Home Team Goals` + `Away Team Goals`) total  FROM WorldCupMatches WHERE `Half-time Home Goals` = 0 AND `Half-time Away Goals` = 0").show()
```
This is the result from request: 

![](https://github.com/ndarkangel2/Big_Data/blob/master/Source/Lab3/pictures/21.png)
 
RDF
```
df.select(df['Home Team Goals']+ df['Home Team Goals']).show()
df.select(df["MatchID"], df['Half-time Home Goals'], df['Half-time Away Goals'], df['Home Team Goals'] + df['Away Team Goals']).where(df['Half-time Home Goals'] == 0).where(df['Half-time Away Goals'] == 0).show()
```
This is the result from request: 

 ![](https://github.com/ndarkangel2/Big_Data/blob/master/Source/Lab3/pictures/22.png)
#RDD
```
def nineMapper(row):
    firsthalf = row['Half-time Home Goals'] + row['Half-time Away Goals']
    if firsthalf == 0:
        secondhalf = row['Home Team Goals'] + row['Away Team Goals']
        return [(row['MatchID'], secondhalf)]
    else:
        return []


lastHalfGoals = matches.flatMap(nineMapper).distinct()
lastHalfGoals.saveAsTextFile('lastHalfGoals')
#print(lastHalfGoals.collect())
```
This is the result from request: 

 ![](https://github.com/ndarkangel2/Big_Data/blob/master/Source/Lab3/pictures/23.png)
# 5. Percent of away games by team
#SQL
```
#sqlContext.sql("""SELECT Home.Name AS NAME, CONCAT(Int(100 * AwayGames / (AwayGames + HomeGames)), '%') AS PercentAway FROM (SELECT `Home Team Name` AS Name, COUNT(*) as HomeGames FROM WorldCupMatches GROUP BY Name HAVING Name IS NOT NULL) AS Home JOIN (SELECT `Away Team Name` AS Name, COUNT(*) as AwayGames FROM WorldCupMatches GROUP BY Name HAVING Name IS NOT NULL) AS Away ON Home.Name = Away.Name""").show()
```
This is the result from request: 

**_No output for this result because computer processer can’t handle the request (only display output if the computer processer handle the request._**

#RDF
```
#homeDf = df.groupBy("Home Team Name").count().withColumnRenamed("count", "HomeGames").withColumnRenamed("Home Team Name", "Name")
#awayDf = df.groupBy("Away Team Name").count().withColumnRenamed("count", "AwayGames").withColumnRenamed("Away Team Name", "Name")
#joinedDf = homeDf.join(awayDf, ["Name"])
#joinedDf.withColumn('PercentAway', (100 * joinedDf["AwayGames"] / (joinedDf["AwayGames"] + joinedDf["HomeGames"]))).show()
```
This is the result from request: 

**_No output for this result because computer processer can’t handle the request (only display output if the computer processer handle the request._**

#RDD
```
def percent(a, b):
    return str(int(a / (a + b) * 100)) + '%'

home = matches.map(lambda x: (x['Home Team Name'], 1))
away = matches.map(lambda x: (x['Away Team Name'], 1))
homeCounts = home.reduceByKey(add)
# print(homeCounts.collect())
awayCounts = away.reduceByKey(add)
# print(awayCounts.collect())
teams = awayCounts.union(homeCounts)
percentAway = teams.reduceByKey(percent)
percentAway.saveAsTextFile('percentAway')
```
This is the result from request: 

![](https://github.com/ndarkangel2/Big_Data/blob/master/Source/Lab3/pictures/24.png)

## Part 2 part 3 Compare SQL, RDD and RDF the results:

### From the top request results people can see that request SQL and RDD is much code is much similar to each other if we request simple request from the database, but if the request is more complex then RDD become more complex to ask same request. First 4 requests from the database was really easy using the SQL and RDD because the request wasn’t too complex. But when we look at the 5 request SQL and RDD codes not going to work on the some computers because computers process handle extreme complex data. RDD is really good when dealing with extreme complex because it does not put too much power to computer process because of this reason computer can handle the request.  











