pragma SPARK_Mode (On);

with Ada.Strings.Wide_Wide_Unbounded;
use Ada.Strings.Wide_Wide_Unbounded;

with Anzeige, StadtWerteFestlegen, ForschungsDatenbank, EinheitenDatenbank, Eingabe, Karten, KartenPruefungen, Sortieren, StadtProduktion;

package body StadtBauen is

   function StadtBauen (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord) return Boolean is
   begin

      BauMöglich := StadtBauenPrüfen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);      
        
      case BauMöglich is
         when True =>
            null;
                  
         when False =>
            if GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = 2 then
               return False;
               
            else
               Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleDatentypen.Fehlermeldungen,
                                                     TextZeileExtern => 6);
               return False;
            end if;
      end case;

      StadtSchleife:
      for StadtNummerSchleifenwert in GlobaleVariablen.StadtGebautArray'Range (2) loop
         
         if GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummerSchleifenwert).ID /= 0 then
            null;
            
         elsif StadtNummerSchleifenwert = GlobaleVariablen.StadtGebautArray'Last (2) and GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummerSchleifenwert).ID /= 0 then
            Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleDatentypen.Fehlermeldungen,
                                                  TextZeileExtern => 7);
            return False;
            
         else
            case StadtNummerSchleifenwert is
               when 1 =>
                  Stadtart := 1;
                  
               when others =>
                  Stadtart := 2;
            end case;

            -- 1. Wert = ID, 2. Wert = AchsenPosition, 3. Wert = Am Wasser, 4. Wert = Einwohner
            GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummerSchleifenwert) := 
              (Stadtart, (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.EAchse,
               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.YAchse,
               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse), False, 1,
               -- 5. Wert = Aktuelle Nahrungsmittel, 6. Wert = Aktuelle Nahrungsproduktion, 7. Wert = Aktuelle Ressourcen, 8. Wert = Aktuelle Produktionrate
               0, 0, 0, 0,
               -- 9. Wert = Aktuelle Geldgewinnung, 10. Wert = Aktuelle Forschungsrate, 11. Wert = Aktuelles Bauprojekt, 12. Wert = Verbleibende Bauzeit
               0, 0, 0, 0,
               -- 13. Wert = Korruption, 14. Wert = Gebäude Vorhanden, 15. Wert = Stadtname
               0, (others => False), To_Unbounded_Wide_Wide_String (Source => "Name"),
                 -- 16. Wert = UmgebungBewirtschaftung, 17. Wert = Arbeitende Einwohner, 18. Wert = StadtUmgebungGröße
               (0 => (0 => True, others => False), others => (others => False)), 1, 1,
               -- 19. Wert = KI aktuelle Beschäftigung
               0);
               
            case GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.EAchse is
               when 0 | 1 =>
                  YAchsenSchleife:
                  for YÄnderungSchleifenwert in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
                     XAchsenSchleife:
                     for XÄnderungSchleifenwert in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
                  
                        KartenWert := KartenPruefungen.KartenPositionBestimmen (KoordinatenExtern    => GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition,
                                                                                ÄnderungExtern       => (0, YÄnderungSchleifenwert, XÄnderungSchleifenwert),
                                                                                ZusatzYAbstandExtern => 0);
                        
                        case KartenWert.Erfolgreich is
                           when False =>
                              exit XAchsenSchleife;
                        
                           when True =>
                              case Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Grund is
                                 when 2 | 29 .. 31 =>
                                    GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummerSchleifenwert).AmWasser := True;
                                    exit YAchsenSchleife;
                        
                                 when others =>
                                    null;
                              end case;
                        end case;
                  
                     end loop XAchsenSchleife;
                  end loop YAchsenSchleife;
                  
               when others =>
                  null;
            end case;
            
            StadtWerteFestlegen.StadtUmgebungGrößeFestlegen (StadtRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, StadtNummerSchleifenwert));
            StadtProduktion.StadtProduktionPrüfen (StadtRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, StadtNummerSchleifenwert));
            ForschungsDatenbank.ForschungZeit (RasseExtern => EinheitRasseNummerExtern.Rasse); 
            
            case GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) is
               when 2 =>
                  EinheitenDatenbank.EinheitEntfernenOhneSortieren (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
                  
               when others =>
                  EinheitenDatenbank.EinheitEntfernenMitSortieren (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            end case;
            
            case GlobaleVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) is
               when 2 =>
                  null; -- KI Stadtnamen hier einfügen
                  
               when others =>
                  GlobaleVariablen.StadtGebaut (EinheitRasseNummerExtern.Rasse, StadtNummerSchleifenwert).Name := Eingabe.StadtName;
            end case;
            return True;
         end if;
         
      end loop StadtSchleife;
      
      return False;
      
   end StadtBauen;



   function StadtBauenPrüfen (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord) return Boolean is
   begin
      
      if Karten.Weltkarte (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.EAchse,
                           GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.YAchse,
                           GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition.XAchse).DurchStadtBelegterGrund = 0 then
         return True;
         
      else
         return False;
      end if;
      
   end StadtBauenPrüfen;



   function ErweitertesStadtBauenPrüfen (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord) return Boolean is
   begin
      
      YAchseSchleife:
      for YÄnderungSchleifenwert in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
         XAchseSchleife:
         for XÄnderungSchleifenwert in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop

            KartenWert := KartenPruefungen.KartenPositionBestimmen (KoordinatenExtern    => GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition,
                                                                    ÄnderungExtern       => (0, YÄnderungSchleifenwert, XÄnderungSchleifenwert),
                                                                    ZusatzYAbstandExtern => 0);
                     
            case KartenWert.Erfolgreich is
               when False =>
                  exit XAchseSchleife;
                  
               when True =>
                  case Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).DurchStadtBelegterGrund is
                     when 0 =>
                        null;
                        
                     when others =>
                        return False;
                  end case;
            end case;
                        
         end loop XAchseSchleife;
      end loop YAchseSchleife;

      return True;

   end ErweitertesStadtBauenPrüfen;



   procedure StadtEntfernenMitSortieren (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord) is
   begin
      
      GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer) := GlobaleVariablen.LeererWertStadt;
      Sortieren.StädteSortieren (RasseExtern => StadtRasseNummerExtern.Rasse);

      if GlobaleVariablen.EinheitenGebaut (StadtRasseNummerExtern.Rasse, 1).ID = 0 and GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, 1).ID = 0 then
         GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) := 0;
         
      else
         null;
      end if;
      
   end StadtEntfernenMitSortieren;



   procedure StadtEntfernenOhneSortieren (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord) is
   begin
      
      GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer) := GlobaleVariablen.LeererWertStadt;

      if GlobaleVariablen.EinheitenGebaut (StadtRasseNummerExtern.Rasse, 1).ID = 0 and GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, 1).ID = 0 then
         GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) := 0;
         
      else
         null;
      end if;
      
   end StadtEntfernenOhneSortieren;

end StadtBauen;
