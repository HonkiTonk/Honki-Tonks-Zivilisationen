-- with GlobaleDatentypen;
-- use GlobaleDatentypen;

package GlobaleKonstanten is

   -- Für die Auswahl
   StartNormalKonstante : constant Integer := 1;
   HauptmenüKonstante : constant Integer := 0;
   SpielBeendenKonstante : constant Integer := -1;
   ZurückKonstante : constant Integer := -2;
   JaKonstante : constant Integer := -3;
   NeinKonstante : constant Integer := -4;
   SpeichernKonstante : constant Integer := 2;
   LadenKonstante : constant Integer := 3;
   OptionenKonstante : constant Integer := 4;
   InformationenKonstante : constant Integer := 5;
   -- Für die Auswahl



   -- Für die Eingabe
   GanzeZahlAbbruchKonstante : constant Integer := -1_000_000_000;
   -- Für die Eingabe



   -- Für die Optionen/Menüs
   JaAnzeigeKonstante : constant Integer := 10;
   NeinAnzeigeKonstante : constant Integer := 11;

   OptionenErsteZeileKonstante : constant Integer := 14;
   OptionenLetzteZeileKonstante : constant Integer := 20;

   OptionenSonstigesErsteZeile : constant Integer := 23;
   OptionenSonstigesLetzteZeile : constant Integer := 27;
   -- Für die Optionen/Menüs



   -- Für Einheiten/Städte
   RückgabeEinheitStadtNummerFalsch : constant Natural := 0;
   -- Für Einheiten/Städte

end GlobaleKonstanten;
