pragma SPARK_Mode (On);

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with SystemDatentypen;

package SystemKonstanten is

   -- Für die Auswahl
   LeerKonstante : constant SystemDatentypen.Rückgabe_Werte_Enum := SystemDatentypen.Leer;
   StartWeiterKonstante : constant SystemDatentypen.Rückgabe_Werte_Enum := SystemDatentypen.Start_Weiter;
   HauptmenüKonstante : constant SystemDatentypen.Rückgabe_Werte_Enum := SystemDatentypen.Hauptmenü;
   SpielBeendenKonstante : constant SystemDatentypen.Rückgabe_Werte_Enum := SystemDatentypen.Spiel_Beenden;
   ZurückKonstante : constant SystemDatentypen.Rückgabe_Werte_Enum := SystemDatentypen.Zurück;
   JaKonstante : constant SystemDatentypen.Rückgabe_Werte_Enum := SystemDatentypen.Ja;
   NeinKonstante : constant SystemDatentypen.Rückgabe_Werte_Enum := SystemDatentypen.Nein;
   SpeichernKonstante : constant SystemDatentypen.Rückgabe_Werte_Enum := SystemDatentypen.Speichern;
   LadenKonstante : constant SystemDatentypen.Rückgabe_Werte_Enum := SystemDatentypen.Laden;
   OptionenKonstante : constant SystemDatentypen.Rückgabe_Werte_Enum := SystemDatentypen.Optionen;
   GrafikKonstante : constant SystemDatentypen.Rückgabe_Werte_Enum := SystemDatentypen.Grafik;
   SoundKonstante : constant SystemDatentypen.Rückgabe_Werte_Enum := SystemDatentypen.Sound;
   SteuerungKonstante : constant SystemDatentypen.Rückgabe_Werte_Enum := SystemDatentypen.Steuerung;
   SonstigesKonstante : constant SystemDatentypen.Rückgabe_Werte_Enum := SystemDatentypen.Sonstiges;
   InformationenKonstante : constant SystemDatentypen.Rückgabe_Werte_Enum := SystemDatentypen.Informationen;
   WiederherstellenKonstante : constant SystemDatentypen.Rückgabe_Werte_Enum := SystemDatentypen.Wiederherstellen;
   WürdigungenKonstante : constant SystemDatentypen.Rückgabe_Werte_Enum := SystemDatentypen.Würdigungen;
   RundeBeendenKonstante : constant SystemDatentypen.Rückgabe_Werte_Enum := SystemDatentypen.Runde_Beenden;
   SiegKonstante : constant SystemDatentypen.Rückgabe_Werte_Enum := SystemDatentypen.Sieg;
   VernichtungKonstante : constant SystemDatentypen.Rückgabe_Werte_Enum := SystemDatentypen.Vernichtung;
   -- Für die Auswahl



   -- Wird das so überhaupt benötigt?
   -- Wartezeiten
   WartezeitLogik : constant Duration := 0.20;
   WartezeitGrafik : constant Duration := 0.0002;
   WartezeitMusik : constant Duration := 0.20;
   WartezeitSound : constant Duration := 0.20;

   WartezeitMinimal : constant Duration := 0.000000002;
   -- Wartezeiten



   -- Für die Zahleneingabe später entfernen
   -- GanzeZahlAbbruchKonstante : constant Integer := -1_000_000_000;
   -- Für die Zahleneingabe



   -- Für die Optionen/Menüs
   JaAnzeigeKonstante : constant Positive := 7;
   NeinAnzeigeKonstante : constant Positive := 8;

   OptionenErsteZeileKonstante : constant Positive := 9;
   OptionenLetzteZeileKonstante : constant Positive := 15;

   OptionenSonstigesErsteZeile : constant Positive := 16;
   OptionenSonstigesLetzteZeile : constant Positive := 20;
   -- Für die Optionen/Menüs



   LeerString : constant Wide_Wide_String := "";
   LeerUnboundedString : constant Unbounded_Wide_Wide_String := To_Unbounded_Wide_Wide_String (Source => LeerString);
   LeerZeichen : constant Wide_Wide_Character := ' ';

end SystemKonstanten;
