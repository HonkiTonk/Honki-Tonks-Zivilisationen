pragma SPARK_Mode (On);

with KIVariablen;

with KIBewegung;

package body KIPruefungen is
   
   function EinheitenAbstandBerechnen (EinheitEinsRasseNummerExtern, EinheitZweiRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord) return Natural is
   begin

      if GlobaleVariablen.EinheitenGebaut (EinheitEinsRasseNummerExtern.Rasse, EinheitEinsRasseNummerExtern.Platznummer).AchsenPosition.EAchse
        = GlobaleVariablen.EinheitenGebaut (EinheitZweiRasseNummerExtern.Rasse, EinheitZweiRasseNummerExtern.Platznummer).AchsenPosition.EAchse then
         KartenfeldAbstand := abs (GlobaleVariablen.EinheitenGebaut (EinheitEinsRasseNummerExtern.Rasse, EinheitEinsRasseNummerExtern.Platznummer).AchsenPosition.YAchse
                                   - GlobaleVariablen.EinheitenGebaut (EinheitZweiRasseNummerExtern.Rasse, EinheitZweiRasseNummerExtern.Platznummer).AchsenPosition.YAchse);
         case KartenfeldAbstand is
            when 1 =>
               return 1;

            when others =>
               null;
         end case;

         KartenfeldAbstand := abs (GlobaleVariablen.EinheitenGebaut (EinheitEinsRasseNummerExtern.Rasse, EinheitEinsRasseNummerExtern.Platznummer).AchsenPosition.XAchse
                                   - GlobaleVariablen.EinheitenGebaut (EinheitZweiRasseNummerExtern.Rasse, EinheitZweiRasseNummerExtern.Platznummer).AchsenPosition.XAchse);
         case KartenfeldAbstand is
            when 1 =>
               return 1;

            when others =>
               null;
         end case;

      elsif abs (GlobaleVariablen.EinheitenGebaut (EinheitEinsRasseNummerExtern.Rasse, EinheitEinsRasseNummerExtern.Platznummer).AchsenPosition.EAchse
                 - GlobaleVariablen.EinheitenGebaut (EinheitZweiRasseNummerExtern.Rasse, EinheitZweiRasseNummerExtern.Platznummer).AchsenPosition.EAchse) = 1 then
         KartenfeldAbstand := abs (GlobaleVariablen.EinheitenGebaut (EinheitEinsRasseNummerExtern.Rasse, EinheitEinsRasseNummerExtern.Platznummer).AchsenPosition.YAchse
                                   - GlobaleVariablen.EinheitenGebaut (EinheitZweiRasseNummerExtern.Rasse, EinheitZweiRasseNummerExtern.Platznummer).AchsenPosition.YAchse);
         case KartenfeldAbstand is
            when 0 .. 1 =>
               return 1;

            when others =>
               null;
         end case;

         KartenfeldAbstand := abs (GlobaleVariablen.EinheitenGebaut (EinheitEinsRasseNummerExtern.Rasse, EinheitEinsRasseNummerExtern.Platznummer).AchsenPosition.XAchse
                                   - GlobaleVariablen.EinheitenGebaut (EinheitZweiRasseNummerExtern.Rasse, EinheitZweiRasseNummerExtern.Platznummer).AchsenPosition.XAchse);
         case KartenfeldAbstand is
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



   procedure ZielBerechnenGefahr (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord) is
   begin

      RichtungenFeinde := (others => 0);
      Richtung := 0;
      
      YAchseSchleife:
      for YAchse in GlobaleDatentypen.LoopRangeMinusDreiZuDrei loop
         XAchseSchleife:
         for XAchse in GlobaleDatentypen.LoopRangeMinusDreiZuDrei loop

            -- 1 = Norden (-), 2 = Westen (-), 3 = Süden (+), 4 = Osten (+)
            if YAchse < 0 and KIVariablen.FeindlicheEinheiten (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer, YAchse, XAchse) /= 0 then
               RichtungenFeinde (1) := RichtungenFeinde (1) + 1;

            elsif YAchse = 0 and KIVariablen.FeindlicheEinheiten (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer, YAchse, XAchse) /= 0 then  
               RichtungenFeinde (1) := RichtungenFeinde (1) + 1;
               RichtungenFeinde (3) := RichtungenFeinde (3) + 1;
               
            elsif YAchse > 0 and KIVariablen.FeindlicheEinheiten (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer, YAchse, XAchse) /= 0 then 
               RichtungenFeinde (3) := RichtungenFeinde (3) + 1;
            else
               null;
            end if;

            if XAchse < 0 and KIVariablen.FeindlicheEinheiten (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer, YAchse, XAchse) /= 0 then
               RichtungenFeinde (2) := RichtungenFeinde (2) + 1;

            elsif XAchse = 0 and KIVariablen.FeindlicheEinheiten (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer, YAchse, XAchse) /= 0 then  
               RichtungenFeinde (2) := RichtungenFeinde (2) + 1;
               RichtungenFeinde (4) := RichtungenFeinde (4) + 1;
               
            elsif XAchse > 0 and KIVariablen.FeindlicheEinheiten (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer, YAchse, XAchse) /= 0 then 
               RichtungenFeinde (4) := RichtungenFeinde (4) + 1;
            else
               null;
            end if;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;      
      
      -- 1 = Norden (-), 2 = Westen (-), 3 = Süden (+), 4 = Osten (+)
      if RichtungenFeinde (1) /= 0 or RichtungenFeinde (3) /= 0 then
         if RichtungenFeinde (1) > RichtungenFeinde (3) then
            Richtung := 5;

         elsif RichtungenFeinde (1) = RichtungenFeinde (3) then
            null;
         
         else
            Richtung := 1;
         end if;

      else
         null;
      end if;
      
      if RichtungenFeinde (2) /= 0 or RichtungenFeinde (4) /= 0 then
         if RichtungenFeinde (2) > RichtungenFeinde (4) then
            case Richtung is
               when 5 =>
                  Richtung := 4;

               when 1 =>
                  Richtung := 2;
                  
               when others =>
                  Richtung := 3;
            end case;

         elsif RichtungenFeinde (2) = RichtungenFeinde (4) then
            null;
            
         else            
            case Richtung is
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
      KIBewegung.NeuesZielErmittelnGefahr (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                           RichtungExtern           => KIDatentypen.Richtung_Enum'Val (Richtung));

   end ZielBerechnenGefahr;



   -- 1 = Norden = (-1, 0), 2 = Nord_Ost = (-1, 1), 3 = Osten = (0, 1), 4 = Süd_Osten = (1, 1), 5 = Süden = (1, 0), 6 = Süd_West = (1, -1), 7 = Westen = (0, -1), 8 = Nord_West = (-1, -1)
   function NähesteEigeneStadtSuchen (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord; RichtungExtern : in KIDatentypen.Richtung_Enum) return GlobaleRecords.AchsenKartenfeldPositivErfolgreichRecord is
   begin

      -- Kandidaten (1) ist die jetzt näheste gefundene Stadt, Kandidaten (2) ist Norden oder Süden und Kandidaten (3) ist Westen oder Osten.
      Kandidaten := (others => (0, 1, 1, False));

      StadtSchleife:
      for StadtNummer in GlobaleVariablen.StadtGebautArray'Range (2) loop

         if GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummer).ID = 0 then
            exit StadtSchleife;
            
         else
            case RichtungExtern is
               when KIDatentypen.Norden | KIDatentypen.Nord_Ost | KIDatentypen.Nord_West =>
                  
                  StadtImNorden (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                 StadtNummerExtern        => StadtNummer);

                  case RichtungExtern is
                     when KIDatentypen.Nord_Ost =>
                        StadtImOsten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                      StadtNummerExtern        => StadtNummer);
                        
                     when KIDatentypen.Nord_West =>
                        StadtImWesten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                       StadtNummerExtern        => StadtNummer);
                           
                     when others =>
                        Kandidaten (3) := Kandidaten (2);
                  end case;

                  if Kandidaten (2) = Kandidaten (3) then
                     Kandidaten (1) := Kandidaten (2);
                     Kandidaten (2) := (0, 1, 1, False);
                     Kandidaten (3) := (0, 1, 1, False);
                     
                  else
                     Kandidaten (2) := (0, 1, 1, False);
                     Kandidaten (3) := (0, 1, 1, False);
                  end if;
               
               when KIDatentypen.Osten =>
                  StadtImOsten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                StadtNummerExtern        => StadtNummer);
                  Kandidaten (2) := Kandidaten (3);

                  if Kandidaten (2) = Kandidaten (3) then
                     Kandidaten (1) := Kandidaten (2);
                     Kandidaten (2) := (0, 1, 1, False);
                     Kandidaten (3) := (0, 1, 1, False);
                     
                  else
                     Kandidaten (2) := (0, 1, 1, False);
                     Kandidaten (3) := (0, 1, 1, False);
                  end if;
               
               when KIDatentypen.Süden | KIDatentypen.Süd_Ost | KIDatentypen.Süd_West =>
                  StadtImSüden (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                 StadtNummerExtern        => StadtNummer);

                  case RichtungExtern is
                     when KIDatentypen.Süd_Ost =>
                        StadtImOsten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                      StadtNummerExtern        => StadtNummer);
                           
                     when KIDatentypen.Süd_West =>
                        StadtImWesten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                       StadtNummerExtern        => StadtNummer);
                           
                     when others =>
                        Kandidaten (3) := Kandidaten (2);
                  end case;

                  if Kandidaten (2) = Kandidaten (3) then
                     Kandidaten (1) := Kandidaten (2);
                     Kandidaten (2) := (0, 1, 1, False);
                     Kandidaten (3) := (0, 1, 1, False);
                     
                  else
                     Kandidaten (2) := (0, 1, 1, False);
                     Kandidaten (3) := (0, 1, 1, False);
                  end if;
               
               when KIDatentypen.Westen =>
                  StadtImWesten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                 StadtNummerExtern        => StadtNummer);
                  Kandidaten (2) := Kandidaten (3);

                  if Kandidaten (2) = Kandidaten (3) then
                     Kandidaten (1) := Kandidaten (2);
                     Kandidaten (2) := (0, 1, 1, False);
                     Kandidaten (3) := (0, 1, 1, False);
                     
                  else
                     Kandidaten (2) := (0, 1, 1, False);
                     Kandidaten (3) := (0, 1, 1, False);
                  end if;
                  
               when others =>
                  null;
            end case;
         end if;
         
      end loop StadtSchleife;
      
      if Kandidaten (1).Erfolgreich = True then
         return Kandidaten (1);
         
      else
         return (0, 1, 1, False);
      end if;

   end NähesteEigeneStadtSuchen;



   procedure StadtImNorden (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord; StadtNummerExtern : in GlobaleDatentypen.MaximaleStädte) is
   begin
      
      if GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummerExtern).AchsenPosition.EAchse
        /= GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.EAchse then
         null;

      elsif GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummerExtern).AchsenPosition.YAchse
        > GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.YAchse then
         null;
         
      else
         case Kandidaten (1).Erfolgreich is
            when False =>
               Kandidaten (2) := (GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummerExtern).AchsenPosition.EAchse,
                                  GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummerExtern).AchsenPosition.YAchse,
                                  GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummerExtern).AchsenPosition.XAchse, True);

            when True =>
               if abs (Kandidaten (1).YAchse - GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.YAchse)
                 <= abs (GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummerExtern).AchsenPosition.YAchse
                         - GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.YAchse) then
                  null;
                  
               else
                  Kandidaten (2) := (GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummerExtern).AchsenPosition.EAchse,
                                     GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummerExtern).AchsenPosition.YAchse,
                                     GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummerExtern).AchsenPosition.XAchse, True);
               end if;
         end case;
      end if;
      
   end StadtImNorden;

   

   procedure StadtImSüden (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord; StadtNummerExtern : in GlobaleDatentypen.MaximaleStädte) is
   begin
      
      if GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummerExtern).AchsenPosition.EAchse
        /= GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.EAchse then
         null;

      elsif GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummerExtern).AchsenPosition.YAchse
        < GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.YAchse then
         null;
         
      else
         case Kandidaten (1).Erfolgreich is
            when False =>
               Kandidaten (2) := (GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummerExtern).AchsenPosition.EAchse,
                                  GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummerExtern).AchsenPosition.YAchse,
                                  GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummerExtern).AchsenPosition.XAchse, True);

            when True =>
               if abs (Kandidaten (1).YAchse - GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.YAchse)
                 <= abs (GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummerExtern).AchsenPosition.YAchse
                         - GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.YAchse) then
                  null;
                  
               else
                  Kandidaten (2) := (GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummerExtern).AchsenPosition.EAchse,
                                     GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummerExtern).AchsenPosition.YAchse,
                                     GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummerExtern).AchsenPosition.XAchse, True);
               end if;
         end case;
      end if;
      
   end StadtImSüden;



   procedure StadtImWesten (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord; StadtNummerExtern : in GlobaleDatentypen.MaximaleStädte) is
   begin
      
      if GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummerExtern).AchsenPosition.EAchse
        /= GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.EAchse then
         null;

      elsif GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummerExtern).AchsenPosition.XAchse
        > GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse then
         null;
         
      else
         case Kandidaten (1).Erfolgreich is
            when False =>
               Kandidaten (3) := (GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummerExtern).AchsenPosition.EAchse,
                                  GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummerExtern).AchsenPosition.YAchse,
                                  GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummerExtern).AchsenPosition.XAchse, True);

            when True =>
               if abs (Kandidaten (1).XAchse - GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse)
                 <= abs (GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummerExtern).AchsenPosition.XAchse
                         - GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse) then
                  null;
                  
               else
                  Kandidaten (3) := (GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummerExtern).AchsenPosition.EAchse,
                                     GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummerExtern).AchsenPosition.YAchse,
                                     GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummerExtern).AchsenPosition.XAchse, True);
               end if;
         end case;
      end if;
      
   end StadtImWesten;



   procedure StadtImOsten (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord; StadtNummerExtern : in GlobaleDatentypen.MaximaleStädte) is
   begin
      
      if GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummerExtern).AchsenPosition.EAchse
        /= GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.EAchse then
         null;

      elsif GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummerExtern).AchsenPosition.XAchse
        < GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse then
         null;
         
      else
         case Kandidaten (1).Erfolgreich is
            when False =>
               Kandidaten (3) := (GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummerExtern).AchsenPosition.EAchse,
                                  GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummerExtern).AchsenPosition.YAchse,
                                  GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummerExtern).AchsenPosition.XAchse, True);

            when True =>
               if abs (Kandidaten (1).XAchse - GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse)
                 <= abs (GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummerExtern).AchsenPosition.XAchse
                         - GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse) then
                  null;
                  
               else
                  Kandidaten (3) := (GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummerExtern).AchsenPosition.EAchse,
                                     GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummerExtern).AchsenPosition.YAchse,
                                     GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummerExtern).AchsenPosition.XAchse, True);
               end if;
         end case;
      end if;
      
   end StadtImOsten;



   -- 1 = Norden = (-1, 0), 2 = Nord_Ost = (-1, 1), 3 = Osten = (0, 1), 4 = Süd_Osten = (1, 1), 5 = Süden = (1, 0), 6 = Süd_West = (1, -1), 7 = Westen = (0, -1), 8 = Nord_West = (-1, -1)
   function NähesteEigeneEinheitSuchen (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord; RichtungExtern : in KIDatentypen.Richtung_Enum) return GlobaleRecords.AchsenKartenfeldPositivErfolgreichRecord is
   begin

      EinheitenSchleife:
      for EinheitNummer in GlobaleVariablen.EinheitenGebautArray'Range (2) loop
         
         if EinheitNummer = EinheitRasseNummerExtern.Platznummer then
            null;
            
         else
            null;
         end if;
         
      end loop EinheitenSchleife;
      
      return (0, 1, 1, False);

   end NähesteEigeneEinheitSuchen;

end KIPruefungen;
