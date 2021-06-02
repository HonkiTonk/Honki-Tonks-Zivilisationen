pragma SPARK_Mode (On);

with Ada.Strings.Wide_Wide_Unbounded;
use Ada.Strings.Wide_Wide_Unbounded;

with GlobaleKonstanten;

with KIDatentypen;

with Anzeige, StadtWerteFestlegen, ForschungsDatenbank, EinheitenDatenbank, Eingabe, Karten, KartenPruefungen, StadtProduktion;

package body StadtBauen is

   procedure StadtBauen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin     
        
      if
        StadtBauenPrüfen (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = True
      then
         null;
         
      elsif
        GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = 2
      then
         return;
         
      else
         Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleDatentypen.Fehlermeldungen,
                                               TextZeileExtern => 6);
         return;
      end if;

      StadtSchleife:
      for StadtNummerSchleifenwert in GlobaleVariablen.StadtGebautArray'Range (2) loop
         
         if
           StadtNummerSchleifenwert = GlobaleVariablen.StadtGebautArray'Last (2)
           and
             GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummerSchleifenwert).ID /= 0
         then
            if
              GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = 2
            then
               return;
               
            else
               Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleDatentypen.Fehlermeldungen,
                                                     TextZeileExtern => 7);
               return;
            end if;

         elsif
           GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummerSchleifenwert).ID /= 0
         then
            null;
            
         else
            StadtNummer := StadtNummerSchleifenwert;
            exit StadtSchleife;
         end if;
         
      end loop StadtSchleife;
      
      Stadtart := HauptstadtPrüfen (RasseExtern => EinheitRasseNummerExtern.Rasse);

      -- 1. Wert = ID, 2. Wert = AchsenPosition, 3. Wert = Am Wasser, 4. Wert = Einwohner
      GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummer) := 
        (Stadtart, GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition, False, 1,
           -- 5. Wert = Aktuelle Nahrungsmittel, 6. Wert = Aktuelle Nahrungsproduktion, 7. Wert = Aktuelle Ressourcen, 8. Wert = Aktuelle Produktionrate
         0, 0, 0, 0,
         -- 9. Wert = Aktuelle Geldgewinnung, 10. Wert = Aktuelle Forschungsrate, 11. Wert = Aktuelles Bauprojekt, 12. Wert = Verbleibende Bauzeit
         0, 0, 0, 0,
         -- 13. Wert = Korruption, 14. Wert = Gebäude Vorhanden, 15. Wert = Stadtname
         0, (others => False), To_Unbounded_Wide_Wide_String (Source => "KIStadtname"),
           -- 16. Wert = UmgebungBewirtschaftung, 17. Wert = Arbeitende Einwohner, 18. Wert = StadtUmgebungGröße
         (0 => (0 => True, others => False), others => (others => False)), 1, 1,
         -- 19. Wert = KI aktuelle Beschäftigung
         KIDatentypen.Keine_Aufgabe);
               
      case
        GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.EAchse
      is
         when -1 .. 0 =>
            AmWasser (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
                  
         when others =>
            null;
      end case;
      
      StadtWerteFestlegen.StadtUmgebungGrößeFestlegen (StadtRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, StadtNummer));
      StadtProduktion.StadtProduktionPrüfen (StadtRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, StadtNummer));
      ForschungsDatenbank.ForschungZeit (RasseExtern => EinheitRasseNummerExtern.Rasse); 
            
      EinheitenDatenbank.EinheitEntfernen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
      case
        GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse)
      is
         when 2 =>
            StadtNameSchleife:
            for StadtNameSchleifenwert in KIStadtNameArray'Range (2) loop
               
               if
                 KIStadtName (EinheitRasseNummerExtern.Rasse, StadtNameSchleifenwert) = 0
               then
                  KIStadtName (EinheitRasseNummerExtern.Rasse, StadtNameSchleifenwert) := 1;
                  -- Hier dann aus Datei eingelesene Stadtnamen reinbauen
                  
               else
                  null;
               end if;
               
            end loop StadtNameSchleife;
                  
         when others =>
            GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummer).Name := Eingabe.StadtName;
      end case;
      
   end StadtBauen;



   function StadtBauenPrüfen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Boolean
   is begin
      
      if
        Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.EAchse,
                          GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.YAchse,
                          GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse).DurchStadtBelegterGrund = 0
      then
         return True;
         
      else
         return False;
      end if;
      
   end StadtBauenPrüfen;



   function ErweitertesStadtBauenPrüfen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Boolean
   is begin
      
      YAchseSchleife:
      for YÄnderungSchleifenwert in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
         XAchseSchleife:
         for XÄnderungSchleifenwert in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop

            KartenWert := KartenPruefungen.KartenPositionBestimmen (KoordinatenExtern    => GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition,
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
            
            case
              Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).DurchStadtBelegterGrund
            is
               when 0 =>
                  null;
                        
               when others =>
                  return False;
            end case;
                        
         end loop XAchseSchleife;
      end loop YAchseSchleife;

      return True;

   end ErweitertesStadtBauenPrüfen;



   function HauptstadtPrüfen
     (RasseExtern : in GlobaleDatentypen.Rassen)
      return GlobaleDatentypen.StadtID
   is begin
      
      -- Wenn die Hauptstadt existiert gibt es eine Zwei zurück, sonst eine Eins.
      HauptsstadtSchleife:
      for HauptstadtSchleifenwert in GlobaleVariablen.StadtGebautArray'Range (2) loop
         
         case
           GlobaleVariablen.StadtGebaut (RasseExtern, HauptstadtSchleifenwert).ID
         is
            when 1 =>
               return 2;
               
            when others =>
               null;
         end case;
         
      end loop HauptsstadtSchleife;
      
      return 1;
      
   end HauptstadtPrüfen;
   
   
   
   procedure AmWasser
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      YAchsenSchleife:
      for YÄnderungSchleifenwert in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
         XAchsenSchleife:
         for XÄnderungSchleifenwert in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
                  
            KartenWert := KartenPruefungen.KartenPositionBestimmen (KoordinatenExtern    => GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition,
                                                                    ÄnderungExtern       => (0, YÄnderungSchleifenwert, XÄnderungSchleifenwert),
                                                                    ZusatzYAbstandExtern => 0);
                        
            case
              KartenWert.YAchse
            is
               when 0 =>
                  exit XAchsenSchleife;
                        
               when others =>
                  null;
            end case;
                  
            case
              Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Grund
            is
               when 2 | 29 .. 31 =>
                  GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummer).AmWasser := True;
                  exit YAchsenSchleife;
                        
               when others =>
                  null;
            end case;
                  
         end loop XAchsenSchleife;
      end loop YAchsenSchleife;
      
   end AmWasser;



   procedure StadtEntfernen
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer) := GlobaleKonstanten.LeererWertStadt;
      
   end StadtEntfernen;

end StadtBauen;
