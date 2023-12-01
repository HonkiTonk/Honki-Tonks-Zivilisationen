package body KIKriegBeendenLogik is
   
   function KriegBeenden
     (EigeneSpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      FeindlicheSpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return Boolean
   is begin
      
      if
        EigeneSpeziesExtern = FeindlicheSpeziesExtern
      then
         null;
         
      else
         null;
      end if;
      
      return True;
      
   end KriegBeenden;

end KIKriegBeendenLogik;
