with Ada.Wide_Wide_Text_IO, Ada.Characters.Wide_Wide_Latin_9;
use Ada.Wide_Wide_Text_IO, Ada.Characters.Wide_Wide_Latin_9;

with GlobaleVariablen, Karten, KartenDatenbank, EinheitenDatenbank, VerbesserungenDatenbank, SchleifenPruefungen, GlobaleDatentypen;
use GlobaleDatentypen;

package Sichtbarkeit is

   procedure Sichtbarkeitsprüfung (RasseExtern : in Integer)
     with Pre => RasseExtern in GlobaleDatentypen.RassenImSpielArray'Range;
   procedure Sichtbarkeit (InDerStadt : Boolean; EAchse : GlobaleDatentypen.Ebene; YAchse, XAchse : in GlobaleDatentypen.KartenfeldPositiv; RasseExtern : in Integer)
     with Pre => RasseExtern in GlobaleDatentypen.RassenImSpielArray'Range;
   procedure Farben (Einheit : GlobaleDatentypen.EinheitenID; Verbesserung : GlobaleDatentypen.KartenVerbesserung; Ressource, Grund : in GlobaleDatentypen.KartenGrund; Cursor : in Boolean; RasseExtern, RasseIntern : in Integer)
     with Pre => RasseExtern in GlobaleDatentypen.RassenImSpielArray'Range;

private

   NichtSichtbar : constant Wide_Wide_Character := ' ';

   Sichtweite : GlobaleDatentypen.Sichtweite := 2;
   Wert : Integer;

   Kartenwert : GlobaleDatentypen.AchsenAusKartenfeld;

end Sichtbarkeit;
