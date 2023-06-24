with KIStaedteverbindungssystemLogik;

package body KIRundenende is

   procedure Rundenende
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
   is begin
      
      KIStaedteverbindungssystemLogik.Stadtverbindung (SpeziesExtern => SpeziesExtern);
      
   end Rundenende;

end KIRundenende;
