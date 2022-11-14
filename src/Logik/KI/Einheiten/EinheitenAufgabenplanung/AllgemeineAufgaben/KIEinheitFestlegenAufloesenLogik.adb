with ProduktionDatentypen;
with EinheitenKonstanten;

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
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      case
        Auflösungsprüfung (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
      is
         when True =>
            SchreibeEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    AufgabeExtern            => KIDatentypen.Einheit_Auflösen_Enum);
            return True;
            
         when False =>
            return False;
      end case;
      
   end EinheitAuflösen;
   
   
   
   function Auflösungsprüfung
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is
      use type EinheitenDatentypen.MaximaleEinheitenMitNullWert;
   begin
      
      VorhandeneEinheiten := LeseWichtiges.AnzahlEinheiten (RasseExtern => EinheitRasseNummerExtern.Rasse);
         
      if
        VorhandeneEinheiten > SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
        or
          VorhandeneEinheiten + KIStadtLaufendeBauprojekteLogik.EinheitenInProduktion (RasseExtern => EinheitRasseNummerExtern.Rasse) > SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
      then
         return True;
         
      elsif
        Stadtzustand (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = True
      then
         return True;
         
      elsif
        GlobalerZustand (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = True
      then
         return True;
         
      else
         return False;
      end if;
            
   end Auflösungsprüfung;
   
   
   
   -- In einzelne Bereiche aufteilen? äöü
   function Stadtzustand
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is
      use type ProduktionDatentypen.Produktion;
   begin
      
      Heimatstadt := LeseEinheitenGebaut.Heimatstadt (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      case
        Heimatstadt
      is
         when EinheitenKonstanten.LeerHeimatstadt =>
            return False;
            
         when others =>
            EinheitID := LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      end case;
      
      if
        LeseStadtGebaut.Nahrungsproduktion (StadtRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, Heimatstadt)) < 0
        and
          LeseEinheitenDatenbank.PermanenteKosten (RasseExtern        => EinheitRasseNummerExtern.Rasse,
                                                   IDExtern           => EinheitID,
                                                   WelcheKostenExtern => ProduktionDatentypen.Nahrung_Enum)
        > 0
      then
         return True;
         
      elsif
        LeseStadtGebaut.Produktionrate (StadtRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, Heimatstadt)) < 0
        and
          LeseEinheitenDatenbank.PermanenteKosten (RasseExtern        => EinheitRasseNummerExtern.Rasse,
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
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is
      use type ProduktionDatentypen.Produktion;
   begin
      
      case
        EinheitRasseNummerExtern.Rasse
      is
         when RassenDatentypen.Ekropa_Enum =>
            return False;
            
         when others =>
            null;
      end case;
         
      if
        LeseEinheitenDatenbank.PermanenteKosten (RasseExtern        => EinheitRasseNummerExtern.Rasse,
                                                 IDExtern           => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                                 WelcheKostenExtern => ProduktionDatentypen.Geld_Enum)
        > 0
        and
          LeseWichtiges.GeldZugewinnProRunde (RasseExtern => EinheitRasseNummerExtern.Rasse) < 0
      then
         return True;
            
      else
         return False;
      end if;
      
   end GlobalerZustand;

end KIEinheitFestlegenAufloesenLogik;
