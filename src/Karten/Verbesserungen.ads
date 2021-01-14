with Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded;
use Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded;

with SchleifenPruefungen, GlobaleVariablen, GlobaleDatentypen, EinheitenDatenbank, Karten, Anzeige, WerteFestlegen;
use GlobaleDatentypen;

package Verbesserungen is

   procedure Verbesserung (Befehl, RasseExtern, EinheitNummer : in Integer)
     with Pre => RasseExtern in GlobaleDatentypen.RassenImSpielArray'Range;
   procedure VerbesserungFertiggestellt;
   
private
   
   Wahl : Boolean;

   Straßenwert : Integer;

   KartenWert : GlobaleDatentypen.AchsenAusKartenfeld;
   
   procedure VerbesserungeFestgelegt (Befehl, RasseExtern, EinheitNummer : in Integer)
     with Pre => RasseExtern in GlobaleDatentypen.RassenImSpielArray'Range;
   procedure VerbesserungAngelegt (RasseExtern, EinheitNummer : in Integer)
     with Pre => RasseExtern in GlobaleDatentypen.RassenImSpielArray'Range;
   procedure StraßeBerechnung (AchsenKoordinaten : in GlobaleDatentypen.AchsenAusKartenfeldPositiv);

end Verbesserungen;
