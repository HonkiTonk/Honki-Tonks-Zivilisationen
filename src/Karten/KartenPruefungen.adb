pragma SPARK_Mode (On);

package body KartenPruefungen is

   function KartenPositionBestimmen (Koordinaten : in GlobaleRecords.AchsenKartenfeldPositivRecord; Änderung : in GlobaleRecords.AchsenKartenfeldRecord;
                                     ZusatzYAbstand : in GlobaleDatentypen.Kartenfeld) return GlobaleRecords.AchsenKartenfeldPositivErfolgreichRecord is
   begin -- Der ZusatzYAbstand ist für <=, also z. B. 1 für <= Karten.KartenArray'First (2) oder 4 für <= Karten.KartenArray'First (2) + 3
      
      if Koordinaten.EAchse + Änderung.EAchse < Karten.KartenArray'First (1) or Koordinaten.EAchse + Änderung.EAchse > Karten.KartenArray'Last (1) then
         return (GlobaleDatentypen.EbeneVorhanden'First, GlobaleDatentypen.KartenfeldPositiv'First, GlobaleDatentypen.KartenfeldPositiv'First, False);

      elsif Koordinaten.YAchse + Änderung.YAchse < Karten.KartenArray'First (2) + ZusatzYAbstand or Koordinaten.YAchse + Änderung.YAchse > Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße - ZusatzYAbstand then
         return (GlobaleDatentypen.EbeneVorhanden'First, GlobaleDatentypen.KartenfeldPositiv'First, GlobaleDatentypen.KartenfeldPositiv'First, False);

      elsif Koordinaten.XAchse + Änderung.XAchse < Karten.KartenArray'First (3) then
         Überhang := Integer (Koordinaten.XAchse + Änderung.XAchse + Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
         SchleifeKleiner:
         while Überhang < Integer (Karten.KartenArray'First (3)) loop
            
            Überhang := Überhang + Integer (Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);

         end loop SchleifeKleiner;
         return (Koordinaten.EAchse + Änderung.EAchse, Koordinaten.YAchse + Änderung.YAchse, GlobaleDatentypen.Kartenfeld (Überhang), True);
               
      elsif Koordinaten.XAchse + Änderung.XAchse > Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße then
         Überhang := Integer (Koordinaten.XAchse + Änderung.XAchse - Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
         SchleifeGrößer:
         while Überhang > Integer (Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße) loop
            
            Überhang := Überhang - Integer (Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße);
            
         end loop SchleifeGrößer;
         return (Koordinaten.EAchse + Änderung.EAchse, Koordinaten.YAchse + Änderung.YAchse, GlobaleDatentypen.Kartenfeld (Überhang), True);
               
      else
         return (Koordinaten.EAchse + Änderung.EAchse, Koordinaten.YAchse + Änderung.YAchse, Koordinaten.XAchse + Änderung.XAchse, True);
      end if;
      
   end KartenPositionBestimmen;
   
   
   
   -- Sinnvoller benennen und weitere Prüfung für nur Wasser und so weiter einbauen
   function KartenGrund (Koordinaten : in GlobaleRecords.AchsenKartenfeldPositivRecord) return Boolean is
   begin
      
      case Karten.Karten (Koordinaten.EAchse, Koordinaten.YAchse, Koordinaten.XAchse).Grund is
         when 1 .. 2 | 29 .. 31 | 36 =>
            return False;
            
         when others =>
            return True;
      end case;
      
   end KartenGrund;

end KartenPruefungen;
