with Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded;
use Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded;

with StadtWerteFestlegen, GlobaleVariablen, GebaeudeDatenbank, EinheitenDatenbank, GlobaleDatentypen;
use GlobaleDatentypen;

package Wachstum is
   
   procedure Wachstum;
   procedure WachstumBeiStadtGründung (RasseExtern : in Integer)
     with Pre => RasseExtern in GlobaleDatentypen.RassenImSpielArray'Range;

private
   
   procedure WachstumEinwohner (RasseExtern, StadtNummer : in Integer)
     with Pre => RasseExtern in GlobaleDatentypen.RassenImSpielArray'Range;
   procedure WachstumProduktion (RasseExtern, StadtNummer : in Integer)
     with Pre => RasseExtern in GlobaleDatentypen.RassenImSpielArray'Range;

end Wachstum;
