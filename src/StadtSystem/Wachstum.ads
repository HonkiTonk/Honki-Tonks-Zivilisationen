with GlobaleDatentypen;
use GlobaleDatentypen;

package Wachstum is
   
   procedure Wachstum;
   procedure WachstumBeiStadtGründung (RasseExtern : in GlobaleDatentypen.Rassen);

private
   
   procedure WachstumEinwohner (RasseExtern : in GlobaleDatentypen.Rassen; StadtNummer : in Positive);
   procedure WachstumProduktion (RasseExtern : in GlobaleDatentypen.Rassen; StadtNummer : in Positive);

end Wachstum;
