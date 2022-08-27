pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;
with Ada.Characters.Wide_Wide_Latin_1;

with Sf.System.Vector2;

package TextKonstanten is
   
   LeerString : constant Wide_Wide_String := "";
   LeerUnboundedString : constant Unbounded_Wide_Wide_String := To_Unbounded_Wide_Wide_String (Source => LeerString);
   LeerZeichen : constant Wide_Wide_Character := ' ';
   Trennzeichen : constant Wide_Wide_String (1 .. 1) := "/";
   StandardAbstand : constant Wide_Wide_String (1 .. 4) := "    ";
   UmbruchAbstand : constant Wide_Wide_String (1 .. 5) := Ada.Characters.Wide_Wide_Latin_1.LF & StandardAbstand;
   
   -- Für Verzeichnisse
   Spielstand : constant String (1 .. 11) := "Spielstand/";
   
   EinheitenDatenbank : constant String (1 .. 30) := "Datenbanken/EinheitenDatenbank";
   ForschungenDatenbank : constant String (1 .. 32) := "Datenbanken/ForschungenDatenbank";
   GebaeudeDatenbank : constant String (1 .. 29) := "Datenbanken/GebaeudeDatenbank";
   KartenGrundDatenbank : constant String (1 .. 32) := "Datenbanken/KartenGrundDatenbank";
   KartenFlussDatenbank : constant String (1 .. 32) := "Datenbanken/KartenFlussDatenbank";
   KartenRessourcenDatenbank : constant String (1 .. 37) := "Datenbanken/KartenRessourcenDatenbank";
   VerbesserungenDatenbank : constant String (1 .. 35) := "Datenbanken/VerbesserungenDatenbank";
   WegeDatenbank : constant String (1 .. 25) := "Datenbanken/WegeDatenbank";
   RassenDatenbank : constant String (1 .. 27) := "Datenbanken/RassenDatenbank";
   
   Einstellungen : constant String (1 .. 13) := "Einstellungen";
   Tastenbelegung : constant String (1 .. 14) := "Tastenbelegung";
   
   -- Überall entsprechend einbauen. äöü
   StartpositionText : constant Sf.System.Vector2.sfVector2f := (5.00, 5.00);
   
   TextbreiteZusatzwert : constant Float := StartpositionText.x * 5.00;
   TexthöheZusatzwert : constant Float := StartpositionText.y * 3.00;
   LeerTextbreite : constant Float := 0.00;

end TextKonstanten;
