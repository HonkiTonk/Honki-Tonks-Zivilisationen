pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitenDatentypen; use EinheitenDatentypen;
with EinheitenKonstanten;

with LeseEinheitenDatenbank;
with LeseEinheitenGebaut;

package body EinheitenTransporter is   
   
   function KannTransportiertWerden
     (LadungExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      TransporterExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      case
        LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (TransporterExtern.Rasse, TransporterExtern.Nummer))
      is
         when EinheitenKonstanten.LeerID =>
            return False;
            
         when others =>
            null;
      end case;
            
      if
        LeseEinheitenDatenbank.KannTransportiertWerden (RasseExtern => LadungExtern.Rasse,
                                                        IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => LadungExtern))
          = EinheitenKonstanten.LeerKannTransportiertWerden
        or
          LeseEinheitenDatenbank.KannTransportieren (RasseExtern => TransporterExtern.Rasse,
                                                     IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => TransporterExtern))
            <
        LeseEinheitenDatenbank.KannTransportiertWerden (RasseExtern => LadungExtern.Rasse,
                                                        IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => LadungExtern))
      then
         return False;
         
      else
         return PlatzFrei (TransporterExtern => TransporterExtern);
      end if;
      
   end KannTransportiertWerden;
   
   
   
   function PlatzFrei
     (TransporterExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      PlatzFreiSchleife:
      for PlatzSchleifenwert in EinheitenRecords.TransporterArray'First .. LeseEinheitenDatenbank.Transportkapazität (RasseExtern => TransporterExtern.Rasse,
                                                                                                                       IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => TransporterExtern)) loop
         
         if
           LeseEinheitenGebaut.Transportiert (EinheitRasseNummerExtern => (TransporterExtern.Rasse, TransporterExtern.Nummer),
                                              PlatzExtern              => PlatzSchleifenwert)
           = EinheitenKonstanten.LeerTransportiert
         then
            return True;
            
         else
            null;
         end if;
         
      end loop PlatzFreiSchleife;
      
      return False;
      
   end PlatzFrei;

end EinheitenTransporter;
