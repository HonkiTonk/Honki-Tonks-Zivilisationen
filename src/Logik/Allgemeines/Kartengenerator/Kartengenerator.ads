pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package Kartengenerator is

   procedure Kartengenerator;

private

   procedure EisWasserLandGenerieren;
   procedure KüstenwasserGenerieren;
   procedure LandschaftGenerieren;
   procedure UnterwasserUnterirdischGenerieren;
   procedure FlüsseGenerieren;
   procedure RessourcenGenerieren;

end Kartengenerator;
