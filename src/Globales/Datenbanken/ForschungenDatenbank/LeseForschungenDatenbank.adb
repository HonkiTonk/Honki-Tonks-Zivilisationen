pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with ForschungenDatenbank;

-- Das Lesen und Schreiben von Datenbanken mal in die Datenbanken selbst schieben? Dann könnte ich die Variablen private machen. äöü
-- Wobei, würde das private nicht auch ein Schreiben der Datenbanken verhindern? äöü
package body LeseForschungenDatenbank is

   function PreisForschung
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in ForschungenDatentypen.ForschungID)
      return ProduktionDatentypen.Produktion
   is begin

      return ForschungenDatenbank.Forschungsliste (RasseExtern, IDExtern).PreisForschung;

   end PreisForschung;



   function AnforderungForschung
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      IDExtern : in ForschungenDatentypen.ForschungID;
      WelcheAnforderungExtern : in ForschungenDatentypen.Forschung_Anforderung_Enum)
      return ForschungenDatentypen.ForschungIDNichtMöglich
   is begin

      return ForschungenDatenbank.Forschungsliste (RasseExtern, IDExtern).AnforderungForschung (WelcheAnforderungExtern);

   end AnforderungForschung;



   function Verbesserungen
     (VerbesserungExtern : in TastenbelegungDatentypen.Tastenbelegung_Verbesserung_Befehle_Enum;
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
