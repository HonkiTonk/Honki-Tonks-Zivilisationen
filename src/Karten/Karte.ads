with Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Characters.Wide_Wide_Latin_9, KartenDatenbank, Karten, GlobaleVariablen, EinheitenDatenbank, VerbesserungenDatenbank, ForschungsDatenbank, Einlesen;
use Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Characters.Wide_Wide_Latin_9;

package Karte is

   procedure AnzeigeKarte;
   procedure AnzeigeStadt (Stadtnummer : in Integer);
   -- procedure AnzeigeBewegung (YAnfangPosition, XAnfangPosition : in Integer);
   -- War mal für die Beqwegungsmöglichkeiten der Einheiten gedacht, umschreiben für die Angriffsmöglichkeiten von Fernkampfeinheiten?
   -- Befindet sich in VielleichtNochBrauchbareReste

private

   StehtDrauf : Boolean;
   ÜberhangDurchlaufenLinks : Boolean;

   MöglicheAngriffsfelder : constant Wide_Wide_Character := '■';
   NichtSichtbar : constant Wide_Wide_Character := ' ';

   Sichtweite : constant Integer := 10;
   Bewegungsfeld : constant Integer := 8;
   Überhang : Integer := 0;
   Stadtumgebungsgröße : Integer := 1;
   YAchsenabstraktion : Integer;
   Verteidigungsbonus : Integer;
   Nahrungsgewinnung : Integer;
   Ressourcengewinnung : Integer;
   Geldgewinnung : Integer;
   Wissensgewinnung : Integer;

   procedure Sichtbarkeit (YAchse, XAchse : in Integer);
   procedure Farben (Einheit, Verbesserung, Ressource, Grund : in Integer);
   procedure Information;

end Karte;
