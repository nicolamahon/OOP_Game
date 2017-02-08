class Scores implements Comparable<Scores>
{
  // global variables
   String name;
   Integer topscore;
   
   // constructor
   Scores(String line)
   {
     String[] fields = line.split(",");
     name = fields[0];
     topscore = Integer.parseInt(fields[1]);
   }
   
   // constructor
   Scores(TableRow row)
   {
     name = row.getString(0);
     topscore = row.getInt(1);
   }
   
   int compareTo(Scores other)
   {
     return this.topscore.compareTo(other.topscore);
   }
   
   // for printing during testing
   String toString()
   {
    return name + "\t" + topscore;
   }
}