with GlobaleVariablen;

package body SchleifenPruefungen is 

   function KartenUmgebung (Koordinaten : in GlobaleRecords.AchsenAusKartenfeldPositivRecord; Änderung : in GlobaleRecords.AchsenAusKartenfeldRecord;
                            ZusatzYAbstand : in GlobaleDatentypen.Kartenfeld) return GlobaleRecords.AchsenAusKartenfeldRecord is
   begin -- Der ZusatzYAbstand ist für <=, also z. B. 1 für <= Karten.Karten'First (2) oder 4 für <= Karten.Karten'First (2) + 3
      
      if Koordinaten.EAchse + Änderung.EAchse < Karten.Karten'First (1) or Koordinaten.EAchse + Änderung.EAchse > Karten.Karten'Last (1) then
         return (GlobaleDatentypen.Ebene'First, GlobaleDatentypen.Kartenfeld'First, GlobaleDatentypen.Kartenfeld'First);
      
      elsif Koordinaten.YAchse + Änderung.YAchse < Karten.Karten'First (2) + ZusatzYAbstand or Koordinaten.YAchse + Änderung.YAchse > Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - ZusatzYAbstand then
         return (GlobaleDatentypen.Ebene'First, GlobaleDatentypen.Kartenfeld'First, GlobaleDatentypen.Kartenfeld'First);

      elsif Koordinaten.XAchse + Änderung.XAchse < Karten.Karten'First (3) then
         Überhang := Integer (Koordinaten.XAchse + Änderung.XAchse + Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
         SchleifeKleiner:
         while Überhang < Integer (Karten.Karten'First (3)) loop
            
            Überhang := Überhang + Integer (Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);

         end loop SchleifeKleiner;
         return (Koordinaten.EAchse + Änderung.EAchse, Koordinaten.YAchse + Änderung.YAchse, GlobaleDatentypen.Kartenfeld (Überhang));
               
      elsif Koordinaten.XAchse + Änderung.XAchse > Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße then
         Überhang := Integer (Koordinaten.XAchse + Änderung.XAchse - Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
         SchleifeGrößer:
         while Überhang > Integer (Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße) loop
            
            Überhang := Überhang - Integer (Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
            
         end loop SchleifeGrößer;
         return (Koordinaten.EAchse + Änderung.EAchse, Koordinaten.YAchse + Änderung.YAchse, GlobaleDatentypen.Kartenfeld (Überhang));
               
      else
         return (Koordinaten.EAchse + Änderung.EAchse, Koordinaten.YAchse + Änderung.YAchse, Koordinaten.XAchse + Änderung.XAchse);
      end if;
      
   end KartenUmgebung;

   

   function KoordinatenStadtMitRasseSuchen (RasseExtern : in GlobaleDatentypen.Rassen; Koordinaten : in GlobaleRecords.AchsenAusKartenfeldPositivRecord) return Integer is
   begin
      
      StadtSchleife:
      for Stadtnummer in GlobaleVariablen.StadtGebaut'Range (2) loop
         
         if GlobaleVariablen.StadtGebaut (RasseExtern, Stadtnummer).ID = 0 then
            exit StadtSchleife;
            
         elsif GlobaleVariablen.StadtGebaut (RasseExtern, Stadtnummer).AchsenPosition = Koordinaten then
            return Stadtnummer;
            
         else
            null;
         end if;
         
      end loop StadtSchleife;
      
      return 0;
      
   end KoordinatenStadtMitRasseSuchen;



   function KoordinatenEinheitMitRasseSuchen (RasseExtern : in GlobaleDatentypen.Rassen; Koordinaten : in GlobaleRecords.AchsenAusKartenfeldPositivRecord) return Integer is
   begin
      
      EinheitSchleife:
      for Einheitennummer in GlobaleVariablen.EinheitenGebaut'Range (2) loop
         
         if GlobaleVariablen.EinheitenGebaut (RasseExtern, Einheitennummer).ID = 0 then
            exit EinheitSchleife;
            
         elsif GlobaleVariablen.EinheitenGebaut (RasseExtern, Einheitennummer).AchsenPosition = Koordinaten then
            return Einheitennummer;
            
         else
            null;
         end if;
         
      end loop EinheitSchleife;
      
      return 0;
      
   end KoordinatenEinheitMitRasseSuchen;
   
   
   
   function KoordinatenStadtOhneRasseSuchen (Koordinaten : in GlobaleRecords.AchsenAusKartenfeldPositivRecord) return GlobaleRecords.RasseUndPlatznummerRecord is
   begin

      RasseSchleife:
      for RasseIntern in GlobaleVariablen.StadtGebaut'Range (1) loop
         StadtSchleife:
         for Stadtnummer in GlobaleVariablen.StadtGebaut'Range (2) loop
            
            if GlobaleVariablen.StadtGebaut (RasseIntern, Stadtnummer).ID = 0 then
               exit StadtSchleife;
               
            elsif GlobaleVariablen.StadtGebaut (RasseIntern, Stadtnummer).AchsenPosition = Koordinaten then
               return (RasseIntern, Stadtnummer);
               
            else
               null;
            end if;
            
         end loop StadtSchleife;
      end loop RasseSchleife;
      
      return (GlobaleDatentypen.RassenMitNullwert'First, RückgabeWert);
      
   end KoordinatenStadtOhneRasseSuchen;
   
   
   
   function KoordinatenEinheitOhneRasseSuchen (Koordinaten : in GlobaleRecords.AchsenAusKartenfeldPositivRecord) return GlobaleRecords.RasseUndPlatznummerRecord is
   begin

      RasseSchleife:
      for RasseIntern in GlobaleVariablen.StadtGebaut'Range (1) loop
         EinheitSchleife:
         for EinheitNummer in GlobaleVariablen.EinheitenGebaut'Range (2) loop
            
            if GlobaleVariablen.EinheitenGebaut (RasseIntern, EinheitNummer).ID = 0 then
               exit EinheitSchleife;
               
            elsif GlobaleVariablen.EinheitenGebaut (RasseIntern, EinheitNummer).AchsenPosition = Koordinaten then
               return (RasseIntern, EinheitNummer);
               
            else
               null;
            end if;
            
         end loop EinheitSchleife;
      end loop RasseSchleife;
      
      return (GlobaleDatentypen.RassenMitNullwert'First, RückgabeWert);
      
   end KoordinatenEinheitOhneRasseSuchen;
   
   
   
   -- Sinnvoller benennen und weitere Prüfung für nur Wasser und so weiter einbauen
   function KartenGrund (Koordinaten : in GlobaleRecords.AchsenAusKartenfeldPositivRecord) return Boolean is
   begin
      
      case Karten.Karten (Koordinaten.EAchse, Koordinaten.YAchse, Koordinaten.XAchse).Grund is
         when 1 .. 2 | 29 .. 31 | 36 =>
            return False;
            
         when others =>
            return True;
      end case;
      
   end KartenGrund;

end SchleifenPruefungen;
