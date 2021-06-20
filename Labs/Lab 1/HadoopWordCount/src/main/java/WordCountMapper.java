/**
 * Created by Mayanka on 03-Sep-15.
 */
import java.io.IOException;
import java.util.Arrays;
import java.util.StringTokenizer;

import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;

public class WordCountMapper extends
        Mapper<Object, Text, Text, Text> {

    private String person = new String();
    private String friends = new String();
    private String keyone = new String();
    private String valueone = new String();
    private Text ActualKey = new Text();
    private Text ActualValue = new Text();
    //private char[] friendspair = new char[];

    public void map(Object key, Text value, Context context
    ) throws IOException, InterruptedException {
        StringTokenizer itr = new StringTokenizer(value.toString());
        while (itr.hasMoreTokens()) {
            person = itr.nextToken().toString();
            friends = itr.nextToken().toString();
            for (int i = 0; i < friends.length(); i++) {
                keyone = person + String.valueOf(friends.charAt(i));
                valueone = friends.replace(String.valueOf(friends.charAt(i)), "");

                char[] friendspair = keyone.toCharArray();
                Arrays.sort(friendspair);
                keyone = String.valueOf(friendspair);

                Text ActualKey = new Text(keyone);
                Text ActualValue = new Text(valueone);

                System.out.print(ActualKey);
                System.out.print(" - ");
                System.out.print(ActualValue);
                System.out.print("\n");

                context.write(ActualKey, ActualValue);
            }
        }
    }
}
