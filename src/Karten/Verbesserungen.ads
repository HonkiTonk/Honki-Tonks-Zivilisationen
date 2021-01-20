with Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded;
use Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded;

with SchleifenPruefungen, GlobaleVariablen, GlobaleDatentypen, EinheitenDatenbank, Karten, Anzeige, WerteFestlegen, GlobaleRecords;
use GlobaleDatentypen;

package Verbesserungen is

   procedure Verbesserung (RasseExtern : in GlobaleDatentypen.Rassen; Befehl, EinheitNummer : in Integer) with
     Pre => Befehl > 0 and EinheitNummer > 0;
   
   procedure VerbesserungFertiggestellt;
   
private
   
   Wahl : Boolean;

   Straßenwert : Integer;

   KartenWert : GlobaleRecords.AchsenAusKartenfeld;
   
   procedure VerbesserungeFestgelegt (RasseExtern : in GlobaleDatentypen.Rassen; Befehl, EinheitNummer : in Integer);
   procedure VerbesserungAngelegt (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : in Positive);

   procedure StraßeBerechnung (AchsenKoordinaten : in GlobaleRecords.AchsenAusKartenfeldPositiv);

end Verbesserungen;
