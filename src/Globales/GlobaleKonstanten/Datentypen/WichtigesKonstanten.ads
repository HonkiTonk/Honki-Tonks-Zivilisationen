with SystemDatentypenHTSEB;

with StadtDatentypen;
with EinheitenDatentypen;
with ForschungenDatentypen;
with ProduktionDatentypen;
with DiplomatieDatentypen;

package WichtigesKonstanten is
   pragma Pure;
   
   LeerGeldmenge : constant SystemDatentypenHTSEB.EigenesNatural := SystemDatentypenHTSEB.EigenesNatural'First;
   LeerGeldZugewinnProRunde : constant ProduktionDatentypen.Produktion := 0;
   LeerGesamteForschungsrate : constant ProduktionDatentypen.Produktion := 0;
   LeerForschungsmenge : constant ProduktionDatentypen.Produktion := 0;
   LeerVerbleibendeForschungszeit : constant ProduktionDatentypen.Produktion := ProduktionDatentypen.Produktion'Last;
   LeerForschungsprojekt : constant ForschungenDatentypen.ForschungIDMöglich := ForschungenDatentypen.ForschungIDMöglich'First;
   LeerErforscht : constant Boolean := False;
   LeerAnzahlStädte : constant StadtDatentypen.StädtebereichBasis := StadtDatentypen.StädtebereichBasis'First;
   LeerAnzahlArbeiter : constant EinheitenDatentypen.EinheitenbereichBasis := EinheitenDatentypen.EinheitenbereichBasis'First;
   LeerAnzahlKämpfer : constant EinheitenDatentypen.EinheitenbereichBasis := EinheitenDatentypen.EinheitenbereichBasis'First;
   LeerAnzahlSonstiges : constant EinheitenDatentypen.EinheitenbereichBasis := EinheitenDatentypen.EinheitenbereichBasis'First;
   
   
   
   LeerStädtegrenze : constant StadtDatentypen.StädtebereichVorhanden := StadtDatentypen.StädtebereichVorhanden'Last;
   LeerEinheitengrenze : constant EinheitenDatentypen.EinheitenbereichVorhanden := EinheitenDatentypen.EinheitenbereichVorhanden'Last;
   LeerGeldgrenze : constant SystemDatentypenHTSEB.EigenerInteger := SystemDatentypenHTSEB.EigenerInteger'Last;
   LeerForschungsgrenze : constant ProduktionDatentypen.Produktion:= ProduktionDatentypen.Produktion'Last;
   LeerGeldgewinngrenze : constant ProduktionDatentypen.Produktion := ProduktionDatentypen.Produktion'Last;
   LeerForschungGewinngrenze : constant ProduktionDatentypen.Produktion := ProduktionDatentypen.Produktion'Last;
   LeerSpeziesRundengrenze : constant SystemDatentypenHTSEB.EigenesNatural := SystemDatentypenHTSEB.EigenesNatural'First;

   
   
   LeerAktuellerZustand : constant DiplomatieDatentypen.Status_Untereinander_Enum := DiplomatieDatentypen.Unbekannt_Enum;
   LeerAktuelleSympathieBewertung : constant DiplomatieDatentypen.MeinungBasis := 0;
   LeerZeitSeitLetzterÄnderung : constant SystemDatentypenHTSEB.EigenesNatural := SystemDatentypenHTSEB.EigenesNatural'First;
   DiplomatischerStatusÄnderungszeit : constant Positive := 10;
   
   
   
   KeinZusammenbruch : constant SystemDatentypenHTSEB.EigenerInteger := -1;
   Zusammenbruch : constant SystemDatentypenHTSEB.EigenesNatural := 0;

end WichtigesKonstanten;
