with Ada.Wide_Wide_Text_IO, Ada.Characters.Wide_Wide_Latin_9, GlobaleVariablen, Karten, KartenDatenbank, EinheitenDatenbank, VerbesserungenDatenbank;
use Ada.Wide_Wide_Text_IO, Ada.Characters.Wide_Wide_Latin_9;

package Sichtbarkeit is

   procedure Sichtbarkeitsprüfung;
   procedure Sichtbarkeit (YAchse, XAchse : in Integer);

private

   NichtSichtbar : constant Wide_Wide_Character := ' ';

   Sichtweite : Integer := 2;
   Wert : Integer;

   procedure Farben (Einheit, Verbesserung, Ressource, Grund : in Integer);

end Sichtbarkeit;
