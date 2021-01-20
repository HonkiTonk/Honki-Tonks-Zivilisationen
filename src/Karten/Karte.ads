with Ada.Wide_Wide_Text_IO, Ada.Float_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Characters.Wide_Wide_Latin_9;
use Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Characters.Wide_Wide_Latin_9;

with GlobaleDatentypen, KarteStadt, KartenDatenbank, Karten, GlobaleVariablen, EinheitenDatenbank, VerbesserungenDatenbank, ForschungsDatenbank, Sichtbarkeit, SchleifenPruefungen, GlobaleRecords;
use GlobaleDatentypen, GlobaleRecords;

package Karte is

   procedure AnzeigeKarte (RasseExtern : in GlobaleDatentypen.Rassen);

private

   StehtDrauf : Boolean;

   -- MöglicheAngriffsfelder : constant Wide_Wide_Character := '■'; -- Später für Fernkampfeinheiten wieder einbauen?
   Verteidigungsbonus : GlobaleDatentypen.GrundwerteNRGWVA;
   Nahrungsgewinnung : GlobaleDatentypen.GrundwerteNRGWVA;
   Ressourcengewinnung : GlobaleDatentypen.GrundwerteNRGWVA;
   Geldgewinnung : GlobaleDatentypen.GrundwerteNRGWVA;
   Wissensgewinnung : GlobaleDatentypen.GrundwerteNRGWVA;
   SichtweiteFestlegen : Integer;
   BewegungsfeldFestlegen : Integer;

   Kartenwert : GlobaleRecords.AchsenAusKartenfeld;

   RasseUndPlatznummer : GlobaleRecords.RasseUndPlatznummerRecord;

   type SichtweiteArray is array (1 .. 3) of GlobaleRecords.AchsenAusKartenfeldPositiv;

   Sichtweite : constant SichtweiteArray := (1 => (0, 6, 10),
                                             2 => (0, 6, 22),
                                             3 => (0, 6, 35));

   Bewegungsfeld : constant SichtweiteArray := (1 => (0, 5, 9),
                                                2 => (0, 5, 21),
                                                3 => (0, 5, 34));

   procedure Information (RasseExtern : in GlobaleDatentypen.Rassen);

end Karte;
