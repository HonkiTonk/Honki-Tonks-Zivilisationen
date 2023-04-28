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
   LeerForschungsprojekt : constant ForschungenDatentypen.ForschungIDMitNullWert := ForschungenDatentypen.ForschungIDMitNullWert'First;
   LeerErforscht : constant Boolean := False;
   LeerAnzahlStädte : constant StadtDatentypen.MaximaleStädteMitNullWert := StadtDatentypen.MaximaleStädteMitNullWert'First;
   LeerAnzahlArbeiter : constant EinheitenDatentypen.MaximaleEinheitenMitNullWert := EinheitenDatentypen.MaximaleEinheitenMitNullWert'First;
   LeerAnzahlKämpfer : constant EinheitenDatentypen.MaximaleEinheitenMitNullWert := EinheitenDatentypen.MaximaleEinheitenMitNullWert'First;
   LeerAnzahlSonstiges : constant EinheitenDatentypen.MaximaleEinheitenMitNullWert := EinheitenDatentypen.MaximaleEinheitenMitNullWert'First;
   
   
   
   LeerStädtegrenze : constant StadtDatentypen.MaximaleStädte := StadtDatentypen.MaximaleStädte'Last;
   LeerEinheitengrenze : constant EinheitenDatentypen.MaximaleEinheiten := EinheitenDatentypen.MaximaleEinheiten'Last;
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
