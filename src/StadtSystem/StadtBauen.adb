pragma SPARK_Mode (On);

with Ada.Strings.Wide_Wide_Unbounded;
use Ada.Strings.Wide_Wide_Unbounded;

with Anzeige, StadtWerteFestlegen, ForschungsDatenbank, EinheitenDatenbank, Eingabe, Karten, InDerStadt, KartenPruefungen;

package body StadtBauen is

   function StadtBauen (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord) return Boolean is
   begin

      BauMöglich := StadtBauenPrüfen (EinheitRasseNummer => EinheitRasseNummer);      
        
      case BauMöglich is
         when True =>
            null;
                  
         when False =>
            if GlobaleVariablen.RassenImSpiel (EinheitRasseNummer.Rasse) = 2 then
               return False;
               
            else
               Anzeige.AnzeigeNeu (AuswahlOderAnzeige => False,
                                   AktuelleAuswahl    => 1,
                                   FrageDatei         => 0,
                                   FrageZeile         => 0,
                                   TextDatei          => 8,
                                   ErsteZeile         => 6,
                                   LetzteZeile        => 6);
               return False;
            end if;
      end case;

      StadtSchleife:
      for StadtNummer in GlobaleVariablen.StadtGebautArray'Range (2) loop
         
         if GlobaleVariablen.StadtGebaut (EinheitRasseNummer.Rasse, StadtNummer).ID /= 0 then
            null;
            
         elsif StadtNummer = GlobaleVariablen.StadtGebautArray'Last (2) and GlobaleVariablen.StadtGebaut (EinheitRasseNummer.Rasse, StadtNummer).ID /= 0 then
            Anzeige.AnzeigeNeu (AuswahlOderAnzeige => False,
                                AktuelleAuswahl    => 1,
                                FrageDatei         => 0,
                                FrageZeile         => 0,
                                TextDatei          => 8,
                                ErsteZeile         => 7,
                                LetzteZeile        => 7);
            
         else
            case StadtNummer is
               when 1 =>
                  Stadtart := 1;
                  
               when others =>
                  Stadtart := 2;
            end case;

            -- 1. Wert = ID, 2. Wert = AchsenPosition, 3. Wert = Am Wasser, 4. Wert = Einwohner
            GlobaleVariablen.StadtGebaut (EinheitRasseNummer.Rasse, StadtNummer) := 
              (Stadtart, (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummer.Rasse, EinheitRasseNummer.Platznummer).AchsenPosition.EAchse,
               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummer.Rasse, EinheitRasseNummer.Platznummer).AchsenPosition.YAchse,
               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummer.Rasse, EinheitRasseNummer.Platznummer).AchsenPosition.XAchse), False, 1,
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
               
            case GlobaleVariablen.EinheitenGebaut (EinheitRasseNummer.Rasse, EinheitRasseNummer.Platznummer).AchsenPosition.EAchse is
               when 0 | 1 =>
                  YAchsenSchleife:
                  for YÄnderung in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
                     XAchsenSchleife:
                     for XÄnderung in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
                  
                        KartenWert := KartenPruefungen.KartenPositionBestimmen (Koordinaten    => GlobaleVariablen.EinheitenGebaut (EinheitRasseNummer.Rasse, EinheitRasseNummer.Platznummer).AchsenPosition,
                                                                                Änderung      => (0, YÄnderung, XÄnderung),
                                                                                ZusatzYAbstand => 0);
                        
                        case KartenWert.Erfolgreich is
                           when False =>
                              exit XAchsenSchleife;
                        
                           when True =>
                              case Karten.Karten (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Grund is
                                 when 2 | 29 .. 31 =>
                                    GlobaleVariablen.StadtGebaut (EinheitRasseNummer.Rasse, StadtNummer).AmWasser := True;
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
            
            StadtWerteFestlegen.StadtUmgebungGrößeFestlegen (StadtRasseNummer => (EinheitRasseNummer.Rasse, StadtNummer));
            InDerStadt.StadtProduktionPrüfen (StadtRasseNummer => (EinheitRasseNummer.Rasse, StadtNummer));
            ForschungsDatenbank.ForschungZeit (RasseExtern => EinheitRasseNummer.Rasse); 
            
            case GlobaleVariablen.RassenImSpiel (EinheitRasseNummer.Rasse) is
               when 2 =>
                  EinheitenDatenbank.EinheitEntfernenOhneSortieren (EinheitRasseNummer => EinheitRasseNummer);
                  
               when others =>
                  EinheitenDatenbank.EinheitEntfernenMitSortieren (EinheitRasseNummer => EinheitRasseNummer);
            end case;
            
            case GlobaleVariablen.RassenImSpiel (EinheitRasseNummer.Rasse) is
               when 2 =>
                  null; -- KI Stadtnamen hier einfügen
                  
               when others =>
                  GlobaleVariablen.StadtGebaut (EinheitRasseNummer.Rasse, StadtNummer).Name := Eingabe.StadtName;
            end case;
            return True;
         end if;
         
      end loop StadtSchleife;
      
      return False;
      
   end StadtBauen;



   function StadtBauenPrüfen (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord) return Boolean is
   begin
      
      if Karten.Karten (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummer.Rasse, EinheitRasseNummer.Platznummer).AchsenPosition.EAchse,
                        GlobaleVariablen.EinheitenGebaut (EinheitRasseNummer.Rasse, EinheitRasseNummer.Platznummer).AchsenPosition.YAchse,
                        GlobaleVariablen.EinheitenGebaut (EinheitRasseNummer.Rasse, EinheitRasseNummer.Platznummer).AchsenPosition.XAchse).DurchStadtBelegterGrund = 0 then
         return True;
         
      else
         return False;
      end if;      
      
   end StadtBauenPrüfen;



   function ErweitertesStadtBauenPrüfen (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord) return Boolean is
   begin
      
      YAchseSchleife:
      for YÄnderung in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
         XAchseSchleife:
         for XÄnderung in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop

            KartenWert := KartenPruefungen.KartenPositionBestimmen (Koordinaten    => GlobaleVariablen.EinheitenGebaut (EinheitRasseNummer.Rasse, EinheitRasseNummer.Platznummer).AchsenPosition,
                                                                    Änderung       => (0, YÄnderung, XÄnderung),
                                                                    ZusatzYAbstand => 0);
                     
            case KartenWert.Erfolgreich is
               when False =>
                  exit XAchseSchleife;
                  
               when True =>
                  case Karten.Karten (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).DurchStadtBelegterGrund is
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

end StadtBauen;
