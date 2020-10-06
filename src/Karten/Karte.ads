with Ada.Wide_Wide_Text_IO, Ada.Float_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Characters.Wide_Wide_Latin_9, GlobaleDatentypen, KarteStadt, KartenDatenbank, Karten, GlobaleVariablen, EinheitenDatenbank, VerbesserungenDatenbank, ForschungsDatenbank, Einlesen, Sichtbarkeit;
use Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Characters.Wide_Wide_Latin_9;

package Karte is

   procedure AnzeigeKarte;

private

   StehtDrauf : Boolean;

   MöglicheAngriffsfelder : constant Wide_Wide_Character := '■';
   Überhang : Integer := 0;
   Verteidigungsbonus : Integer;
   Nahrungsgewinnung : Integer;
   Ressourcengewinnung : Integer;
   Geldgewinnung : Integer;
   Wissensgewinnung : Integer;

   Sichtweite : constant GlobaleDatentypen.RückgabewertFürSchleifenPrüfungRecord := (8, 12);
   Bewegungsfeld : constant GlobaleDatentypen.RückgabewertFürSchleifenPrüfungRecord := (6, 10);

   procedure Information;

end Karte;
