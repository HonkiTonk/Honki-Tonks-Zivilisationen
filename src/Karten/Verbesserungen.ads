with Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded;
use Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded;

with SchleifenPruefungen, GlobaleVariablen, GlobaleDatentypen, EinheitenDatenbank, Karten, Anzeige, WerteFestlegen;
use GlobaleDatentypen;

package Verbesserungen is

   procedure Verbesserung (Befehl, Rasse, EinheitNummer : in Integer);
   procedure VerbesserungFertiggestellt;
   
private
   
   Wahl : Boolean;

   Straßenwert : Integer;

   KartenWert : GlobaleDatentypen.AchsenAusKartenfeld;
   
   procedure VerbesserungeFestgelegt (Befehl, Rasse, EinheitNummer : in Integer);
   procedure VerbesserungAngelegt (Rasse, EinheitNummer : in Integer);
   procedure StraßeBerechnung (AchsenKoordinaten : in GlobaleDatentypen.AchsenAusKartenfeldPositiv);

end Verbesserungen;
