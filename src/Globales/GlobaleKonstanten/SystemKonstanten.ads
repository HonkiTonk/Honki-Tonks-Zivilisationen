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



   -- Für Spieleinstellungen


   SchwierigkeitLeichtKonstante : constant SystemDatentypen.Schwierigkeitsgrad_Verwendet_Enum := SystemDatentypen.Schwierigkeit_Leicht;
   SchwierigkeitMittelKonstante : constant SystemDatentypen.Schwierigkeitsgrad_Verwendet_Enum := SystemDatentypen.Schwierigkeit_Mittel;
   SchwierigkeitSchwerKonstante : constant SystemDatentypen.Schwierigkeitsgrad_Verwendet_Enum := SystemDatentypen.Schwierigkeit_Schwer;
   -- Für Spieleinstellungen



   -- Für Rassenoptionen
   LeerRasse : constant SystemDatentypen.Rassen_Enum := SystemDatentypen.Keine_Rasse;

   MenschenKonstante : constant SystemDatentypen.Rassen_Verwendet_Enum := SystemDatentypen.Menschen;
   KasrodiahKonstante : constant SystemDatentypen.Rassen_Verwendet_Enum := SystemDatentypen.Kasrodiah;
   LasupinKonstante : constant SystemDatentypen.Rassen_Verwendet_Enum := SystemDatentypen.Lasupin;
   LamustraKonstante : constant SystemDatentypen.Rassen_Verwendet_Enum := SystemDatentypen.Lamustra;
   ManukyKonstante : constant SystemDatentypen.Rassen_Verwendet_Enum := SystemDatentypen.Manuky;
   SurokaKonstante : constant SystemDatentypen.Rassen_Verwendet_Enum := SystemDatentypen.Suroka;
   PryolonKonstante : constant SystemDatentypen.Rassen_Verwendet_Enum := SystemDatentypen.Pryolon;
   TalbidahrKonstante : constant SystemDatentypen.Rassen_Verwendet_Enum := SystemDatentypen.Talbidahr;
   MoruPhisihlKonstante : constant SystemDatentypen.Rassen_Verwendet_Enum := SystemDatentypen.Moru_Phisihl;
   LarinosLotarisKonstante : constant SystemDatentypen.Rassen_Verwendet_Enum := SystemDatentypen.Larinos_Lotaris;
   CarupexKonstante : constant SystemDatentypen.Rassen_Verwendet_Enum := SystemDatentypen.Carupex;
   AlaryKonstante : constant SystemDatentypen.Rassen_Verwendet_Enum := SystemDatentypen.Alary;
   TesorahnKonstante : constant SystemDatentypen.Rassen_Verwendet_Enum := SystemDatentypen.Tesorahn;
   NatriesZermanisKonstante : constant SystemDatentypen.Rassen_Verwendet_Enum := SystemDatentypen.Natries_Zermanis;
   TridatusKonstante : constant SystemDatentypen.Rassen_Verwendet_Enum := SystemDatentypen.Tridatus;
   SenelariKonstante : constant SystemDatentypen.Rassen_Verwendet_Enum := SystemDatentypen.Senelari;
   Aspari2Konstante : constant SystemDatentypen.Rassen_Verwendet_Enum := SystemDatentypen.Aspari_2;
   EkropaKonstante : constant SystemDatentypen.Rassen_Verwendet_Enum := SystemDatentypen.Ekropa;
   -- Für Rassenoptionen

end SystemKonstanten;
