pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Characters.Wide_Wide_Latin_9, Ada.Wide_Wide_Characters.Handling;
use Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Characters.Wide_Wide_Latin_9, Ada.Wide_Wide_Characters.Handling;

with Wachstum, ForschungsDatenbank, StadtWerteFestlegen, VerbesserungenDatenbank, SchleifenPruefungen, KartenDatenbank, Auswahl, Bauen, GebaeudeDatenbank, KarteStadt, Eingabe, EinheitenDatenbank,
     BewegungssystemCursor, Anzeige, Karten;

package body InDerStadt is

   procedure InDerStadt (StadtRasseNummer : GlobaleRecords.RassePlatznummerRecord) is
   begin
      
      StadtSchleife:
      loop
    
         Put (Item => CSI & "2J" & CSI & "3J" & CSI & "H");
         KarteStadt.AnzeigeStadt (StadtRasseNummer => StadtRasseNummer);
         New_Line;  

         Get_Immediate (Item => Taste);
         
         case To_Lower (Item => Taste) is
            when 'w' | 's' | 'a' | 'd' | '1' | '2' | '3' | '4' | '6' | '7' | '8' | '9' =>
               BewegungssystemCursor.BewegungCursorRichtung (Karte       => False,
                                                             Richtung    => To_Lower (Item => Taste),
                                                             RasseExtern => StadtRasseNummer.Rasse);

            when 'e' => -- Einwohner von Feld entfernen/zuweisen
               if GlobaleVariablen.CursorImSpiel (StadtRasseNummer.Rasse).AchsenPositionStadt.YAchse < Karten.Stadtkarte'First (1) + 7
                 and GlobaleVariablen.CursorImSpiel (StadtRasseNummer.Rasse).AchsenPositionStadt.XAchse > Karten.Stadtkarte'Last (2) - 7 then
                  RelativeCursorPositionY := GlobaleVariablen.CursorImSpiel (StadtRasseNummer.Rasse).AchsenPositionStadt.YAchse - 4;
                  RelativeCursorPositionX := Karten.Stadtkarte'First (2) + GlobaleVariablen.CursorImSpiel (StadtRasseNummer.Rasse).AchsenPositionStadt.XAchse - 18;
                  NutzbarerBereich := GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).StadtUmgebungGröße;
                  if RelativeCursorPositionY < -NutzbarerBereich or RelativeCursorPositionY > NutzbarerBereich or RelativeCursorPositionX < -NutzbarerBereich or RelativeCursorPositionX > NutzbarerBereich then
                     null;
                  
                  elsif RelativeCursorPositionY = 0 and RelativeCursorPositionX = 0 then
                     null;
                  
                  else
                     case GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).UmgebungBewirtschaftung (RelativeCursorPositionY, RelativeCursorPositionX) is
                        when True =>
                           GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).UmgebungBewirtschaftung (RelativeCursorPositionY, RelativeCursorPositionX) := False;
                           GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).ArbeitendeEinwohner
                             := GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).ArbeitendeEinwohner - 1;
                        
                        when False =>
                           KartenWert := SchleifenPruefungen.KartenUmgebung (Koordinaten    => GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).AchsenPosition,
                                                                             Änderung       => (0, RelativeCursorPositionY, RelativeCursorPositionX),
                                                                             ZusatzYAbstand => 0);
                           
                           case KartenWert.YAchse is
                              when GlobaleDatentypen.Kartenfeld'First =>
                                 null;
                                 
                              when others =>
                                 if GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).ArbeitendeEinwohner
                                   < GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).Einwohner then
                                    GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).UmgebungBewirtschaftung (RelativeCursorPositionY, RelativeCursorPositionX) := True;
                                    GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).ArbeitendeEinwohner
                                      := GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).ArbeitendeEinwohner + 1;
                           
                                 else
                                    null;
                                 end if;
                           end case;
                     end case;
                  end if;

               else
                  null;
               end if;
                  
               
            when 'b' => -- Gebäude/Einheit bauen
               case GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).AktuellesBauprojekt is
                  when 0 =>
                     Bauen.Bauen (StadtRasseNummer => StadtRasseNummer);
                     
                  when others =>
                     Wahl := Auswahl.AuswahlNeu (AuswahlOderAnzeige => True,
                                                 FrageDatei         => 10,
                                                 FrageZeile         => 14,
                                                 TextDatei          => 5,
                                                 ErsteZeile         => 10,
                                                 LetzteZeile        => 11);
                     case Wahl is
                        when -3 =>
                           Bauen.Bauen (StadtRasseNummer => StadtRasseNummer);
                     
                        when others =>
                           null;
                     end case;
               end case;
               
            when 'v' => -- Gebäude verkaufen
               if GlobaleVariablen.CursorImSpiel (StadtRasseNummer.Rasse).AchsenPositionStadt.YAchse = 1 and GlobaleVariablen.CursorImSpiel (StadtRasseNummer.Rasse).AchsenPositionStadt.XAchse < 13 then
                  case GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse,
                                                     StadtRasseNummer.Platznummer).GebäudeVorhanden (Integer (GlobaleVariablen.CursorImSpiel (StadtRasseNummer.Rasse).AchsenPositionStadt.XAchse)) is
                     when '0' =>
                        null;
                        
                     when others =>
                        GlobaleVariablen.Wichtiges (StadtRasseNummer.Rasse).AktuelleGeldmenge
                          := GlobaleVariablen.Wichtiges (StadtRasseNummer.Rasse).AktuelleGeldmenge + Integer (GebaeudeDatenbank.GebäudeListe (StadtRasseNummer.Rasse,
                                                                                                   Integer (GlobaleVariablen.CursorImSpiel (StadtRasseNummer.Rasse).AchsenPositionStadt.XAchse)).PreisGeld / 2);
                        GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse,
                                                      StadtRasseNummer.Platznummer).GebäudeVorhanden (Integer (GlobaleVariablen.CursorImSpiel (StadtRasseNummer.Rasse).AchsenPositionStadt.XAchse)) := '0';
                  end case;
            
               elsif GlobaleVariablen.CursorImSpiel (StadtRasseNummer.Rasse).AchsenPositionStadt.YAchse = 2 and GlobaleVariablen.CursorImSpiel (StadtRasseNummer.Rasse).AchsenPositionStadt.XAchse < 13 then
                  case GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).GebäudeVorhanden (Integer (GlobaleVariablen.CursorImSpiel (StadtRasseNummer.Rasse).AchsenPositionStadt.XAchse) + 12) is
                     when '0' =>
                        null;
                        
                     when others =>
                        GlobaleVariablen.Wichtiges (StadtRasseNummer.Rasse).AktuelleGeldmenge
                          := GlobaleVariablen.Wichtiges (StadtRasseNummer.Rasse).AktuelleGeldmenge + Integer (GebaeudeDatenbank.GebäudeListe (StadtRasseNummer.Rasse,
                                                                                                                 Integer (GlobaleVariablen.CursorImSpiel (StadtRasseNummer.Rasse).AchsenPositionStadt.XAchse) + 12).PreisGeld / 2);
                        GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse,
                                                      StadtRasseNummer.Platznummer).GebäudeVorhanden (Integer (GlobaleVariablen.CursorImSpiel (StadtRasseNummer.Rasse).AchsenPositionStadt.XAchse) + 12) := '0';
                  end case;
                  
               else
                  null;
               end if;

            when 'q' =>
               return;
               
            when others =>
               null;
         end case;
         
      end loop StadtSchleife;
      
   end InDerStadt;
   
   
   
   function StadtBauen (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord) return Boolean is
   begin

      BauMöglich := StadtBauenPrüfen (EinheitRasseNummer => EinheitRasseNummer);      
        
      case BauMöglich is
         when True =>
            null;
                  
         when False =>
            Anzeige.AnzeigeNeu (AuswahlOderAnzeige => False,
                                AktuelleAuswahl    => 1,
                                FrageDatei         => 0,
                                FrageZeile         => 0,
                                TextDatei          => 8,
                                ErsteZeile         => 6,
                                LetzteZeile        => 6);
            return False;
      end case;

      StadtSchleife:
      for StadtNummer in GlobaleVariablen.StadtGebaut'Range (2) loop
         
         if GlobaleVariablen.StadtGebaut (EinheitRasseNummer.Rasse, StadtNummer).ID /= 0 then
            null;
            
         elsif StadtNummer = GlobaleVariablen.StadtGebaut'Last (2) and GlobaleVariablen.StadtGebaut (EinheitRasseNummer.Rasse, StadtNummer).ID /= 0 then
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
               0, "000000000000000000000000", To_Unbounded_Wide_Wide_String (Source => "Name"),
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
                  
                        KartenWert := SchleifenPruefungen.KartenUmgebung (Koordinaten    => GlobaleVariablen.EinheitenGebaut (EinheitRasseNummer.Rasse, EinheitRasseNummer.Platznummer).AchsenPosition,
                                                                          Änderung      => (0, YÄnderung, XÄnderung),
                                                                          ZusatzYAbstand => 0);
                        
                        case KartenWert.YAchse is
                           when GlobaleDatentypen.Kartenfeld'First =>
                              exit XAchsenSchleife;
                        
                           when others =>
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
            StadtProduktionPrüfen (StadtRasseNummer => (EinheitRasseNummer.Rasse, StadtNummer));
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



   procedure StadtProduktionPrüfen (StadtRasseNummer : GlobaleRecords.RassePlatznummerRecord) is
   begin
      
      case StadtRasseNummer.Rasse is
         when 0 => -- Überprüfung für alle Rassen bei Runde beenden.
            RassenSchleife:
            for RasseIntern in GlobaleVariablen.StadtGebaut'Range (1) loop
               StadtSchleife:
               for StadtNummer in GlobaleVariablen.StadtGebaut'Range (2) loop
               
                  case GlobaleVariablen.StadtGebaut (RasseIntern, StadtNummer).ID is
                     when 0 =>
                        exit StadtSchleife;
                  
                     when others =>
                        StadtProduktionPrüfenBerechnung (StadtRasseNummer => (RasseIntern, StadtNummer));             
                  end case;
               
               end loop StadtSchleife;
            end loop RassenSchleife;
         
         when others => -- Überprüfung beim Bauen einer Stadt
            StadtProduktionPrüfenBerechnung (StadtRasseNummer => StadtRasseNummer);
            Wachstum.WachstumBeiStadtGründung (RasseExtern => StadtRasseNummer.Rasse);
      end case;
      
   end StadtProduktionPrüfen;
   


   procedure StadtProduktionPrüfenBerechnung (StadtRasseNummer : GlobaleRecords.RassePlatznummerRecord) is -- Legt erst eine Runde später die neuen Werte fest, prüfen warum.
   begin
      
      GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).AktuelleNahrungsproduktion := 0;
      GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).AktuelleProduktionrate := 0;
      GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).AktuelleGeldgewinnung := 0;
      GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).AktuelleForschungsrate := 0;

      NutzbarerBereich := GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).StadtUmgebungGröße;
      
      YAchseSchleife:
      for YÄnderung in -NutzbarerBereich .. NutzbarerBereich loop
         XAchseSchleife:
         for XÄnderung in -NutzbarerBereich .. NutzbarerBereich loop

            KartenWert := SchleifenPruefungen.KartenUmgebung (Koordinaten    => GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).AchsenPosition,
                                                              Änderung       => (0, YÄnderung, XÄnderung),
                                                              ZusatzYAbstand => 0);

            case KartenWert.YAchse is
               when GlobaleDatentypen.Kartenfeld'First =>
                  exit XAchseSchleife;                                 
                                 
               when others =>
                  case GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).UmgebungBewirtschaftung (YÄnderung, XÄnderung) is
                     when True =>
                        GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).AktuelleNahrungsproduktion
                          := GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).AktuelleNahrungsproduktion
                          + KartenDatenbank.KartenListe (Karten.Karten (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Grund).Nahrungsgewinnung
                          + KartenDatenbank.KartenListe (Karten.Karten (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Ressource).Nahrungsgewinnung
                          + VerbesserungenDatenbank.VerbesserungListe (Karten.Karten (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße).Nahrungsbonus
                          + VerbesserungenDatenbank.VerbesserungListe (Karten.Karten (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungGebiet).Nahrungsbonus;

                        GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).AktuelleProduktionrate
                          := GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).AktuelleProduktionrate
                          + KartenDatenbank.KartenListe (Karten.Karten (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Grund).Ressourcengewinnung
                          + KartenDatenbank.KartenListe (Karten.Karten (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Ressource).Ressourcengewinnung
                          + VerbesserungenDatenbank.VerbesserungListe (Karten.Karten (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße).Ressourcenbonus
                          + VerbesserungenDatenbank.VerbesserungListe (Karten.Karten (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungGebiet).Ressourcenbonus;

                        GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).AktuelleGeldgewinnung
                          := GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).AktuelleGeldgewinnung
                          + KartenDatenbank.KartenListe (Karten.Karten (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Grund).Geldgewinnung
                          + KartenDatenbank.KartenListe (Karten.Karten (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Ressource).Geldgewinnung
                          + VerbesserungenDatenbank.VerbesserungListe (Karten.Karten (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße).Geldbonus
                          + VerbesserungenDatenbank.VerbesserungListe (Karten.Karten (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungGebiet).Geldbonus;

                        GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).AktuelleForschungsrate
                          := GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).AktuelleForschungsrate
                          + KartenDatenbank.KartenListe (Karten.Karten (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Grund).Wissensgewinnung
                          + KartenDatenbank.KartenListe (Karten.Karten (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Ressource).Wissensgewinnung
                          + VerbesserungenDatenbank.VerbesserungListe (Karten.Karten (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße).Wissensbonus
                          + VerbesserungenDatenbank.VerbesserungListe (Karten.Karten (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungGebiet).Wissensbonus;

                     when others =>
                        null;
                  end case;
            end case;
                           
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end StadtProduktionPrüfenBerechnung;
   


   function StadtBauenPrüfen (EinheitRasseNummer : in GlobaleRecords.RassePlatznummerRecord) return Boolean is
   begin
      
      YAchseSchleife:
      for YÄnderung in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
         XAchseSchleife:
         for XÄnderung in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop

            KartenWert := SchleifenPruefungen.KartenUmgebung (Koordinaten    => GlobaleVariablen.EinheitenGebaut (EinheitRasseNummer.Rasse, EinheitRasseNummer.Platznummer).AchsenPosition,
                                                              Änderung       => (0, YÄnderung, XÄnderung),
                                                              ZusatzYAbstand => 0);
                     
            case KartenWert.YAchse is
               when GlobaleDatentypen.Kartenfeld'First =>
                  exit XAchseSchleife;
                  
               when others =>
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
      
   end StadtBauenPrüfen;
   
   
   
   procedure BelegteStadtfelderFreigeben (StadtRasseNummer : GlobaleRecords.RassePlatznummerRecord) is
   begin
      
      YAchseSchleife:
      for YÄnderung in GlobaleDatentypen.LoopRangeMinusDreiZuDrei'Range loop
         XAchseSchleife:
         for XÄnderung in GlobaleDatentypen.LoopRangeMinusDreiZuDrei'Range loop
            
            KartenWert := SchleifenPruefungen.KartenUmgebung (Koordinaten    => GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).AchsenPosition,
                                                              Änderung       => (0, YÄnderung, XÄnderung),
                                                              ZusatzYAbstand => 0);
            
            case KartenWert.YAchse is
               when GlobaleDatentypen.Kartenfeld'First =>
                  exit XAchseSchleife;
                  
               when others =>
                  if Karten.Karten (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).DurchStadtBelegterGrund
                    = GlobaleDatentypen.BelegterGrund (StadtRasseNummer.Rasse) * StadtWerteFestlegen.RassenMulitplikationWert + GlobaleDatentypen.BelegterGrund (StadtRasseNummer.Platznummer) then
                     Karten.Karten (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).DurchStadtBelegterGrund := 0;
                        
                  else
                     null;
                  end if;
            end case;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end BelegteStadtfelderFreigeben;

end InDerStadt;
