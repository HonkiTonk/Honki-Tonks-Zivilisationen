package body Kampfsystem is

   function KampfsystemNahkampf (GegnerischeEinheitOderStadt, RasseAngriff, EinheitenPositionAngriff, RasseVerteidigung, EinheitenPositionVerteidigung : in Integer) return Boolean is
   begin

      case GegnerischeEinheitOderStadt is
         when 0 =>
            return True;
            
         when others =>
            null;
      end case;

      KampfSchleife:
      loop
         
         if GlobaleVariablen.EinheitenGebaut (RasseAngriff, EinheitenPositionAngriff).AktuelleLebenspunkte <= 0 then
            EinheitenDatenbank.EinheitEntfernen (Rasse => RasseAngriff, EinheitNummer => EinheitenPositionAngriff);
            return False;
            
         elsif GlobaleVariablen.EinheitenGebaut (RasseVerteidigung, EinheitenPositionVerteidigung).AktuelleLebenspunkte <= 0 then
            EinheitenDatenbank.EinheitEntfernen (Rasse => RasseVerteidigung, EinheitNummer => EinheitenPositionVerteidigung);
            return True;
            
         else
            null;
         end if;
         
      end loop KampfSchleife;
      
   end KampfsystemNahkampf;

end Kampfsystem;
