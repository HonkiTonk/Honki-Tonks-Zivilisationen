package ViewKonstanten is
   pragma Pure;
   
   MenüAuswahl : constant Positive := 1;
   MenüZusatztext : constant Positive := MenüAuswahl + 1;
      
   WeltKarte : constant Positive := 1;
   WeltBefehleRechts : constant Positive := WeltKarte + 1;
   WeltBefehleLinks : constant Positive := WeltBefehleRechts + 1;
   WeltEinheitenbefehleRechts : constant Positive := WeltBefehleLinks + 1;
   WeltEinheitenbefehleLinks : constant Positive := WeltEinheitenbefehleRechts + 1;
   WeltSeitenleiste : constant Positive := WeltEinheitenbefehleLinks + 1;

   StadtUmgebung : constant Positive := 1;
   StadtInformationen : constant Positive := StadtUmgebung + 1;
   StadtBefehle : constant Positive := StadtInformationen + 1;
   StadtKarte : constant Positive := StadtBefehle + 1;
   
   BaumenüKategorie : constant Positive := 1;
   BaumenüBauliste : constant Positive := BaumenüKategorie + 1;
   BaumenüInformationen : constant Positive := BaumenüBauliste + 1;
   BaumenüBeschreibung : constant Positive := BaumenüInformationen + 1;
   BaumenüAktuell : constant Positive := BaumenüBeschreibung + 1;
   BaumenüGebäudelisteVerkaufen : constant Positive := BaumenüAktuell + 1;
   BaumenüGebäudeinformationenVerkaufen : constant Positive := BaumenüGebäudelisteVerkaufen + 1;
   BaumenüGebäudebeschreibungVerkaufen : constant Positive := BaumenüGebäudeinformationenVerkaufen + 1;
   
   ForschungsmenüForschungsliste : constant Positive := 1;
   ForschungsmenüErmöglicht : constant Positive := ForschungsmenüForschungsliste + 1;
   ForschungsmenüBeschreibung : constant Positive := ForschungsmenüErmöglicht + 1;
   ForschungsmenüAktuell : constant Positive := ForschungsmenüBeschreibung + 1;
   ForschungsmenüErfolg : constant Positive := ForschungsmenüAktuell + 1;
   
   Frage : constant Positive := 1;
   Antwort : constant Positive := Frage + 1;
   
   SteuerungKategorie : constant Positive := 1;
   SteuerungAuswahl : constant Positive := SteuerungKategorie + 1;
   
   SpielstandKategorie : constant Positive := 1;
   SpielstandAuswahl : constant Positive := SpielstandKategorie + 1;
   
   InformationsfeldStadtkarte : constant Positive := 1;
   InformationenFeldproduktion : constant Positive := InformationsfeldStadtkarte + 1;
   
   AuswahlbereichStadt : constant Positive := 1;
   AuswahlbereichEinheit : constant Positive := AuswahlbereichStadt + 1;

end ViewKonstanten;
