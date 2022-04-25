pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

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
