with Ada.Wide_Wide_Text_IO, Ada.Characters.Wide_Wide_Latin_9, GlobaleVariablen, Karten, KartenDatenbank, EinheitenDatenbank, VerbesserungenDatenbank, SchleifenPruefungen, GlobaleDatentypen;
use Ada.Wide_Wide_Text_IO, Ada.Characters.Wide_Wide_Latin_9, GlobaleDatentypen;

package Sichtbarkeit is

   procedure Sichtbarkeitsprüfung;
   procedure Sichtbarkeit (YAchse, XAchse : in Integer);
   procedure Farben (Einheit : Integer; Verbesserung : GlobaleDatentypen.KartenVerbesserung; Ressource, Grund : in GlobaleDatentypen.KartenGrund);

private

   NichtSichtbar : constant Wide_Wide_Character := ' ';

   Sichtweite : Integer := 2;
   Wert : Integer;

   Kartenwert : GlobaleDatentypen.RückgabewertFürSchleifenPrüfungRecord;

end Sichtbarkeit;
