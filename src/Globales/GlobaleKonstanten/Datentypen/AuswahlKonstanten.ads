with StadtDatentypen;
with EinheitenDatentypen;

package AuswahlKonstanten is
   pragma Pure;

   -- Nur die StadtEinheitenauswahl nutzt aktuell keine 0, eventuell anpassen? äöü
   -- Also um eine LeerStadtEinheitenauswahl erweitern? äöü
   LeerAuswahl : constant Natural := 0;

   LeerGebäudeauswahl : constant StadtDatentypen.GebäudeIDMitNullwert := StadtDatentypen.GebäudeIDMitNullwert'First;

   LeerEinheitenauswahl : constant EinheitenDatentypen.EinheitenID := EinheitenDatentypen.EinheitenID'First;

   LeerStadtEinheitAuswahl : constant EinheitenDatentypen.Einheitenbereich := EinheitenDatentypen.Einheitenbereich'First;

end AuswahlKonstanten;
