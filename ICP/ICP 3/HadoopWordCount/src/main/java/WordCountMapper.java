/**
 * Created by Mayanka on 03-Sep-15.
 */
import java.io.IOException;
import java.util.StringTokenizer;

import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;

import static java.lang.Integer.parseInt;

public class WordCountMapper extends
        Mapper<Object, Text, Text, IntWritable> {

    private static int FinalRow = 0;
    private static int FinalCol = 0;
    private static int Dimension = 1;
    private static int OurRow = 0;
    private static int OurCol = 0;
    private static int OurMatrix = 0;
    private static IntWritable Value = new IntWritable(0);

    private String word = new String();
    private String AdditionPlace = new String();
    private String testprint = new String();

    public void map(Object key, Text value, Context context
    ) throws IOException, InterruptedException {
        StringTokenizer itr = new StringTokenizer(value.toString());
        while (itr.hasMoreTokens()) {
            if (Dimension == 1) {
                FinalCol = parseInt(itr.nextToken());
                FinalRow = parseInt(itr.nextToken());
                Dimension = 0;
            } else {
                OurMatrix = parseInt(itr.nextToken());
                OurCol = parseInt(itr.nextToken());
                OurRow = parseInt(itr.nextToken());
                Value = new IntWritable(Integer.parseInt(itr.nextToken()));

                if (OurMatrix == 1) {
                    AdditionPlace = Integer.toString(OurRow);
                } else {
                    AdditionPlace = Integer.toString(OurCol);
                }

                if (OurMatrix == 1) {
                    for (int i = 1; i <= FinalRow; i++) {
                        Text word = new Text(Integer.toString(OurCol) + "," + Integer.toString(i) + "," + AdditionPlace);
                        testprint = word.toString() + " - " + Value.toString();
                        System.out.print(testprint);
                        System.out.print("\n");
                        context.write(word, Value);
                    }
                } else {
                    for (int i = 1; i <= FinalCol; i++) {
                        Text word = new Text(Integer.toString(i) + "," + Integer.toString(OurRow) + "," + AdditionPlace);
                        testprint = word.toString() + " - " + Value.toString();
                        context.write(word, Value);
                        System.out.print(testprint);
                        System.out.print("\n");
                    }
                }
            }
        }
    }
}
