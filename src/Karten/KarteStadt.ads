with Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Characters.Wide_Wide_Latin_9, KartenDatenbank, Karten, GlobaleVariablen, EinheitenDatenbank, VerbesserungenDatenbank, ForschungsDatenbank, Einlesen, Sichtbarkeit;
use Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Characters.Wide_Wide_Latin_9;

package KarteStadt is
   
   procedure AnzeigeStadt (Stadtnummer : in Integer);

private

   ÜberhangDurchlaufenLinks : Boolean;
   
   Stadtumgebungsgröße : Integer := 1;
   Überhang : Integer := 0;
   YAchsenabstraktion : Integer;
   
   procedure FarbenStadt;
   procedure InformationenStadt;

end KarteStadt;
