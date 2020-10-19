package body SchleifenPruefungen is

   function KartenUmgebung (YKoordinate, XKoordinate, YÄnderung, XÄnderung, ZusatzYAbstand : in Integer) return GlobaleDatentypen.RückgabewertFürSchleifenPrüfungRecord is
   begin
      -- Der ZusatzYAbstand ist für <=, also z. B. 1 für <= oder 4 für <= Karten.Karten'First (2) + 3
      
      if YKoordinate + YÄnderung < Karten.Karten'First (2) + ZusatzYAbstand or YKoordinate + YÄnderung > Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - ZusatzYAbstand then
         return (-1_000_000, -1_000_000);

      elsif XKoordinate + XÄnderung < Karten.Karten'First (3) then
         Überhang := XKoordinate + XÄnderung + Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße;
         SchleifeKleiner:
         while Überhang < Karten.Karten'First (3) loop
            
            Überhang := Überhang + Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße;

         end loop SchleifeKleiner;
         return (YKoordinate + YÄnderung, Überhang);
               
      elsif XKoordinate + XÄnderung > Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße then
         Überhang := XKoordinate + XÄnderung - Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße;
         SchleifeGrößer:
         while Überhang > Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
            
            Überhang := Überhang - Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße;
            
         end loop SchleifeGrößer;
         return (YKoordinate + YÄnderung, Überhang);
               
      else
         return (YKoordinate + YÄnderung, XKoordinate + XÄnderung);
      end if;
      
   end KartenUmgebung;

   

   function KoordinatenStadtMitRasseSuchen (Rasse, YAchse, XAchse : in Integer) return Integer is
   begin
      
      StadtSchleife:
      for Stadtnummer in GlobaleVariablen.StadtGebaut'Range (2) loop
         
         if GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).ID = 0 then
            exit StadtSchleife;
            
         elsif GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).YAchse = YAchse and GlobaleVariablen.StadtGebaut (Rasse, Stadtnummer).XAchse = XAchse then
            return Stadtnummer;
            
         else
            null;
         end if;
         
      end loop StadtSchleife;
      
      return 0;
      
   end KoordinatenStadtMitRasseSuchen;



   function KoordinatenEinheitMitRasseSuchen (Rasse, YAchse, XAchse : in Integer) return Integer is
   begin
      
      EinheitSchleife:
      for Einheitennummer in GlobaleVariablen.EinheitenGebaut'Range (2) loop
         
         if GlobaleVariablen.EinheitenGebaut (Rasse, Einheitennummer).ID = 0 then
            exit EinheitSchleife;
            
         elsif GlobaleVariablen.EinheitenGebaut (Rasse, Einheitennummer).YAchse = YAchse and GlobaleVariablen.EinheitenGebaut (Rasse, Einheitennummer).XAchse = XAchse then
            return Einheitennummer;
            
         else
            null;
         end if;
         
      end loop EinheitSchleife;
      
      return 0;
      
   end KoordinatenEinheitMitRasseSuchen;
   
   
   
   function KoordinatenStadtOhneRasseSuchen (YAchse, XAchse : in Integer) return GlobaleDatentypen.RasseUndPlatznummerRecord is
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
      
      return (-1_000_000, -1_000_000);
      
   end KoordinatenStadtOhneRasseSuchen;
   
   
   
   function KoordinatenEinheitOhneRasseSuchen (YAchse, XAchse : in Integer) return GlobaleDatentypen.RasseUndPlatznummerRecord is
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
      
      return (-1_000_000, -1_000_000);
      
   end KoordinatenEinheitOhneRasseSuchen;

end SchleifenPruefungen;
