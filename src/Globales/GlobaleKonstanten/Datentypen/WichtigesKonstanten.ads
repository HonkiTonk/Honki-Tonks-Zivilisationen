with StadtDatentypen;
with EinheitenDatentypen;
with ForschungenDatentypen;
with ProduktionDatentypen;
with ZahlenDatentypen;
with DiplomatieDatentypen;

package WichtigesKonstanten is
   pragma Pure;
   
   LeerGeldmenge : constant ZahlenDatentypen.EigenesNatural := ZahlenDatentypen.EigenesNatural'First;
   LeerGeldZugewinnProRunde : constant ProduktionDatentypen.Produktion := 0;
   LeerGesamteForschungsrate : constant ProduktionDatentypen.Produktion := 0;
   LeerForschungsmenge : constant ProduktionDatentypen.Produktion := 0;
   LeerVerbleibendeForschungszeit : constant ProduktionDatentypen.Produktion := ProduktionDatentypen.Produktion'Last;
   LeerForschungsprojekt : constant ForschungenDatentypen.ForschungID := ForschungenDatentypen.ForschungID'First;
   LeerErforscht : constant Boolean := False;
   LeerAnzahlStädte : constant StadtDatentypen.Städtebereich := StadtDatentypen.Städtebereich'First;
   LeerAnzahlArbeiter : constant EinheitenDatentypen.Einheitenbereich := EinheitenDatentypen.Einheitenbereich'First;
   LeerAnzahlKämpfer : constant EinheitenDatentypen.Einheitenbereich := EinheitenDatentypen.Einheitenbereich'First;
   LeerAnzahlSonstiges : constant EinheitenDatentypen.Einheitenbereich := EinheitenDatentypen.Einheitenbereich'First;
   
   
   
   LeerStädtegrenze : constant StadtDatentypen.StädtebereichVorhanden := StadtDatentypen.StädtebereichVorhanden'Last;
   LeerEinheitengrenze : constant EinheitenDatentypen.EinheitenbereichVorhanden := EinheitenDatentypen.EinheitenbereichVorhanden'Last;
   LeerGeldgrenze : constant ZahlenDatentypen.EigenerInteger := ZahlenDatentypen.EigenerInteger'Last;
   LeerForschungsgrenze : constant ProduktionDatentypen.Produktion:= ProduktionDatentypen.Produktion'Last;
   LeerGeldgewinngrenze : constant ProduktionDatentypen.Produktion := ProduktionDatentypen.Produktion'Last;
   LeerForschungGewinngrenze : constant ProduktionDatentypen.Produktion := ProduktionDatentypen.Produktion'Last;
   LeerSpeziesRundengrenze : constant ZahlenDatentypen.EigenesNatural := ZahlenDatentypen.EigenesNatural'First;

   
   
   LeerAktuellerZustand : constant DiplomatieDatentypen.Status_Untereinander_Enum := DiplomatieDatentypen.Unbekannt_Enum;
   LeerAktuelleSympathieBewertung : constant DiplomatieDatentypen.Meinung := 0;
   LeerZeitSeitLetzterÄnderung : constant ZahlenDatentypen.EigenesNatural := ZahlenDatentypen.EigenesNatural'First;
   DiplomatischerStatusÄnderungszeit : constant Positive := 10;
   
   
   
   KeinZusammenbruch : constant ZahlenDatentypen.EigenerInteger := -1;
   Zusammenbruch : constant ZahlenDatentypen.EigenesNatural := 0;

end WichtigesKonstanten;
