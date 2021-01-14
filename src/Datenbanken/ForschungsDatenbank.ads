with Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Wide_Wide_Characters.Handling, Ada.Characters.Wide_Wide_Latin_9;
use Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Wide_Wide_Characters.Handling, Ada.Characters.Wide_Wide_Latin_9;

with GlobaleVariablen, GlobaleDatentypen, Anzeige;
use GlobaleDatentypen;

package ForschungsDatenbank is

   type AnforderungForschungArray is array (1 .. 4) of Integer;

   type ForschungRecord is record

      PreisForschung : GlobaleDatentypen.KostenLager;
      AnforderungForschung : AnforderungForschungArray;

   end record;

   type ForschungListeArray is Array (GlobaleDatentypen.RassenImSpielArray'Range, GlobaleVariablen.Wichtiges (1).Erforscht'Range) of ForschungRecord;
   ForschungListe : ForschungListeArray := (others => (1 => (100, (others => 0)),
                                                       2 => (100, (others => 0)),
                                                       3 => (100, (others => 0)),

                                                       4 => (250, (1, 2, 0, 0)),
                                                       5 => (250, (2, 3, 0, 0)),
                                                       6 => (250, (4, 0, 0, 0)),

                                                       others => (0, (others => 0))));

   procedure Beschreibung (ID : in Integer);
   procedure Forschung (RasseExtern : in Integer)
     with Pre => RasseExtern in GlobaleDatentypen.RassenImSpielArray'Range;
   procedure ForschungFortschritt;
   procedure ForschungZeit (RasseExtern : in Integer)
     with Pre => RasseExtern in GlobaleDatentypen.RassenImSpielArray'Range;

private

   AnforderungenErfüllt : Boolean;

   Taste : Wide_Wide_Character;

   WasErforschtWerdenSoll : Integer;
   AktuelleAuswahl : Integer;
   Ende : Integer;

   function AuswahlForschung (RasseExtern : in Integer) return Integer
     with Pre => RasseExtern in GlobaleDatentypen.RassenImSpielArray'Range;

end ForschungsDatenbank;
