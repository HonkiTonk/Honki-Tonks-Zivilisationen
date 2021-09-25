pragma SPARK_Mode (On);

package SystemKonstanten is

   -- Für die Auswahl
   StartNormalKonstante : constant Positive := 1;
   HauptmenüKonstante : constant Natural := 0;
   SpielBeendenKonstante : constant Integer := -1;
   ZurückKonstante : constant Integer := -2;
   JaKonstante : constant Integer := -3;
   NeinKonstante : constant Integer := -4;
   SpeichernKonstante : constant Positive := 2;
   LadenKonstante : constant Positive := 3;
   OptionenKonstante : constant Positive := 4;
   InformationenKonstante : constant Positive := 5;
   WiederherstellenKonstante : constant Positive := 6;
   WürdigungenKonstante : constant Positive := 7;
   RundeBeendenKonstante : constant Integer := -1_000;
   SiegKonstante : constant Positive := 1_000;
   VernichtungKonstante : constant Positive := 2_000;
   -- Für die Auswahl



   -- Für die Spieleinstellungen
   AuswahlKartengröße : constant Positive := 1;
   AuswahlKartenart : constant Positive := 2;
   AuswahlKartenform : constant Positive := 3;
   AuswahlKartentemperatur : constant Positive := 4;
   AuswahlSpieleranzahl : constant Positive := 5;
   AuswahlBelegung : constant Positive := 6;
   AuswahlSchwierigkeitsgrad : constant Positive := 7;
   AuswahlFertig : constant Positive := 8;
   AuswahlKartenressourcen : constant Positive := 9;
   -- Für die Spieleinstellungen



   -- Für die Zahleneingabe
   GanzeZahlAbbruchKonstante : constant Integer := -1_000_000_000;
   -- Für die Zahleneingabe



   -- Für die Optionen/Menüs
   JaAnzeigeKonstante : constant Positive := 7;
   NeinAnzeigeKonstante : constant Positive := 8;

   OptionenErsteZeileKonstante : constant Positive := 9;
   OptionenLetzteZeileKonstante : constant Positive := 15;

   OptionenSonstigesErsteZeile : constant Positive := 16;
   OptionenSonstigesLetzteZeile : constant Positive := 20;
   -- Für die Optionen/Menüs

end SystemKonstanten;
