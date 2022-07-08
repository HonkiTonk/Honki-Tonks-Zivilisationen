pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with ForschungenDatentypen; use ForschungenDatentypen;

with EinheitenKonstanten;

with LeseEinheitenDatenbank;
with LeseEinheitenGebaut;

with ForschungAllgemein;

with KIDatentypen; use KIDatentypen;

-- with KIKriegErmitteln;
-- with KIGefahrErmitteln;

package body KIEinheitAufgabeModernisieren is

   function SichVerbessern
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KIDatentypen.AufgabenWichtigkeitKlein
   is begin
      
      NeueEinheitenID := LeseEinheitenDatenbank.WirdVerbessertZu (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                  IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
      
      case
        NeueEinheitenID
      is
         when EinheitenKonstanten.LeerID =>
            return -1;
            
         when others =>
            null;
      end case;
      
      case
        ForschungAllgemein.TechnologieVorhanden (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                                 TechnologieExtern => LeseEinheitenDatenbank.Anforderungen (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                                                            IDExtern    => NeueEinheitenID))
      is
         when True =>
            return NeueKosten (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
              
         when False =>
            return -1;
      end case;
      
   end SichVerbessern;
   
   
   
   function NeueKosten
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KIDatentypen.AufgabenWichtigkeitKlein
   is begin
      
      -- Platzhalter
      case
        EinheitRasseNummerExtern.Rasse
      is
         when RassenDatentypen.Ekropa_Enum =>
            null;
            
         when others =>
            null;
      end case;
      
      -------------------------------------- Muss prüfen ob die Heimatstadt das mitmacht und die Geldgewinnung. Und natürlich ob eine benötigte Ressource vorhanden ist.
      
      return 5;
      
   end NeueKosten;

end KIEinheitAufgabeModernisieren;
