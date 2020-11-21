with Ada.Wide_Wide_Text_IO, Ada.Float_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Characters.Wide_Wide_Latin_9;
use Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Characters.Wide_Wide_Latin_9;

with GlobaleDatentypen, KarteStadt, KartenDatenbank, Karten, GlobaleVariablen, EinheitenDatenbank, VerbesserungenDatenbank, ForschungsDatenbank, Sichtbarkeit;
use GlobaleDatentypen;

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
   SichtweiteFestlegen : Integer;
   BewegungsfeldFestlegen : Integer;

   type SichtweiteArray is array (1 .. 3) of GlobaleDatentypen.RückgabewertFürSchleifenPrüfungRecord;

   Sichtweite : constant SichtweiteArray := (1 => (6, 10),
                                             2 => (6, 22),
                                             3 => (6, 35));

   Bewegungsfeld : constant SichtweiteArray := (1 => (5, 9),
                                                2 => (5, 21),
                                                3 => (5, 34));

   procedure Information;

end Karte;
