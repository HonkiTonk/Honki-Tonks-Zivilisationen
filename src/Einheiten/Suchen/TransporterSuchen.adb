pragma SPARK_Mode (On);

with EinheitenKonstanten;

with LeseEinheitenDatenbank, LeseEinheitenGebaut;

package body TransporterSuchen is

   function KoordinatenTransporterMitRasseSuchen
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.MaximaleEinheitenMitNullWert
   is begin
      
      EinheitSchleife:
      for EinheitNummerSchleifenwert in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (RasseExtern).Einheitengrenze loop
         
         if
           LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => (RasseExtern, EinheitNummerSchleifenwert)) /= KoordinatenExtern
         then
            null;
            
         elsif
           LeseEinheitenDatenbank.KannTransportieren (RasseExtern => RasseExtern,
                                                      IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (RasseExtern, EinheitNummerSchleifenwert)))
           = EinheitenKonstanten.LeerKannTransportieren
         then
            null;
            
         else
            return EinheitNummerSchleifenwert;
         end if;
         
      end loop EinheitSchleife;
      
      return EinheitenKonstanten.LeerNummer;
      
   end KoordinatenTransporterMitRasseSuchen;
   
   
   
   function EinheitAufTransporterSuchen
     (TransporterExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      LadungExtern : in GlobaleDatentypen.MaximaleEinheiten)
      return GlobaleDatentypen.MaximaleEinheitenMitNullWert
   is begin

      TransporterSchleife:
      for 
        TransporterPlatzSchleifenwert
      in
        EinheitStadtRecords.TransporterArray'First .. LeseEinheitenDatenbank.Transportkapazität (RasseExtern => TransporterExtern.Rasse,
                                                                                                  IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => TransporterExtern)) loop
         
         if
           LeseEinheitenGebaut.Transportiert (EinheitRasseNummerExtern => TransporterExtern,
                                              PlatzExtern              => TransporterPlatzSchleifenwert)
           = LadungExtern
         then
            return TransporterPlatzSchleifenwert;
            
         else
            null;
         end if;
         
      end loop TransporterSchleife;
      
      return EinheitenKonstanten.LeerNummer;
      
   end EinheitAufTransporterSuchen;



   function HatTransporterLadung
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return Boolean
   is begin
      
      TransporterSchleife:
      for TransporterPlatzSchleifenwert in EinheitStadtRecords.TransporterArray'First .. LeseEinheitenDatenbank.Transportkapazität (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                                                                                     IDExtern    =>
                                                                                                                                       LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern)) loop
         
         if
           LeseEinheitenGebaut.Transportiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                              PlatzExtern              => TransporterPlatzSchleifenwert)
           /= EinheitenKonstanten.LeerTransportiert
         then
            return True;
            
         else
            null;
         end if;
         
      end loop TransporterSchleife;
      
      return False;
      
   end HatTransporterLadung;

end TransporterSuchen;
