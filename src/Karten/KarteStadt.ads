with Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Characters.Wide_Wide_Latin_9, SchleifenPruefungen, GlobaleDatentypen, GebaeudeDatenbank, StadtWerteFestlegen, KartenDatenbank, Karten, GlobaleVariablen, EinheitenDatenbank, VerbesserungenDatenbank, ForschungsDatenbank, Sichtbarkeit;
use Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Characters.Wide_Wide_Latin_9, GlobaleDatentypen;

package KarteStadt is
   
   procedure AnzeigeStadt (StadtNummer : in Integer);
   procedure Beschreibung (Rasse, StadtNummer : in Integer);

private
   
   Stadtumgebungsgröße : Integer := 1;
   Überhang : Integer := 0;
   YAchsenabstraktion : Integer;
   CursorKonstant : constant Integer := 3;
   Cursor : Integer;
   CursorYAchsePlus : Integer;
   CursorXAchsePlus : Integer;
   Nahrungsgewinnung : Integer;
   Ressourcengewinnung : Integer;
   Geldgewinnung : Integer;
   Wissensgewinnung : Integer;
   YAchse : Integer;
   XAchse : Integer;

   KartenWert : GlobaleDatentypen.RückgabewertFürSchleifenPrüfungRecord;
   
   procedure FarbenStadt;
   procedure InformationenStadt (YAufschlag, XAufschlag : in Integer);

end KarteStadt;
