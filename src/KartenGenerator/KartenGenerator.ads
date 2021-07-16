pragma SPARK_Mode (On);

with GlobaleDatentypen;

package KartenGenerator is

   procedure KartenGenerator;

private

   GrößePangäa : GlobaleDatentypen.KartenfeldPositiv;

   procedure GrößeLandartFestlegen;
   procedure AndereEbenen;

end KartenGenerator;
