package body KIEinheitUmsetzenVerteidigungskriegLogik is

   function VerteidigungskriegVorbereiten
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
      
   end VerteidigungskriegVorbereiten;

end KIEinheitUmsetzenVerteidigungskriegLogik;
