**Part One: Hadoop Map Reduce**

The code for this problem can be seen [here](https://github.com/mwhol/CS-490/tree/master/Labs/Lab%201/HadoopWordCount/src/main/java) and a short video describing my approach and the solution can be seen [here.](https://github.com/mwhol/CS-490/blob/master/Labs/Lab%201/Lab1.1.ogv?raw=true) 

**Introduction**

For the first part we needed to create a Hadoop program which successfully established lists of common friends among facebook users.

**Objectives**

To take a list of facebook users and friends in this format:

    <user>   <all friends>

and turn it into a list of common friends that looks like this:

    <user one> <user two>   <shared friends>

**Approaches**

There are several different way to approach this problem. The one I took works in that it has the mapper change data from a person and their friends (like A -> BCD) to pairs of friendships and the other remaining friends of one of the member (like AB -> CD, AC -> BD, AD -> CD). The reducer then takes this data and will match on the key, meaning we'll pull two strings, one which is A's friends remaining after B and one which is B's friends remaining after A. At that point we do a simple test to see if each friend is present in both lists and if so add to the value to output.

**Methods**

Mostly I used string operations. I thought it was simpler to keep the list of friends as a complex string and then perform operations on them that way.

**Workflow**

First I spent some time planning out what the best way to do this would be. I examined the approach where what we pass to the reducer is a key value pair of the friendship and just one friend (ie. (AB, C)) and compared it to my final approach to see which seemed better and my approach seemed easier on the reducer. Once I was there I used print statements to iterate and get my mapper working the way I wanted and then I put together the reducer.

**Datasets**

I copied exactly the data from the problem worksheet.

**Parameters**

You will need to pass input and output to this program.

**Evaluation & Discussion**

Overall I thought it was an interesting problem and my program worked well to solve it. There are several different approaches to it so I'm interested in what other people in class have done. 

**Conclusion**

Fun Lab!

Here are some screenshots.

Our output:
![](https://raw.githubusercontent.com/mwhol/CS-490/master/Labs/Lab%201/Screenshot%20from%202018-06-16%2016-48-29.png)

Samples of our code and the run log:
![](https://raw.githubusercontent.com/mwhol/CS-490/master/Labs/Lab%201/Screenshot%20from%202018-06-16%2016-42-00.png)


***
**Part Two: Cassandra Database**

[Here](https://github.com/mwhol/CS-490/blob/master/Labs/Lab%201/code) is the code and [here](https://github.com/mwhol/CS-490/blob/master/Labs/Lab%201/Lab1.1.ogv?raw=true) is the video. I did the i2O water problem. Cassandra is a good use case for this because of its distributed nature, its ability to handle high throughput streaming data (like the time-series data this application will generate) and the ability to seamlessly add new servers.


**Introduction**

I picked the use case involving i2O water measurement devices. In this assignment we were to examine a real-life database use case, implement a version of it in Cassandra and then examine why Cassandra was a good fit for this business problem.

**Objectives**

To build a database capable of storing i2O's data and then examine its benefits.

**Approaches**

There don't seem to be as many different approaches to this problem as to the previous MapReduce one. I constructed a database with the columns I believed were needed and then I inserted some toy data to illustrate.

In my example database I have several rows including ones which capture: the device id, the time, the rate of water flowing, and the running total of water which has flowed. Here is a sample of what it looks like:

![](https://raw.githubusercontent.com/mwhol/CS-490/master/Labs/Lab%201/Screenshot%20from%202018-06-16%2016-51-13.png)

My three commands for this application are:

    SELECT timestamp, deviceid, waterrate FROM waterusage WHERE waterrate > 25 ALLOW FILTERING;

which allows us to see all the times where water was really flowing.

    SELECT timestamp, runningtotal, waterrate FROM waterusage where activationnumber = 1 ALLOW FILTERING;

which allows us to see the first time each device (in this case just one) was activated.

    describe waterusage;

which lets us see how our table is configured and can help us decide to make changes in case we are experiencing difficulties.

**Methods**

I constructed the database, inserted data and then ran a few queries on it.

**Workflow**

I constructed the database then inserted data and then ran a few queries on it.

**Datasets**

I created some toy data, it involves one device and the first two times water flows through it. The first time the rate of the water increases and then drops, same for the second time.

**Parameters**

There's no parameters in my implementation because I just pass all the data in through INSERT statements.

**Evaluation & Discussion**

I thought my example worked pretty well, I was able to find times at which the rate of water was high, the first time the device was activated and we were able to examine the inner workings of the table. They all seemed to work.

**Conclusion**

This was an interesting use case and one I wouldn't have thought of before, I'm glad I got to construct this database and am looking for feedback, thanks!