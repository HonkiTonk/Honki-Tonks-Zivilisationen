with Ada.Wide_Wide_Text_IO, Ada.Float_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Characters.Wide_Wide_Latin_9;
use Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Characters.Wide_Wide_Latin_9;

with GlobaleDatentypen, KarteStadt, KartenDatenbank, Karten, GlobaleVariablen, EinheitenDatenbank, VerbesserungenDatenbank, ForschungsDatenbank, Sichtbarkeit, SchleifenPruefungen;
use GlobaleDatentypen;

package Karte is

   procedure AnzeigeKarte;

private

   StehtDrauf : Boolean;

   MöglicheAngriffsfelder : constant Wide_Wide_Character := '■';
   Überhang : GlobaleDatentypen.Kartenfeld := 0;
   Verteidigungsbonus : GlobaleDatentypen.GrundwerteNRGWVA;
   Nahrungsgewinnung : GlobaleDatentypen.GrundwerteNRGWVA;
   Ressourcengewinnung : GlobaleDatentypen.GrundwerteNRGWVA;
   Geldgewinnung : GlobaleDatentypen.GrundwerteNRGWVA;
   Wissensgewinnung : GlobaleDatentypen.GrundwerteNRGWVA;
   SichtweiteFestlegen : Integer;
   BewegungsfeldFestlegen : Integer;

   Kartenwert : GlobaleDatentypen.YWertXWertAusKartenfeld;

   type SichtweiteArray is array (1 .. 3) of GlobaleDatentypen.YWertXWertAusKartenfeld;

   Sichtweite : constant SichtweiteArray := (1 => (6, 10),
                                             2 => (6, 22),
                                             3 => (6, 35));

   Bewegungsfeld : constant SichtweiteArray := (1 => (5, 9),
                                                2 => (5, 21),
                                                3 => (5, 34));

   procedure Information;
   -- procedure Verschiebung;

end Karte;
