with StadtDatentypen;
with EinheitenDatentypen;

package AuswahlKonstanten is
   pragma Pure;

   -- Nur die StadtEinheitenauswahl nutzt aktuell keine 0, eventuell anpassen? äöü
   LeerAuswahl : constant Natural := 0;

   LeerGebäudeauswahl : constant StadtDatentypen.GebäudeIDMitNullwert := StadtDatentypen.GebäudeIDMitNullwert'First;

   LeerEinheitenauswahl : constant EinheitenDatentypen.EinheitenIDMitNullWert := EinheitenDatentypen.EinheitenIDMitNullWert'First;

   LeerStadtEinheitAuswahl : constant EinheitenDatentypen.MaximaleEinheitenMitNullWert := EinheitenDatentypen.MaximaleEinheitenMitNullWert'First;

end AuswahlKonstanten;
