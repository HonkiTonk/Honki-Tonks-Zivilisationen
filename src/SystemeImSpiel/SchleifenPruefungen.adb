package body SchleifenPruefungen is

   function KoordinatenStadtMitRasseSuchen (Rasse, YAchse, XAchse : in Integer) return Integer is
   begin

      for Stadtnummer in GlobaleVariablen.StadtGebaut'Range (2) loop
         
         if GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).ID = 0 then
            exit;
            
         elsif GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).YAchse = YAchse and GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).XAchse = XAchse then
            return Stadtnummer;
            
         else
            null;
         end if;
         
      end loop;
      
      return 0;
      
   end KoordinatenStadtMitRasseSuchen;



   function KoordinatenEinheitMitRasseSuchen (Rasse, YAchse, XAchse : in Integer) return Integer is
   begin
      
      for Einheitennummer in GlobaleVariablen.EinheitenGebaut'Range (2) loop
         
         if GlobaleVariablen.EinheitenGebaut (Rasse, Einheitennummer).ID = 0 then
            exit;
            
         elsif GlobaleVariablen.EinheitenGebaut (Rasse, Einheitennummer).YAchse = YAchse and GlobaleVariablen.EinheitenGebaut (Rasse, Einheitennummer).XAchse = XAchse then
            return Einheitennummer;
            
         else
            null;
         end if;
         
      end loop;
      
      return 0;
      
   end KoordinatenEinheitMitRasseSuchen;
   
   
   
   function KoordinatenStadtOhneRasseSuchen (YAchse, XAchse : in Integer) return RasseUndPlatznummerRecord is
   begin

      RasseSchleife:
      for Rasse in GlobaleVariablen.StadtGebaut'Range (1) loop
         StadtSchleife:
         for Stadtnummer in GlobaleVariablen.StadtGebaut'Range (2) loop
            
            if GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).ID = 0 then
               exit StadtSchleife;
               
            elsif GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).YAchse = YAchse and GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).XAchse = XAchse then
               return (Rasse, Stadtnummer);
               
            else
               null;
            end if;
            
         end loop StadtSchleife;
      end loop RasseSchleife;
      
      return (0, 0);
      
   end KoordinatenStadtOhneRasseSuchen;
   
   
   
   function KoordinatenEinheitOhneRasseSuchen (YAchse, XAchse : in Integer) return RasseUndPlatznummerRecord is
   begin

      RasseSchleife:
      for Rasse in GlobaleVariablen.StadtGebaut'Range (1) loop
         EinheitSchleife:
         for EinheitNummer in GlobaleVariablen.EinheitenGebaut'Range (2) loop
            
            if GlobaleVariablen.EinheitenGebaut (Rasse, EinheitNummer).ID = 0 then
               exit EinheitSchleife;
               
            elsif GlobaleVariablen.EinheitenGebaut (Rasse, EinheitNummer).YAchse = YAchse and GlobaleVariablen.EinheitenGebaut (Rasse, EinheitNummer).XAchse = XAchse then
               return (Rasse, EinheitNummer);
               
            else
               null;
            end if;
            
         end loop EinheitSchleife;
      end loop RasseSchleife;
      
      return (0, 0);
      
   end KoordinatenEinheitOhneRasseSuchen;

end SchleifenPruefungen;
