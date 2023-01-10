package body KIEinheitUmsetzenNichtsLogik is

   function NichtsTun
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
      
      return True;
      
   end NichtsTun;

end KIEinheitUmsetzenNichtsLogik;
