with Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Einlesen, GlobaleVariablen;
use Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded;

package ForschungsDatenbank is

   type ForschungRecord is record

      Name : Integer;
      PreisForschung : Integer;
      Anforderung1 : Wide_Wide_Character;
      Anforderung2 : Wide_Wide_Character;
      Anforderung3 : Wide_Wide_Character;
      Anforderung4 : Wide_Wide_Character;

   end record;

   type ForschungListeArray is Array (1 .. 25) of ForschungRecord;
   ForschungListe : ForschungListeArray := (1 => (1, 100, '0', '0', '0', '0'),
                                            2 => (2, 100, '0', '0', '0', '0'),
                                            3 => (3, 100, '0', '0', '0', '0'),

                                            4 => (4, 250, '1', '2', '0', '0'),
                                            5 => (5, 250, '2', '3', '0', '0'),
                                            6 => (6, 250, '4', '0', '0', '0'),

                                            others => (0, 0, '0', '0', '0', '0'));

   type ErforschtArray is array (GlobaleVariablen.EinheitenGebautArray'Range (1)) of Wide_Wide_String (ForschungListeArray'Range);
   Erforscht : ErforschtArray := (others => ("0000000000000000000000000"));

   procedure Beschreibung (ID : in Integer);
   procedure Forschung;

end ForschungsDatenbank;
