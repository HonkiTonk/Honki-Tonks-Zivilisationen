pragma Warnings (Off, "*array aggregate*");

with KartenRecords; use KartenRecords;
with EinheitenKonstanten;

with LeseEinheitenDatenbank;
with LeseEinheitenGebaut;

-- Umbenennen nach TransporterDurchsuchen?
package body TransporterSuchenLogik is

   function KoordinatenTransporterMitRasseSuchen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return EinheitenDatentypen.MaximaleEinheitenMitNullWert
   is begin
      
      EinheitSchleife:
      for EinheitNummerSchleifenwert in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (RasseExtern).Einheitengrenze loop
         
         if
           LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => (RasseExtern, EinheitNummerSchleifenwert)) /= KoordinatenExtern
         then
            null;
            
         elsif
           EinheitenKonstanten.LeerKannTransportieren = LeseEinheitenDatenbank.KannTransportieren (RasseExtern => RasseExtern,
                                                                                                   IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (RasseExtern, EinheitNummerSchleifenwert)))
         then
            null;
            
         else
            return EinheitNummerSchleifenwert;
         end if;
         
      end loop EinheitSchleife;
      
      return EinheitenKonstanten.LeerNummer;
      
   end KoordinatenTransporterMitRasseSuchen;
   
   
   
   function EinheitAufTransporterSuchen
     (TransporterExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      LadungExtern : in EinheitenDatentypen.MaximaleEinheiten)
      return EinheitenDatentypen.Transportplätze
   is begin
      
      Transporterkapazität := LeseEinheitenDatenbank.Transportkapazität (RasseExtern => TransporterExtern.Rasse,
                                                                           IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => TransporterExtern));

      TransporterSchleife:
      for TransporterPlatzSchleifenwert in EinheitenRecords.TransporterArray'First .. Transporterkapazität loop
         
         if
           LadungExtern = LeseEinheitenGebaut.Transportiert (EinheitRasseNummerExtern => TransporterExtern,
                                                             PlatzExtern              => TransporterPlatzSchleifenwert)
         then
            return TransporterPlatzSchleifenwert;
            
         else
            null;
         end if;
         
      end loop TransporterSchleife;
      
      return EinheitenKonstanten.LeerTransportkapazität;
      
   end EinheitAufTransporterSuchen;



   function HatTransporterLadung
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      Transporterkapazität := LeseEinheitenDatenbank.Transportkapazität (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                           IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
      
      TransporterSchleife:
      for TransporterPlatzSchleifenwert in EinheitenRecords.TransporterArray'First .. Transporterkapazität loop
         
         if
           EinheitenKonstanten.LeerTransportiert /= LeseEinheitenGebaut.Transportiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                                       PlatzExtern              => TransporterPlatzSchleifenwert)
         then
            return True;
            
         else
            null;
         end if;
         
      end loop TransporterSchleife;
      
      return False;
      
   end HatTransporterLadung;
   
   
   
   function FreierPlatz
     (TransporterExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return EinheitenDatentypen.Transportplätze
   is begin
      
      Transporterkapazität := LeseEinheitenDatenbank.Transportkapazität (RasseExtern => TransporterExtern.Rasse,
                                                                           IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => TransporterExtern));
      
      TransporterSchleife:
      for FreierPlatzSchleifenwert in EinheitenRecords.TransporterArray'First .. Transporterkapazität loop
        
         case
           LeseEinheitenGebaut.Transportiert (EinheitRasseNummerExtern => TransporterExtern,
                                              PlatzExtern              => FreierPlatzSchleifenwert)
         is
            when EinheitenKonstanten.LeerTransportiert =>
               return FreierPlatzSchleifenwert;
               
            when others =>
               null;
         end case;
         
      end loop TransporterSchleife;
      
      return EinheitenKonstanten.LeerTransportkapazität;
      
   end FreierPlatz;

end TransporterSuchenLogik;
