with Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded;
use Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded;

with StadtWerteFestlegen, GlobaleVariablen, GebaeudeDatenbank, EinheitenDatenbank, GlobaleDatentypen, Anzeige;
use GlobaleDatentypen;

package Wachstum is
   
   procedure Wachstum;
   procedure WachstumBeiStadtGründung (RasseExtern : in GlobaleDatentypen.Rassen);

private
   
   procedure WachstumEinwohner (RasseExtern : in GlobaleDatentypen.Rassen; StadtNummer : in Positive);
   procedure WachstumProduktion (RasseExtern : in GlobaleDatentypen.Rassen; StadtNummer : in Positive);

end Wachstum;
