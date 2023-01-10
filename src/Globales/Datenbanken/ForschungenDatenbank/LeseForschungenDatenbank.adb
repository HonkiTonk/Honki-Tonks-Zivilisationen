with ForschungenDatenbank;
with ForschungKonstanten;
with ProduktionKonstanten;

package body LeseForschungenDatenbank is

   function Kosten
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      IDExtern : in ForschungenDatentypen.ForschungIDMitNullWert)
      return ProduktionDatentypen.Lagermenge
   is begin

      case
        IDExtern
      is
         when ForschungKonstanten.LeerForschung =>
            return ProduktionKonstanten.LeerProduktion;

         when others =>
            return ForschungenDatenbank.Forschungsliste (SpeziesExtern, IDExtern).Kosten;
      end case;

   end Kosten;



   function AnforderungForschung
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      IDExtern : in ForschungenDatentypen.ForschungIDMitNullWert;
      WelcheAnforderungExtern : in ForschungenDatentypen.Forschung_Anforderung_Enum)
      return ForschungenDatentypen.ForschungIDNichtMöglich
   is begin

      case
        IDExtern
      is
         when ForschungKonstanten.LeerForschung =>
            return ForschungKonstanten.ForschungUnmöglich;

         when others =>
            return ForschungenDatenbank.Forschungsliste (SpeziesExtern, IDExtern).Anforderung (WelcheAnforderungExtern);
      end case;

   end AnforderungForschung;



   function Verbesserungen
     (VerbesserungExtern : in BefehleDatentypen.Siedler_Verbesserung_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return ForschungenDatentypen.ForschungIDNichtMöglich
   is begin

      return ForschungenDatenbank.TechnologieVerbesserungen (VerbesserungExtern, SpeziesExtern);

   end Verbesserungen;



   function Wege
     (WegExtern : in AufgabenDatentypen.Einheitenbefehle_Wege_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return ForschungenDatentypen.ForschungIDNichtMöglich
   is begin

      return ForschungenDatenbank.TechnologieWege (WegExtern, SpeziesExtern);

   end Wege;



   function Umgebung
     (AnfangEndeExtern : in SystemDatentypen.Anfang_Ende_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return ForschungenDatentypen.ForschungIDNichtMöglich
   is begin

      return ForschungenDatenbank.TechnologieUmgebungsgröße (AnfangEndeExtern, SpeziesExtern);

   end Umgebung;

end LeseForschungenDatenbank;
