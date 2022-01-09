pragma SPARK_Mode (On);

package KartenGenerator is

   procedure KartenGenerator;

private

   procedure EisWasserLandGenerieren;
   procedure KüstenwasserGenerieren;
   procedure LandschaftGenerieren;
   procedure UnterwasserUnterirdischGenerieren;
   procedure FlüsseGenerieren;
   procedure RessourcenGenerieren;

end KartenGenerator;
