package body SchleifenPruefungen is 

   function KartenUmgebung (YKoordinate, XKoordinate, YÄnderung, XÄnderung, ZusatzYAbstand : in GlobaleDatentypen.Kartenfeld) return GlobaleRecords.AchsenAusKartenfeld is
   begin
      -- Der ZusatzYAbstand ist für <=, also z. B. 1 für <= oder 4 für <= Karten.Karten'First (2) + 3
      
      if YKoordinate + YÄnderung < Karten.Karten'First (2) + ZusatzYAbstand or YKoordinate + YÄnderung > Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - ZusatzYAbstand then
         return (GlobaleDatentypen.Ebene'First, GlobaleDatentypen.Kartenfeld'First, GlobaleDatentypen.Kartenfeld'First);

      elsif XKoordinate + XÄnderung < Karten.Karten'First (3) then
         Überhang := Integer (XKoordinate + XÄnderung + Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
         SchleifeKleiner:
         while Überhang < Integer (Karten.Karten'First (3)) loop
            
            Überhang := Überhang + Integer (Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);

         end loop SchleifeKleiner;
         return (0, YKoordinate + YÄnderung, GlobaleDatentypen.Kartenfeld (Überhang));
               
      elsif XKoordinate + XÄnderung > Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße then
         Überhang := Integer (XKoordinate + XÄnderung - Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
         SchleifeGrößer:
         while Überhang > Integer (Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße) loop
            
            Überhang := Überhang - Integer (Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
            
         end loop SchleifeGrößer;
         return (0, YKoordinate + YÄnderung, GlobaleDatentypen.Kartenfeld (Überhang));
               
      else
         return (0, YKoordinate + YÄnderung, XKoordinate + XÄnderung);
      end if;
      
   end KartenUmgebung;

   

   function KoordinatenStadtMitRasseSuchen (RasseExtern : in GlobaleDatentypen.Rassen; YAchse, XAchse : in GlobaleDatentypen.KartenfeldPositiv) return Integer is
   begin
      
      StadtSchleife:
      for Stadtnummer in GlobaleVariablen.StadtGebaut'Range (2) loop
         
         if GlobaleVariablen.StadtGebaut (RasseExtern, Stadtnummer).ID = 0 then
            exit StadtSchleife;
            
         elsif GlobaleVariablen.StadtGebaut (RasseExtern, Stadtnummer).AchsenPosition.YAchse = YAchse and GlobaleVariablen.StadtGebaut (RasseExtern, Stadtnummer).AchsenPosition.XAchse = XAchse then
            return Stadtnummer;
            
         else
            null;
         end if;
         
      end loop StadtSchleife;
      
      return 0;
      
   end KoordinatenStadtMitRasseSuchen;



   function KoordinatenEinheitMitRasseSuchen (RasseExtern : in GlobaleDatentypen.Rassen; YAchse, XAchse : in GlobaleDatentypen.KartenfeldPositiv) return Integer is
   begin
      
      EinheitSchleife:
      for Einheitennummer in GlobaleVariablen.EinheitenGebaut'Range (2) loop
         
         if GlobaleVariablen.EinheitenGebaut (RasseExtern, Einheitennummer).ID = 0 then
            exit EinheitSchleife;
            
         elsif GlobaleVariablen.EinheitenGebaut (RasseExtern, Einheitennummer).AchsenPosition.YAchse = YAchse and GlobaleVariablen.EinheitenGebaut (RasseExtern, Einheitennummer).AchsenPosition.XAchse = XAchse then
            return Einheitennummer;
            
         else
            null;
         end if;
         
      end loop EinheitSchleife;
      
      return 0;
      
   end KoordinatenEinheitMitRasseSuchen;
   
   
   
   function KoordinatenStadtOhneRasseSuchen (YAchse, XAchse : in GlobaleDatentypen.KartenfeldPositiv) return GlobaleRecords.RasseUndPlatznummerRecord is
   begin

      RasseSchleife:
      for RasseIntern in GlobaleVariablen.StadtGebaut'Range (1) loop
         StadtSchleife:
         for Stadtnummer in GlobaleVariablen.StadtGebaut'Range (2) loop
            
            if GlobaleVariablen.StadtGebaut (RasseIntern, Stadtnummer).ID = 0 then
               exit StadtSchleife;
               
            elsif GlobaleVariablen.StadtGebaut (RasseIntern, Stadtnummer).AchsenPosition.YAchse = YAchse and GlobaleVariablen.StadtGebaut (RasseIntern, Stadtnummer).AchsenPosition.XAchse = XAchse then
               return (RasseIntern, Stadtnummer);
               
            else
               null;
            end if;
            
         end loop StadtSchleife;
      end loop RasseSchleife;
      
      return (GlobaleDatentypen.RassenMitNullwert'First, RückgabeWert);
      
   end KoordinatenStadtOhneRasseSuchen;
   
   
   
   function KoordinatenEinheitOhneRasseSuchen (YAchse, XAchse : in GlobaleDatentypen.KartenfeldPositiv) return GlobaleRecords.RasseUndPlatznummerRecord is
   begin

      RasseSchleife:
      for RasseIntern in GlobaleVariablen.StadtGebaut'Range (1) loop
         EinheitSchleife:
         for EinheitNummer in GlobaleVariablen.EinheitenGebaut'Range (2) loop
            
            if GlobaleVariablen.EinheitenGebaut (RasseIntern, EinheitNummer).ID = 0 then
               exit EinheitSchleife;
               
            elsif GlobaleVariablen.EinheitenGebaut (RasseIntern, EinheitNummer).AchsenPosition.YAchse = YAchse and GlobaleVariablen.EinheitenGebaut (RasseIntern, EinheitNummer).AchsenPosition.XAchse = XAchse then
               return (RasseIntern, EinheitNummer);
               
            else
               null;
            end if;
            
         end loop EinheitSchleife;
      end loop RasseSchleife;
      
      return (GlobaleDatentypen.RassenMitNullwert'First, RückgabeWert);
      
   end KoordinatenEinheitOhneRasseSuchen;
   
   
   
   function KartenGrund (Ebene : in GlobaleDatentypen.Ebene; YKoordinate, XKoordinate : in GlobaleDatentypen.KartenfeldPositiv) return Boolean is
   begin
      
      case Karten.Karten (Ebene, YKoordinate, XKoordinate).Grund is
         when 1 .. 2 | 29 .. 31 | 36 =>
            return False;
            
         when others =>
            return True;
      end case;
      
   end KartenGrund;

end SchleifenPruefungen;
