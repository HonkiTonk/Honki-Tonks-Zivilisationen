with GlobaleDatentypen, GlobaleVariablen;
use GlobaleDatentypen;

package Wachstum is
   
   procedure Wachstum;
   procedure WachstumBeiStadtGründung (RasseExtern : in GlobaleDatentypen.Rassen);

private
   
   procedure WachstumEinwohner (RasseExtern : in GlobaleDatentypen.Rassen; StadtNummer : in Positive) with
     Pre => StadtNummer in GlobaleVariablen.StadtGebaut'Range (2);

   procedure WachstumProduktion (RasseExtern : in GlobaleDatentypen.Rassen; StadtNummer : in Positive) with
     Pre => StadtNummer in GlobaleVariablen.StadtGebaut'Range (2);

end Wachstum;
