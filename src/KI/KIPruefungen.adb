pragma SPARK_Mode (On);

with KIVariablen;

with KIBewegungBerechnen, KartenPruefungen, StadtWerteFestlegen;

package body KIPruefungen is
   
   function StadtUmgebungPrüfen
     (RasseExtern : in GlobaleDatentypen.Rassen)
      return GlobaleRecords.AchsenKartenfeldPositivRecord
   is begin
      
      VerbesserungAnlegen := (0, 0, 0);      
      
      StadtSchleife:
      for StadtNummerSchleifenwert in GlobaleVariablen.StadtGebautArray'Range (2) loop
         
         if
           GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummerSchleifenwert).ID > 0
         then
            VerbesserungAnlegen := StadtUmgebungUnverbessert (StadtRasseNummerExtern => (RasseExtern, StadtNummerSchleifenwert));
            
         else
            null;
         end if;
         
         case
           VerbesserungAnlegen.YAchse
         is
            when 0 =>
               null;
               
            when others =>
               return VerbesserungAnlegen;
         end case;
         
      end loop StadtSchleife;
      
      return (0, 0, 0);
      
   end StadtUmgebungPrüfen;
   
   
   
   function StadtUmgebungUnverbessert
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return GlobaleRecords.AchsenKartenfeldPositivRecord
   is begin
      
      YAchseSchleife:
      for YÄnderungSchleifenwert in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
         XAchseSchleife:
         for XÄnderungSchleifenwert in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
            
            KartenWert := KartenPruefungen.KartenPositionBestimmen (KoordinatenExtern    => GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).AchsenPosition,
                                                                    ÄnderungExtern       => (0, YÄnderungSchleifenwert, XÄnderungSchleifenwert),
                                                                    ZusatzYAbstandExtern => 0);
            
            case
              KartenWert.YAchse
            is
               when 0 =>
                  exit XAchseSchleife;
                  
               when others =>
                  null;
            end case;
            
            if
              Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Grund /= 2
              and
                Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Grund /= 31
              and
                Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).DurchStadtBelegterGrund
            in
              GlobaleDatentypen.BelegterGrund (StadtRasseNummerExtern.Rasse) * StadtWerteFestlegen.RassenMulitplikationWert .. GlobaleDatentypen.BelegterGrund (StadtRasseNummerExtern.Rasse)
              * StadtWerteFestlegen.RassenMulitplikationWert + GlobaleDatentypen.BelegterGrund (GlobaleVariablen.StadtGebaut'Last (2))
              and
                (Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungGebiet = 0
                 or
                   Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße = 0)
            then
               return KartenWert;
               
            else
               null;
            end if;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
      return (0, 0, 0);
      
   end StadtUmgebungUnverbessert;
   
   
   
   function EinheitenAbstandBerechnen
     (EinheitEinsRasseNummerExtern, EinheitZweiRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Natural
   is begin

      if
        GlobaleVariablen.EinheitenGebaut (EinheitEinsRasseNummerExtern.Rasse, EinheitEinsRasseNummerExtern.Platznummer).AchsenPosition.EAchse
        = GlobaleVariablen.EinheitenGebaut (EinheitZweiRasseNummerExtern.Rasse, EinheitZweiRasseNummerExtern.Platznummer).AchsenPosition.EAchse
      then
         KartenfeldAbstand := abs (GlobaleVariablen.EinheitenGebaut (EinheitEinsRasseNummerExtern.Rasse, EinheitEinsRasseNummerExtern.Platznummer).AchsenPosition.YAchse
                                   - GlobaleVariablen.EinheitenGebaut (EinheitZweiRasseNummerExtern.Rasse, EinheitZweiRasseNummerExtern.Platznummer).AchsenPosition.YAchse);
         case
           KartenfeldAbstand
         is
            when 1 =>
               return 1;

            when others =>
               null;
         end case;

         KartenfeldAbstand := abs (GlobaleVariablen.EinheitenGebaut (EinheitEinsRasseNummerExtern.Rasse, EinheitEinsRasseNummerExtern.Platznummer).AchsenPosition.XAchse
                                   - GlobaleVariablen.EinheitenGebaut (EinheitZweiRasseNummerExtern.Rasse, EinheitZweiRasseNummerExtern.Platznummer).AchsenPosition.XAchse);
         case
           KartenfeldAbstand
         is
            when 1 =>
               return 1;

            when others =>
               null;
         end case;

      elsif
      abs (GlobaleVariablen.EinheitenGebaut (EinheitEinsRasseNummerExtern.Rasse, EinheitEinsRasseNummerExtern.Platznummer).AchsenPosition.EAchse
           - GlobaleVariablen.EinheitenGebaut (EinheitZweiRasseNummerExtern.Rasse, EinheitZweiRasseNummerExtern.Platznummer).AchsenPosition.EAchse) = 1
      then
         KartenfeldAbstand := abs (GlobaleVariablen.EinheitenGebaut (EinheitEinsRasseNummerExtern.Rasse, EinheitEinsRasseNummerExtern.Platznummer).AchsenPosition.YAchse
                                   - GlobaleVariablen.EinheitenGebaut (EinheitZweiRasseNummerExtern.Rasse, EinheitZweiRasseNummerExtern.Platznummer).AchsenPosition.YAchse);
         case
           KartenfeldAbstand
         is
            when 0 .. 1 =>
               return 1;

            when others =>
               null;
         end case;

         KartenfeldAbstand := abs (GlobaleVariablen.EinheitenGebaut (EinheitEinsRasseNummerExtern.Rasse, EinheitEinsRasseNummerExtern.Platznummer).AchsenPosition.XAchse
                                   - GlobaleVariablen.EinheitenGebaut (EinheitZweiRasseNummerExtern.Rasse, EinheitZweiRasseNummerExtern.Platznummer).AchsenPosition.XAchse);
         case
           KartenfeldAbstand
         is
            when 0 .. 1 =>
               return 1;

            when others =>
               null;
         end case;

      else
         null;
      end if;
           
      return 10;
      
   end EinheitenAbstandBerechnen;



   procedure ZielBerechnenGefahr
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin

      RichtungenFeinde := (others => 0);
      Richtung := 0;
      
      YAchseSchleife:
      for YAchseSchleifenwert in GlobaleDatentypen.LoopRangeMinusDreiZuDrei loop
         XAchseSchleife:
         for XAchseSchleifenwert in GlobaleDatentypen.LoopRangeMinusDreiZuDrei loop

            -- 1 = Norden (-), 2 = Westen (-), 3 = Süden (+), 4 = Osten (+)
            if
              YAchseSchleifenwert < 0
              and
                KIVariablen.FeindlicheEinheiten (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer, YAchseSchleifenwert, XAchseSchleifenwert) /= 0
            then
               RichtungenFeinde (1) := RichtungenFeinde (1) + 1;

            elsif
              YAchseSchleifenwert = 0
              and
                KIVariablen.FeindlicheEinheiten (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer, YAchseSchleifenwert, XAchseSchleifenwert) /= 0
            then  
               RichtungenFeinde (1) := RichtungenFeinde (1) + 1;
               RichtungenFeinde (3) := RichtungenFeinde (3) + 1;
               
            elsif
              YAchseSchleifenwert > 0
              and
                KIVariablen.FeindlicheEinheiten (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer, YAchseSchleifenwert, XAchseSchleifenwert) /= 0
            then 
               RichtungenFeinde (3) := RichtungenFeinde (3) + 1;
            else
               null;
            end if;

            if
              XAchseSchleifenwert < 0
              and
                KIVariablen.FeindlicheEinheiten (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer, YAchseSchleifenwert, XAchseSchleifenwert) /= 0
            then
               RichtungenFeinde (2) := RichtungenFeinde (2) + 1;

            elsif
              XAchseSchleifenwert = 0
              and
                KIVariablen.FeindlicheEinheiten (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer, YAchseSchleifenwert, XAchseSchleifenwert) /= 0
            then  
               RichtungenFeinde (2) := RichtungenFeinde (2) + 1;
               RichtungenFeinde (4) := RichtungenFeinde (4) + 1;
               
            elsif
              XAchseSchleifenwert > 0
              and
                KIVariablen.FeindlicheEinheiten (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer, YAchseSchleifenwert, XAchseSchleifenwert) /= 0
            then 
               RichtungenFeinde (4) := RichtungenFeinde (4) + 1;
            else
               null;
            end if;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;      
      
      -- 1 = Norden (-), 2 = Westen (-), 3 = Süden (+), 4 = Osten (+)
      if
        RichtungenFeinde (1) /= 0
        or
          RichtungenFeinde (3) /= 0
      then
         if
           RichtungenFeinde (1) > RichtungenFeinde (3)
         then
            Richtung := 5;

         elsif
           RichtungenFeinde (1) = RichtungenFeinde (3)
         then
            null;
         
         else
            Richtung := 1;
         end if;

      else
         null;
      end if;
      
      if
        RichtungenFeinde (2) /= 0
        or
          RichtungenFeinde (4) /= 0
      then
         if
           RichtungenFeinde (2) > RichtungenFeinde (4)
         then
            case
              Richtung
            is
               when 5 =>
                  Richtung := 4;

               when 1 =>
                  Richtung := 2;
                  
               when others =>
                  Richtung := 3;
            end case;

         elsif
           RichtungenFeinde (2) = RichtungenFeinde (4)
         then
            null;
            
         else            
            case
              Richtung
            is
               when 5 =>
                  Richtung := 6;

               when 1 =>
                  Richtung := 8;
                  
               when others =>
                  Richtung := 7;
            end case;
         end if;

      else
         null;
      end if;

      -- 1 = Norden = (-1, 0), 2 = Nord_Ost = (-1, 1), 3 = Osten = (0, 1), 4 = Süd_Osten = (1, 1), 5 = Süden = (1, 0), 6 = Süd_West = (1, -1), 7 = Westen = (0, -1), 8 = Nord_West = (-1, -1)      
      KIBewegungBerechnen.NeuesZielErmittelnGefahr (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    RichtungExtern           => KIDatentypen.Richtung_Enum'Val (Richtung));

   end ZielBerechnenGefahr;



   -- 1 = Norden = (-1, 0), 2 = Nord_Ost = (-1, 1), 3 = Osten = (0, 1), 4 = Süd_Osten = (1, 1), 5 = Süden = (1, 0), 6 = Süd_West = (1, -1), 7 = Westen = (0, -1), 8 = Nord_West = (-1, -1)
   function NähesteEigeneStadtSuchen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      RichtungExtern : in KIDatentypen.Richtung_Enum)
      return GlobaleRecords.AchsenKartenfeldPositivRecord
   is begin

      -- Kandidaten (1) ist die jetzt näheste gefundene Stadt, Kandidaten (2) ist Norden oder Süden und Kandidaten (3) ist Westen oder Osten.
      Kandidaten := (others => (0, 0, 0));

      StadtSchleife:
      for StadtNummerSchleifenwert in GlobaleVariablen.StadtGebautArray'Range (2) loop

         if
           GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummerSchleifenwert).ID = 0
         then
            null;
            
         else
            case
              RichtungExtern
            is
               when KIDatentypen.Norden | KIDatentypen.Nord_Ost | KIDatentypen.Nord_West =>
                  
                  StadtImNorden (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                 StadtNummerExtern        => StadtNummerSchleifenwert);

                  if
                    RichtungExtern = KIDatentypen.Nord_Ost
                  then
                     StadtImOsten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                   StadtNummerExtern        => StadtNummerSchleifenwert);
                        
                  elsif
                    RichtungExtern = KIDatentypen.Nord_West
                  then
                     StadtImWesten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                    StadtNummerExtern        => StadtNummerSchleifenwert);
                           
                  else
                     Kandidaten (3) := Kandidaten (2);
                  end if;

                  if
                    Kandidaten (2) = Kandidaten (3)
                  then
                     Kandidaten (1) := Kandidaten (2);
                     Kandidaten (2) := (0, 0, 0);
                     Kandidaten (3) := (0, 0, 0);
                     
                  else
                     Kandidaten (2) := (0, 0, 0);
                     Kandidaten (3) := (0, 0, 0);
                  end if;
               
               when KIDatentypen.Osten =>
                  StadtImOsten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                StadtNummerExtern        => StadtNummerSchleifenwert);
                  Kandidaten (2) := Kandidaten (3);

                  if
                    Kandidaten (2) = Kandidaten (3)
                  then
                     Kandidaten (1) := Kandidaten (2);
                     Kandidaten (2) := (0, 0, 0);
                     Kandidaten (3) := (0, 0, 0);
                     
                  else
                     Kandidaten (2) := (0, 0, 0);
                     Kandidaten (3) := (0, 0, 0);
                  end if;
               
               when KIDatentypen.Süden | KIDatentypen.Süd_Ost | KIDatentypen.Süd_West =>
                  StadtImSüden (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                 StadtNummerExtern        => StadtNummerSchleifenwert);

                  if
                    RichtungExtern = KIDatentypen.Süd_Ost
                  then
                     StadtImOsten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                   StadtNummerExtern        => StadtNummerSchleifenwert);
                           
                  elsif
                    RichtungExtern = KIDatentypen.Süd_West
                  then
                     StadtImWesten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                    StadtNummerExtern        => StadtNummerSchleifenwert);
                           
                  else
                     Kandidaten (3) := Kandidaten (2);
                  end if;

                  if
                    Kandidaten (2) = Kandidaten (3)
                  then
                     Kandidaten (1) := Kandidaten (2);
                     Kandidaten (2) := (0, 0, 0);
                     Kandidaten (3) := (0, 0, 0);
                     
                  else
                     Kandidaten (2) := (0, 0, 0);
                     Kandidaten (3) := (0, 0, 0);
                  end if;
               
               when KIDatentypen.Westen =>
                  StadtImWesten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                 StadtNummerExtern        => StadtNummerSchleifenwert);
                  Kandidaten (2) := Kandidaten (3);

                  if
                    Kandidaten (2) = Kandidaten (3)
                  then
                     Kandidaten (1) := Kandidaten (2);
                     Kandidaten (2) := (0, 0, 0);
                     Kandidaten (3) := (0, 0, 0);
                     
                  else
                     Kandidaten (2) := (0, 0, 0);
                     Kandidaten (3) := (0, 0, 0);
                  end if;
                  
               when others =>
                  null;
            end case;
         end if;
         
      end loop StadtSchleife;
      
      case
        Kandidaten (1).YAchse
      is
         when 0 =>
            return (0, 0, 0);
            
         when others =>
            return Kandidaten (1);
      end case;

   end NähesteEigeneStadtSuchen;



   procedure StadtImNorden
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      StadtNummerExtern : in GlobaleDatentypen.MaximaleStädte)
   is begin
      
      if
        GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummerExtern).AchsenPosition.EAchse
        /= GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.EAchse
      then
         null;

      elsif
        GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummerExtern).AchsenPosition.YAchse
        > GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.YAchse
      then
         null;
         
      else
         case
           Kandidaten (1).YAchse
         is
            when 0 =>
               Kandidaten (2) := (GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummerExtern).AchsenPosition.EAchse,
                                  GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummerExtern).AchsenPosition.YAchse,
                                  GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummerExtern).AchsenPosition.XAchse);

            when others =>
               if
               abs (Kandidaten (1).YAchse - GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.YAchse)
                 <= abs (GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummerExtern).AchsenPosition.YAchse
                         - GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.YAchse)
               then
                  null;
                  
               else
                  Kandidaten (2) := (GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummerExtern).AchsenPosition.EAchse,
                                     GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummerExtern).AchsenPosition.YAchse,
                                     GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummerExtern).AchsenPosition.XAchse);
               end if;
         end case;
      end if;
      
   end StadtImNorden;

   

   procedure StadtImSüden
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      StadtNummerExtern : in GlobaleDatentypen.MaximaleStädte)
   is begin
      
      if
        GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummerExtern).AchsenPosition.EAchse
        /= GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.EAchse
      then
         null;

      elsif
        GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummerExtern).AchsenPosition.YAchse
        < GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.YAchse
      then
         null;
         
      else
         case
           Kandidaten (1).YAchse
         is
            when 0 =>
               Kandidaten (2) := (GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummerExtern).AchsenPosition.EAchse,
                                  GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummerExtern).AchsenPosition.YAchse,
                                  GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummerExtern).AchsenPosition.XAchse);

            when others =>
               if
               abs (Kandidaten (1).YAchse - GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.YAchse)
                 <= abs (GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummerExtern).AchsenPosition.YAchse
                         - GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.YAchse)
               then
                  null;
                  
               else
                  Kandidaten (2) := (GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummerExtern).AchsenPosition.EAchse,
                                     GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummerExtern).AchsenPosition.YAchse,
                                     GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummerExtern).AchsenPosition.XAchse);
               end if;
         end case;
      end if;
      
   end StadtImSüden;



   procedure StadtImWesten
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      StadtNummerExtern : in GlobaleDatentypen.MaximaleStädte)
   is begin
      
      if
        GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummerExtern).AchsenPosition.EAchse
        /= GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.EAchse
      then
         null;

      elsif GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummerExtern).AchsenPosition.XAchse
        > GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse
      then
         null;
         
      else
         case
           Kandidaten (1).YAchse
         is
            when 0 =>
               Kandidaten (3) := (GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummerExtern).AchsenPosition.EAchse,
                                  GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummerExtern).AchsenPosition.YAchse,
                                  GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummerExtern).AchsenPosition.XAchse);

            when others =>
               if
               abs (Kandidaten (1).XAchse - GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse)
                 <= abs (GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummerExtern).AchsenPosition.XAchse
                         - GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse)
               then
                  null;
                  
               else
                  Kandidaten (3) := (GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummerExtern).AchsenPosition.EAchse,
                                     GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummerExtern).AchsenPosition.YAchse,
                                     GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummerExtern).AchsenPosition.XAchse);
               end if;
         end case;
      end if;
      
   end StadtImWesten;



   procedure StadtImOsten
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      StadtNummerExtern : in GlobaleDatentypen.MaximaleStädte)
   is begin
      
      if
        GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummerExtern).AchsenPosition.EAchse
        /= GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.EAchse
      then
         null;

      elsif
        GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummerExtern).AchsenPosition.XAchse
        < GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse
      then
         null;
         
      else
         case
           Kandidaten (1).YAchse
         is
            when 0 =>
               Kandidaten (3) := (GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummerExtern).AchsenPosition.EAchse,
                                  GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummerExtern).AchsenPosition.YAchse,
                                  GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummerExtern).AchsenPosition.XAchse);

            when others =>
               if
               abs (Kandidaten (1).XAchse - GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse)
                 <= abs (GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummerExtern).AchsenPosition.XAchse
                         - GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse)
               then
                  null;
                  
               else
                  Kandidaten (3) := (GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummerExtern).AchsenPosition.EAchse,
                                     GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummerExtern).AchsenPosition.YAchse,
                                     GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummerExtern).AchsenPosition.XAchse);
               end if;
         end case;
      end if;
      
   end StadtImOsten;



   -- 1 = Norden = (-1, 0), 2 = Nord_Ost = (-1, 1), 3 = Osten = (0, 1), 4 = Süd_Osten = (1, 1), 5 = Süden = (1, 0), 6 = Süd_West = (1, -1), 7 = Westen = (0, -1), 8 = Nord_West = (-1, -1)
   function NähesteEigeneEinheitSuchen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      RichtungExtern : in KIDatentypen.Richtung_Enum)
      return GlobaleRecords.AchsenKartenfeldPositivRecord
   is begin

      EinheitenSchleife:
      for EinheitNummerSchleifenwert in GlobaleVariablen.EinheitenGebautArray'Range (2) loop
         
         if
           EinheitNummerSchleifenwert = EinheitRasseNummerExtern.Platznummer
         then
            null;
            
         else
            null;
         end if;
         
      end loop EinheitenSchleife;
      
      return (0, 0, 0);

   end NähesteEigeneEinheitSuchen;
   
   
   
   function UmgebungStadtBauenPrüfen     
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      MindestBewertungFeldExtern : in GlobaleDatentypen.GesamtproduktionStadt)
      return GlobaleRecords.AchsenKartenfeldPositivRecord
   is begin
      
      FeldSchlechtOderBelegt := KartenfeldUmgebungPrüfen (KoordinatenExtern          => GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition,
                                                           MindestBewertungFeldExtern => MindestBewertungFeldExtern);
      
      case
        FeldSchlechtOderBelegt
      is
         when False =>
            return (0, 0, 0);
            
         when True =>
            null;
      end case;
      
      YAchseKoordinatePrüfen := 2;
      XAchseKoordinatePrüfen := 2;
      YAchseKoordinatenSchonGeprüft := YAchseKoordinatePrüfen - 1;
      XAchseKoordinatenSchonGeprüft := XAchseKoordinatePrüfen - 1;
      
      KartenfeldSuchenSchleife:
      loop
         YAchseKartenfeldSuchenSchleife:
         for YAchseSchleifenwert in -YAchseKoordinatePrüfen .. YAchseKoordinatePrüfen loop
            XAchseKartenfeldSuchenSchleife:
            for XAchseSchleifenwert in -XAchseKoordinatePrüfen .. XAchseKoordinatePrüfen loop
               
               KartenWert := KartenPruefungen.KartenPositionBestimmen (KoordinatenExtern    => (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.EAchse,
                                                                                                GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.YAchse,
                                                                                                GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse),
                                                                       ÄnderungExtern       => (0, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                       ZusatzYAbstandExtern => 0);
            
               case
                 KartenWert.YAchse
               is
                  when 0 =>
                     exit XAchseKartenfeldSuchenSchleife;
                  
                  when others =>
                     null;
               end case;
                           
               if
                 YAchseKoordinatenSchonGeprüft >= abs (YAchseSchleifenwert)
                 and
                   XAchseKoordinatenSchonGeprüft >= abs (XAchseSchleifenwert)
               then
                  FeldSchlechtOderBelegt := True;
               
               else
                  FeldSchlechtOderBelegt
                    := KartenfeldUmgebungPrüfen (KoordinatenExtern          => (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse),
                                                  MindestBewertungFeldExtern => MindestBewertungFeldExtern);
               end if;
               
               case
                 FeldSchlechtOderBelegt
               is
                  when False =>
                     return (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse);
                     
                  when True =>
                     null;
               end case;
            
            end loop XAchseKartenfeldSuchenSchleife;
         end loop YAchseKartenfeldSuchenSchleife;
         
         if
           YAchseKoordinatePrüfen >= Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
           and
             XAchseKoordinatePrüfen >= Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
         then
            exit KartenfeldSuchenSchleife;
            
         else
            null;
         end if;
         
         if
           YAchseKoordinatePrüfen < Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
         then
            YAchseKoordinatePrüfen := YAchseKoordinatePrüfen + 1;
            YAchseKoordinatenSchonGeprüft := YAchseKoordinatePrüfen - 1;
            
         else
            null;
         end if;
            
         if
           XAchseKoordinatePrüfen < Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
         then
            XAchseKoordinatePrüfen := XAchseKoordinatePrüfen + 1;
            XAchseKoordinatenSchonGeprüft := XAchseKoordinatePrüfen - 1;
            
         else
            null;
         end if;           
         
      end loop KartenfeldSuchenSchleife;
      
      return (0, 0, 0);
      
   end UmgebungStadtBauenPrüfen;
   
   
   
   function KartenfeldUmgebungPrüfen
     (KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      MindestBewertungFeldExtern : in GlobaleDatentypen.GesamtproduktionStadt)
      return Boolean
   is begin
      
      KartenfeldBewertung := Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).Felderwertung;
      
      if
        KartenfeldBewertung >= MindestBewertungFeldExtern
      then
         null;
         
      else
         return True;
      end if;      
      
      YAchseUmgebungSchleife:
      for YAchseUmgebungSchleifenwert in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
         XAchseUmgebungSchleife:
         for XAchseUmgebungSchleifenwert in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
            
            KartenWert := KartenPruefungen.KartenPositionBestimmen (KoordinatenExtern    => KoordinatenExtern,
                                                                    ÄnderungExtern       => (0, YAchseUmgebungSchleifenwert, XAchseUmgebungSchleifenwert),
                                                                    ZusatzYAbstandExtern => 0);
            
            case
              KartenWert.YAchse
            is
               when 0 =>
                  exit XAchseUmgebungSchleife;
                  
               when others =>
                  null;
            end case;
               
            if
              Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).DurchStadtBelegterGrund > 0
            then
               return True;
               
            elsif
              Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Grund = 2
              or
                Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Grund = 31
            then
               return True;
               
            else
               null;
            end if;
            
         end loop XAchseUmgebungSchleife;
      end loop YAchseUmgebungSchleife;
      
      return False;
      
   end KartenfeldUmgebungPrüfen;

end KIPruefungen;
