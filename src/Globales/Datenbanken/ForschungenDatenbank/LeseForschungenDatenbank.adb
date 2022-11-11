with ForschungenDatenbank;

-- Zum Schreiben der Datenbanken wird später noch eine Schreibevariante benötigt. äöü
-- Gilt auch für die andere Datenbanken. äöü
package body LeseForschungenDatenbank is

   function Kosten
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in ForschungenDatentypen.ForschungID)
      return ProduktionDatentypen.Lagermenge
   is begin

      return ForschungenDatenbank.Forschungsliste (RasseExtern, IDExtern).Kosten;

   end Kosten;



   function AnforderungForschung
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in ForschungenDatentypen.ForschungID;
      WelcheAnforderungExtern : in ForschungenDatentypen.Forschung_Anforderung_Enum)
      return ForschungenDatentypen.ForschungIDNichtMöglich
   is begin

      return ForschungenDatenbank.Forschungsliste (RasseExtern, IDExtern).Anforderung (WelcheAnforderungExtern);

   end AnforderungForschung;



   function Verbesserungen
     (VerbesserungExtern : in BefehleDatentypen.Siedler_Verbesserung_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return ForschungenDatentypen.ForschungIDNichtMöglich
   is begin

      return ForschungenDatenbank.TechnologieVerbesserungen (VerbesserungExtern, RasseExtern);

   end Verbesserungen;



   function Wege
     (WegExtern : in AufgabenDatentypen.Einheitenbefehle_Wege_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return ForschungenDatentypen.ForschungIDNichtMöglich
   is begin

      return ForschungenDatenbank.TechnologieWege (WegExtern, RasseExtern);

   end Wege;



   function Umgebung
     (AnfangEndeExtern : in SystemDatentypen.Anfang_Ende_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return ForschungenDatentypen.ForschungIDNichtMöglich
   is begin

      return ForschungenDatenbank.TechnologieUmgebungsgröße (AnfangEndeExtern, RasseExtern);

   end Umgebung;

end LeseForschungenDatenbank;
