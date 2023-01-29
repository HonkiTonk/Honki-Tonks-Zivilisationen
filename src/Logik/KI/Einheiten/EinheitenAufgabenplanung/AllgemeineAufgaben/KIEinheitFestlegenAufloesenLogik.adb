with ProduktionDatentypen;

with SchreibeEinheitenGebaut;
with LeseWichtiges;
with LeseStadtGebaut;
with LeseEinheitenGebaut;
with LeseEinheitenDatenbank;

with KIDatentypen;

with KIStadtLaufendeBauprojekteLogik;

-- Man könnte auch noch den Gesundheitsstatus der Einheit mit berücksichtigen. äöü
-- Eventuell immer noch einen Siedler übrig lassen? äöü
package body KIEinheitFestlegenAufloesenLogik is

   function EinheitAuflösen
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
   is begin
      
      case
        Auflösungsprüfung (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern)
      is
         when True =>
            SchreibeEinheitenGebaut.KIBeschäftigt (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                    AufgabeExtern              => KIDatentypen.Einheit_Auflösen_Enum);
            return True;
            
         when False =>
            return False;
      end case;
      
   end EinheitAuflösen;
   
   
   
   function Auflösungsprüfung
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
   is
      use type EinheitenDatentypen.MaximaleEinheitenMitNullWert;
   begin
      
      VorhandeneEinheiten := LeseWichtiges.AnzahlEinheiten (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies);
         
      if
        VorhandeneEinheiten > LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
        or
          VorhandeneEinheiten
            + KIStadtLaufendeBauprojekteLogik.EinheitenInProduktion (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) > LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
      then
         return True;
         
      elsif
        Stadtzustand (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern) = True
      then
         return True;
         
      elsif
        GlobalerZustand (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern) = True
      then
         return True;
         
      else
         return False;
      end if;
            
   end Auflösungsprüfung;
   
   
   
   -- In einzelne Bereiche aufteilen? äöü
   function Stadtzustand
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
   is
      use type ProduktionDatentypen.Produktion;
   begin
      
      Heimatstadt := LeseEinheitenGebaut.Heimatstadt (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      
      case
        Heimatstadt
      is
         when EinheitenKonstanten.LeerHeimatstadt =>
            return False;
            
         when others =>
            EinheitID := LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      end case;
      
      if
        LeseStadtGebaut.Nahrungsproduktion (StadtSpeziesNummerExtern => (EinheitSpeziesNummerExtern.Spezies, Heimatstadt)) < 0
        and
          LeseEinheitenDatenbank.PermanenteKosten (SpeziesExtern      => EinheitSpeziesNummerExtern.Spezies,
                                                   IDExtern           => EinheitID,
                                                   WelcheKostenExtern => ProduktionDatentypen.Nahrung_Enum)
        > 0
      then
         return True;
         
      elsif
        LeseStadtGebaut.Produktionrate (StadtSpeziesNummerExtern => (EinheitSpeziesNummerExtern.Spezies, Heimatstadt)) < 0
        and
          LeseEinheitenDatenbank.PermanenteKosten (SpeziesExtern      => EinheitSpeziesNummerExtern.Spezies,
                                                   IDExtern           => EinheitID,
                                                   WelcheKostenExtern => ProduktionDatentypen.Produktion_Enum)
        > 0
      then
         return True;
         
      else
         return False;
      end if;
      
   end Stadtzustand;
   
   
   
   function GlobalerZustand
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
   is
      use type ProduktionDatentypen.Produktion;
   begin
      
      case
        EinheitSpeziesNummerExtern.Spezies
      is
         when SpeziesDatentypen.Ekropa_Enum =>
            return False;
            
         when others =>
            null;
      end case;
         
      if
        LeseEinheitenDatenbank.PermanenteKosten (SpeziesExtern      => EinheitSpeziesNummerExtern.Spezies,
                                                 IDExtern           => LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern),
                                                 WelcheKostenExtern => ProduktionDatentypen.Geld_Enum)
        > 0
        and
          LeseWichtiges.GeldZugewinnProRunde (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) < 0
      then
         return True;
            
      else
         return False;
      end if;
      
   end GlobalerZustand;

end KIEinheitFestlegenAufloesenLogik;
