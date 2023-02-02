with LeseEinheitenDatenbank;
with LeseEinheitenGebaut;

-- Umbenennen nach TransporterDurchsuchen?
package body TransporterSuchenLogik is

   function KoordinatenTransporterMitSpeziesSuchen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return EinheitenDatentypen.MaximaleEinheitenMitNullWert
   is
      use type EinheitenDatentypen.Transport_Enum;
      use type KartenRecords.AchsenKartenfeldNaturalRecord;
   begin
      
      EinheitSchleife:
      for EinheitNummerSchleifenwert in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => SpeziesExtern) loop
         
         if
           LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => (SpeziesExtern, EinheitNummerSchleifenwert)) /= KoordinatenExtern
         then
            null;
            
         elsif
           EinheitenKonstanten.LeerKannTransportieren = LeseEinheitenDatenbank.KannTransportieren (SpeziesExtern => SpeziesExtern,
                                                                                                   IDExtern      => LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => (SpeziesExtern, EinheitNummerSchleifenwert)))
         then
            null;
            
         else
            return EinheitNummerSchleifenwert;
         end if;
         
      end loop EinheitSchleife;
      
      return EinheitenKonstanten.LeerNummer;
      
   end KoordinatenTransporterMitSpeziesSuchen;
   
   
   
   function EinheitAufTransporterSuchen
     (TransporterExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      LadungExtern : in EinheitenDatentypen.MaximaleEinheiten)
      return EinheitenDatentypen.Transportplätze
   is begin
      
      Transporterkapazität := LeseEinheitenDatenbank.Transportkapazität (SpeziesExtern => TransporterExtern.Spezies,
                                                                           IDExtern      => LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => TransporterExtern));

      TransporterSchleife:
      for TransporterPlatzSchleifenwert in EinheitenRecords.TransporterArray'First .. Transporterkapazität loop
         
         if
           LadungExtern = LeseEinheitenGebaut.Transportiert (EinheitSpeziesNummerExtern => TransporterExtern,
                                                             PlatzExtern                => TransporterPlatzSchleifenwert)
         then
            return TransporterPlatzSchleifenwert;
            
         else
            null;
         end if;
         
      end loop TransporterSchleife;
      
      return EinheitenKonstanten.LeerTransportkapazität;
      
   end EinheitAufTransporterSuchen;



   function HatTransporterLadung
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
   is begin
      
      Transporterkapazität := LeseEinheitenDatenbank.Transportkapazität (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies,
                                                                           IDExtern    => LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern));
      
      TransporterSchleife:
      for TransporterPlatzSchleifenwert in EinheitenRecords.TransporterArray'First .. Transporterkapazität loop
         
         if
           EinheitenKonstanten.LeerTransportiert /= LeseEinheitenGebaut.Transportiert (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                                                       PlatzExtern                => TransporterPlatzSchleifenwert)
         then
            return True;
            
         else
            null;
         end if;
         
      end loop TransporterSchleife;
      
      return False;
      
   end HatTransporterLadung;
   
   
   
   function FreierPlatz
     (TransporterExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return EinheitenDatentypen.Transportplätze
   is begin
      
      Transporterkapazität := LeseEinheitenDatenbank.Transportkapazität (SpeziesExtern => TransporterExtern.Spezies,
                                                                           IDExtern      => LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => TransporterExtern));
      
      TransporterSchleife:
      for FreierPlatzSchleifenwert in EinheitenRecords.TransporterArray'First .. Transporterkapazität loop
        
         case
           LeseEinheitenGebaut.Transportiert (EinheitSpeziesNummerExtern => TransporterExtern,
                                              PlatzExtern                => FreierPlatzSchleifenwert)
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
