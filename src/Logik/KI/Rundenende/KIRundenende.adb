with SpeziesDatentypen;

with LeseSpeziesbelegung;

with KIStaedteverbindungssystemLogik;

-- Kann nach der Überarbeitung der Rundenendesystems entfernt werden. äöü
package body KIRundenende is

   procedure Rundenende
   is begin
      
      SpeziesSchleife:
      for SpeziesSchleifenwert in SpeziesDatentypen.Spezies_Verwendet_Enum'Range loop
         
         case
           LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesSchleifenwert)
         is
            when SpeziesDatentypen.KI_Spieler_Enum =>
               KIStaedteverbindungssystemLogik.Stadtverbindung (SpeziesExtern => SpeziesSchleifenwert);
               
            when others =>
               null;
         end case;
         
      end loop SpeziesSchleife;
      
   end Rundenende;

end KIRundenende;
