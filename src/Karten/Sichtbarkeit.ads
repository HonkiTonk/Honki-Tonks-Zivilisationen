with Ada.Wide_Wide_Text_IO, Ada.Characters.Wide_Wide_Latin_9;
use Ada.Wide_Wide_Text_IO, Ada.Characters.Wide_Wide_Latin_9;

with GlobaleVariablen, Karten, KartenDatenbank, EinheitenDatenbank, VerbesserungenDatenbank, SchleifenPruefungen, GlobaleDatentypen;
use GlobaleDatentypen;

package Sichtbarkeit is

   procedure Sichtbarkeitsprüfung;
   procedure Sichtbarkeit (YAchse, XAchse : in GlobaleDatentypen.Kartenfeld);
   procedure Farben (Einheit : GlobaleDatentypen.EinheitenID; Verbesserung : GlobaleDatentypen.KartenVerbesserung; Ressource, Grund : in GlobaleDatentypen.KartenGrund);

private

   NichtSichtbar : constant Wide_Wide_Character := ' ';

   Sichtweite : GlobaleDatentypen.Sichtweite := 2;
   Wert : Integer;

   Kartenwert : GlobaleDatentypen.YWertXWertAusKartenfeld;

end Sichtbarkeit;
