pragma SPARK_Mode (On);

with GlobaleDatentypen;

package KartenGenerator is

   procedure KartenGenerator;

private

   GrößePangäa : GlobaleDatentypen.KartenfeldPositiv;

   procedure GrößeLandartFestlegen;

   procedure EisWasserLandGenerieren;
   procedure KüstenwasserGenerieren;
   procedure LandschaftGenerieren;
   procedure UnterwasserUnterirdischGenerieren;
   procedure FlüsseGenerieren;
   procedure RessourcenGenerieren;

end KartenGenerator;
