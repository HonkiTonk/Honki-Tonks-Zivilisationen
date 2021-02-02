with GlobaleVariablen;

package body NaechstesObjekt is

   procedure NächsteEinheitMitBewegungspunkten (RasseExtern : in GlobaleDatentypen.Rassen) is -- Nochmal über die loops schauen, möglicherweise wird eine Einheit ausgelassen
   begin

      case GlobaleVariablen.EinheitenGebaut (RasseExtern, 1).ID is
         when 0 =>
            return;
         
         when others  =>
            Endwert := GlobaleVariablen.EinheitenGebaut'Last (2);
            Startwert := 1;
      end case;
      
      EinheitSuchenSchleife:
      loop
               
         if AktuelleEinheit + 1 > GlobaleVariablen.EinheitenGebaut'Last (2) then
            Endwert := AktuelleEinheit;
            Startwert := Startwert + 1;
            AktuelleEinheit := 1;

         elsif GlobaleVariablen.EinheitenGebaut (RasseExtern, AktuelleEinheit + 1).ID = 0 then
            Endwert := AktuelleEinheit;
            Startwert := Startwert + 1;
            AktuelleEinheit := 1;
         
         else
            AktuelleEinheit := AktuelleEinheit + 1;
            Startwert := Startwert + 1;
         end if;

         if GlobaleVariablen.EinheitenGebaut (RasseExtern, AktuelleEinheit).AktuelleBewegungspunkte > 0.0 then
            exit EinheitSuchenSchleife;
            
         else
            null;
         end if;

         if Startwert >= Endwert then
            return;
            
         else
            null;
         end if;

      end loop EinheitSuchenSchleife;
         
      GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition := GlobaleVariablen.EinheitenGebaut (RasseExtern, AktuelleEinheit).AchsenPosition;
      
   end NächsteEinheitMitBewegungspunkten;
   
   

   procedure NächsteEinheit (RasseExtern : in GlobaleDatentypen.Rassen) is
   begin
      
      if GlobaleVariablen.EinheitenGebaut (RasseExtern, 1).ID = 0 then
         return;
      
      elsif AktuelleEinheit + 1 > GlobaleVariablen.EinheitenGebaut'Last (2) then
         AktuelleEinheit := 1;

      elsif GlobaleVariablen.EinheitenGebaut (RasseExtern, AktuelleEinheit + 1).ID = 0 then
         AktuelleEinheit := 1;
         
      else
         AktuelleEinheit := AktuelleEinheit + 1;
      end if;
      
      GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition := GlobaleVariablen.EinheitenGebaut (RasseExtern, AktuelleEinheit).AchsenPosition;
      
   end NächsteEinheit;



   procedure NächsteEinheitOhneBewegungspunkte (RasseExtern : in GlobaleDatentypen.Rassen) is
   begin
      
      case GlobaleVariablen.EinheitenGebaut (RasseExtern, 1).ID is
         when 0 =>
            return;
         
         when others  =>
            Endwert := GlobaleVariablen.EinheitenGebaut'Last (2);
            Startwert := 1;
      end case;
      
      loop
               
         if AktuelleEinheit + 1 > GlobaleVariablen.EinheitenGebaut'Last (2) then
            Endwert := AktuelleEinheit;
            Startwert := Startwert + 1;
            AktuelleEinheit := 1;

         elsif GlobaleVariablen.EinheitenGebaut (RasseExtern, AktuelleEinheit + 1).ID = 0 then
            Endwert := AktuelleEinheit;
            Startwert := Startwert + 1;
            AktuelleEinheit := 1;
         
         else
            AktuelleEinheit := AktuelleEinheit + 1;
            Startwert := Startwert + 1;
         end if;

         if GlobaleVariablen.EinheitenGebaut (RasseExtern, AktuelleEinheit).AktuelleBewegungspunkte <= 0.0 then
            exit;
            
         else
            null;
         end if;

         if Startwert >= Endwert then
            return;
            
         else
            null;
         end if;

      end loop;
         
      GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition := GlobaleVariablen.EinheitenGebaut (RasseExtern, AktuelleEinheit).AchsenPosition;
      
   end NächsteEinheitOhneBewegungspunkte;
   
   
   
   procedure NächsteStadt (RasseExtern : in GlobaleDatentypen.Rassen) is
   begin
      
      if GlobaleVariablen.StadtGebaut (RasseExtern, 1).ID = 0 then
         return;
      
      elsif AktuelleStadt + 1 > GlobaleVariablen.StadtGebaut'Last (2) then
         AktuelleStadt := 1;

      elsif GlobaleVariablen.StadtGebaut (RasseExtern, AktuelleStadt + 1).ID = 0 then
         AktuelleStadt := 1;
         
      else
         AktuelleStadt := AktuelleStadt + 1;
      end if;
      
      GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition := GlobaleVariablen.StadtGebaut (RasseExtern, AktuelleStadt).AchsenPosition;
      
   end NächsteStadt;

end NaechstesObjekt;
