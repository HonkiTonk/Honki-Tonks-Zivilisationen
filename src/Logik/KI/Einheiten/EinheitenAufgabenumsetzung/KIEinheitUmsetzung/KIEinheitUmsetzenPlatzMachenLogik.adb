package body KIEinheitUmsetzenPlatzMachenLogik is

   function PlatzMachen
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
   is begin
      
      -- Platzhalter
      case
        EinheitSpeziesNummerExtern.Spezies
      is
         when SpeziesDatentypen.Ekropa_Enum =>
            null;
            
         when others =>
            null;
      end case;
      
      return False;
      
   end PlatzMachen;

end KIEinheitUmsetzenPlatzMachenLogik;
