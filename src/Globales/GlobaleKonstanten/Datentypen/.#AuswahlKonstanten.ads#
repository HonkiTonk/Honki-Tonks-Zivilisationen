with StadtDatentypen;
with EinheitenDatentypen;

package AuswahlKonstanten is
   pragma Pure;

   -- Nur die StadtEinheitenauswahl nutzt aktuell keine 0, eventuell anpassen? äöü
   -- Also um eine LeerStadtEinheitenauswahl erweitern? äöü
   LeerAuswahl : constant Natural := 0;
   ErstAuswahl : constant Positive := 1;

   StandardanzahlMenütexte : constant Positive := 15;
   StandardanzahlMenütexteFloat : constant Float := Float (StandardanzahlMenütexte);

   LeerGebäudeauswahl : constant StadtDatentypen.GebäudeID := StadtDatentypen.GebäudeID'First;

   LeerEinheitenauswahl : constant EinheitenDatentypen.EinheitenID := EinheitenDatentypen.EinheitenID'First;

   LeerStadtEinheitAuswahl : constant EinheitenDatentypen.Einheitenbereich := EinheitenDatentypen.Einheitenbereich'First;



   -- Für das Speichersystem
   SpielstandlisteAnfang : constant Positive := 1;
   SpielstandlisteEnde : constant Positive := 10;
   MehrAnzeigen : constant Positive := 11;
   NeuerSpielstand : constant Positive := 12;
   Löschen : constant Positive := 13;
   Zurück : constant Positive := 14;

   ManuellerSpielstand : constant Integer := -1;
   AutomatischerSpielstand : constant Integer := -2;
   -- Für das Speichersystem

end AuswahlKonstanten;
