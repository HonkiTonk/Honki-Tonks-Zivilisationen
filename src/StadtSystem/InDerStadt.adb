pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Characters.Wide_Wide_Latin_9, Ada.Wide_Wide_Characters.Handling;
use Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Characters.Wide_Wide_Latin_9, Ada.Wide_Wide_Characters.Handling;

with Wachstum, ForschungsDatenbank, StadtWerteFestlegen, VerbesserungenDatenbank, SchleifenPruefungen, KartenDatenbank, Auswahl, Bauen, GebaeudeDatenbank, KarteStadt, Eingabe, EinheitenDatenbank,
     BewegungssystemCursor, Anzeige, Karten;

package body InDerStadt is

   procedure InDerStadt (StadtRasseUndNummer : GlobaleRecords.RasseUndPlatznummerRecord) is
   begin
      
      StadtSchleife:
      loop
    
         Put (Item => CSI & "2J" & CSI & "3J" & CSI & "H");
         KarteStadt.AnzeigeStadt (StadtRasseUndNummer => StadtRasseUndNummer);
         New_Line;  

         Get_Immediate (Item => Taste);
         
         case To_Lower (Item => Taste) is
            when 'w' | 's' | 'a' | 'd' | '1' | '2' | '3' | '4' | '6' | '7' | '8' | '9' =>
               BewegungssystemCursor.BewegungCursorRichtung (Karte       => False,
                                                             Richtung    => To_Lower (Item => Taste),
                                                             RasseExtern => StadtRasseUndNummer.Rasse);

            when 'e' => -- Einwohner von Feld entfernen/zuweisen
               if GlobaleVariablen.CursorImSpiel (StadtRasseUndNummer.Rasse).AchsenPositionStadt.YAchse < Karten.Stadtkarte'First (1) + 7
                 and GlobaleVariablen.CursorImSpiel (StadtRasseUndNummer.Rasse).AchsenPositionStadt.XAchse > Karten.Stadtkarte'Last (2) - 7 then
                  RelativeCursorPositionY := GlobaleVariablen.CursorImSpiel (StadtRasseUndNummer.Rasse).AchsenPositionStadt.YAchse - 4;
                  RelativeCursorPositionX := Karten.Stadtkarte'First (2) + GlobaleVariablen.CursorImSpiel (StadtRasseUndNummer.Rasse).AchsenPositionStadt.XAchse - 18;
                  NutzbarerBereich := GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).StadtUmgebungGröße;
                  if RelativeCursorPositionY < -NutzbarerBereich or RelativeCursorPositionY > NutzbarerBereich or RelativeCursorPositionX < -NutzbarerBereich or RelativeCursorPositionX > NutzbarerBereich then
                     null;
                  
                  elsif RelativeCursorPositionY = 0 and RelativeCursorPositionX = 0 then
                     null;
                  
                  else
                     case GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).UmgebungBewirtschaftung (RelativeCursorPositionY, RelativeCursorPositionX) is
                        when True =>
                           GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).UmgebungBewirtschaftung (RelativeCursorPositionY, RelativeCursorPositionX) := False;
                           GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).ArbeitendeEinwohner
                             := GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).ArbeitendeEinwohner - 1;
                        
                        when False =>
                           KartenWert := SchleifenPruefungen.KartenUmgebung (Koordinaten    => GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).AchsenPosition,
                                                                             Änderung       => (0, RelativeCursorPositionY, RelativeCursorPositionX),
                                                                             ZusatzYAbstand => 0);
                           
                           case KartenWert.YAchse is
                              when GlobaleDatentypen.Kartenfeld'First =>
                                 null;
                                 
                              when others =>
                                 if GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).ArbeitendeEinwohner
                                   < GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).Einwohner then
                                    GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).UmgebungBewirtschaftung (RelativeCursorPositionY, RelativeCursorPositionX) := True;
                                    GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).ArbeitendeEinwohner
                                      := GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).ArbeitendeEinwohner + 1;
                           
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
               case GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).AktuellesBauprojekt is
                  when 0 =>
                     Bauen.Bauen (StadtRasseUndNummer => StadtRasseUndNummer);
                     
                  when others =>
                     Wahl := Auswahl.AuswahlNeu (AuswahlOderAnzeige => True,
                                                 FrageDatei         => 10,
                                                 FrageZeile         => 14,
                                                 TextDatei          => 5,
                                                 ErsteZeile         => 10,
                                                 LetzteZeile        => 11);
                     case Wahl is
                        when -3 =>
                           Bauen.Bauen (StadtRasseUndNummer => StadtRasseUndNummer);
                     
                        when others =>
                           null;
                     end case;
               end case;
               
            when 'v' => -- Gebäude verkaufen
               if GlobaleVariablen.CursorImSpiel (StadtRasseUndNummer.Rasse).AchsenPositionStadt.YAchse = 1 and GlobaleVariablen.CursorImSpiel (StadtRasseUndNummer.Rasse).AchsenPositionStadt.XAchse < 13 then
                  case GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse,
                                                     StadtRasseUndNummer.Platznummer).GebäudeVorhanden (Integer (GlobaleVariablen.CursorImSpiel (StadtRasseUndNummer.Rasse).AchsenPositionStadt.XAchse)) is
                     when '0' =>
                        null;
                        
                     when others =>
                        GlobaleVariablen.Wichtiges (StadtRasseUndNummer.Rasse).AktuelleGeldmenge
                          := GlobaleVariablen.Wichtiges (StadtRasseUndNummer.Rasse).AktuelleGeldmenge + Integer (GebaeudeDatenbank.GebäudeListe (StadtRasseUndNummer.Rasse,
                                                                                                   Integer (GlobaleVariablen.CursorImSpiel (StadtRasseUndNummer.Rasse).AchsenPositionStadt.XAchse)).PreisGeld / 2);
                        GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse,
                                                      StadtRasseUndNummer.Platznummer).GebäudeVorhanden (Integer (GlobaleVariablen.CursorImSpiel (StadtRasseUndNummer.Rasse).AchsenPositionStadt.XAchse)) := '0';
                  end case;
            
               elsif GlobaleVariablen.CursorImSpiel (StadtRasseUndNummer.Rasse).AchsenPositionStadt.YAchse = 2 and GlobaleVariablen.CursorImSpiel (StadtRasseUndNummer.Rasse).AchsenPositionStadt.XAchse < 13 then
                  case GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).GebäudeVorhanden (Integer (GlobaleVariablen.CursorImSpiel (StadtRasseUndNummer.Rasse).AchsenPositionStadt.XAchse) + 12) is
                     when '0' =>
                        null;
                        
                     when others =>
                        GlobaleVariablen.Wichtiges (StadtRasseUndNummer.Rasse).AktuelleGeldmenge
                          := GlobaleVariablen.Wichtiges (StadtRasseUndNummer.Rasse).AktuelleGeldmenge + Integer (GebaeudeDatenbank.GebäudeListe (StadtRasseUndNummer.Rasse,
                                                                                                                 Integer (GlobaleVariablen.CursorImSpiel (StadtRasseUndNummer.Rasse).AchsenPositionStadt.XAchse) + 12).PreisGeld / 2);
                        GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse,
                                                      StadtRasseUndNummer.Platznummer).GebäudeVorhanden (Integer (GlobaleVariablen.CursorImSpiel (StadtRasseUndNummer.Rasse).AchsenPositionStadt.XAchse) + 12) := '0';
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
   
   
   
   function StadtBauen (EinheitRasseUndNummer : in GlobaleRecords.RasseUndPlatznummerRecord) return Boolean is
   begin

      BauMöglich := StadtBauenPrüfen (EinheitRasseUndNummer => EinheitRasseUndNummer);      
        
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
         
         if GlobaleVariablen.StadtGebaut (EinheitRasseUndNummer.Rasse, StadtNummer).ID /= 0 then
            null;
            
         elsif StadtNummer = GlobaleVariablen.StadtGebaut'Last (2) and GlobaleVariablen.StadtGebaut (EinheitRasseUndNummer.Rasse, StadtNummer).ID /= 0 then
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

            GlobaleVariablen.StadtGebaut (EinheitRasseUndNummer.Rasse, StadtNummer) := 
              (Stadtart, (GlobaleVariablen.EinheitenGebaut (EinheitRasseUndNummer.Rasse, EinheitRasseUndNummer.Platznummer).AchsenPosition.EAchse,
               GlobaleVariablen.EinheitenGebaut (EinheitRasseUndNummer.Rasse, EinheitRasseUndNummer.Platznummer).AchsenPosition.YAchse,
               GlobaleVariablen.EinheitenGebaut (EinheitRasseUndNummer.Rasse, EinheitRasseUndNummer.Platznummer).AchsenPosition.XAchse), False, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, "000000000000000000000000", To_Unbounded_Wide_Wide_String (Source => "Name"),
               (0 => (0 => True, others => False), 
                others => (others => False)), 1, 1,    0);
               
            case GlobaleVariablen.EinheitenGebaut (EinheitRasseUndNummer.Rasse, EinheitRasseUndNummer.Platznummer).AchsenPosition.EAchse is
               when 0 | 1 =>
                  YAchsenSchleife:
                  for YÄnderung in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
                     XAchsenSchleife:
                     for XÄnderung in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
                  
                        KartenWert := SchleifenPruefungen.KartenUmgebung (Koordinaten    => GlobaleVariablen.EinheitenGebaut (EinheitRasseUndNummer.Rasse, EinheitRasseUndNummer.Platznummer).AchsenPosition,
                                                                          Änderung      => (0, YÄnderung, XÄnderung),
                                                                          ZusatzYAbstand => 0);
                        
                        case KartenWert.YAchse is
                           when GlobaleDatentypen.Kartenfeld'First =>
                              exit XAchsenSchleife;
                        
                           when others =>
                              case Karten.Karten (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Grund is
                                 when 2 | 29 .. 31 =>
                                    GlobaleVariablen.StadtGebaut (EinheitRasseUndNummer.Rasse, StadtNummer).AmWasser := True;
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

            StadtWerteFestlegen.StadtUmgebungGrößeFestlegen (StadtRasseUndNummer => (EinheitRasseUndNummer.Rasse, StadtNummer));
            StadtProduktionPrüfen (StadtRasseUndNummer => (EinheitRasseUndNummer.Rasse, StadtNummer));
            ForschungsDatenbank.ForschungZeit (RasseExtern => EinheitRasseUndNummer.Rasse);            
            
            case GlobaleVariablen.RassenImSpiel (EinheitRasseUndNummer.Rasse) is
               when 2 =>
                  EinheitenDatenbank.EinheitEntfernenOhneSortieren (EinheitRasseUndNummer => EinheitRasseUndNummer);
                  
               when others =>
                  EinheitenDatenbank.EinheitEntfernenMitSortieren (EinheitRasseUndNummer => EinheitRasseUndNummer);
            end case;
            
            case GlobaleVariablen.RassenImSpiel (EinheitRasseUndNummer.Rasse) is
               when 2 =>
                  null; -- KI Stadtnamen hier einfügen
                  
               when others =>
                  GlobaleVariablen.StadtGebaut (EinheitRasseUndNummer.Rasse, StadtNummer).Name := Eingabe.StadtName;
            end case;
            return True;
         end if;
         
      end loop StadtSchleife;
      
      return False;
      
   end StadtBauen;



   procedure StadtProduktionPrüfen (StadtRasseUndNummer : GlobaleRecords.RasseUndPlatznummerRecord) is
   begin
      
      case StadtRasseUndNummer.Rasse is
         when 0 => -- Überprüfung für alle Rassen bei Runde beenden.
            RassenSchleife:
            for RasseIntern in GlobaleVariablen.StadtGebaut'Range (1) loop
               StadtSchleife:
               for StadtNummer in GlobaleVariablen.StadtGebaut'Range (2) loop
               
                  case GlobaleVariablen.StadtGebaut (RasseIntern, StadtNummer).ID is
                     when 0 =>
                        exit StadtSchleife;
                  
                     when others =>
                        StadtProduktionPrüfenBerechnung (StadtRasseUndNummer => (RasseIntern, StadtNummer));             
                  end case;
               
               end loop StadtSchleife;
            end loop RassenSchleife;
         
         when others => -- Überprüfung beim Bauen einer Stadt
            StadtProduktionPrüfenBerechnung (StadtRasseUndNummer => StadtRasseUndNummer);
            Wachstum.WachstumBeiStadtGründung (RasseExtern => StadtRasseUndNummer.Rasse);
      end case;
      
   end StadtProduktionPrüfen;
   


   procedure StadtProduktionPrüfenBerechnung (StadtRasseUndNummer : GlobaleRecords.RasseUndPlatznummerRecord) is -- Legt erst eine Runde später die neuen Werte fest, prüfen warum.
   begin
      
      GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).AktuelleNahrungsproduktion := 0;
      GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).AktuelleProduktionrate := 0;
      GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).AktuelleGeldgewinnung := 0;
      GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).AktuelleForschungsrate := 0;

      NutzbarerBereich := GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).StadtUmgebungGröße;
      
      YAchseSchleife:
      for YÄnderung in -NutzbarerBereich .. NutzbarerBereich loop
         XAchseSchleife:
         for XÄnderung in -NutzbarerBereich .. NutzbarerBereich loop

            KartenWert := SchleifenPruefungen.KartenUmgebung (Koordinaten    => GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).AchsenPosition,
                                                              Änderung       => (0, YÄnderung, XÄnderung),
                                                              ZusatzYAbstand => 0);

            case KartenWert.YAchse is
               when GlobaleDatentypen.Kartenfeld'First =>
                  exit XAchseSchleife;                                 
                                 
               when others =>
                  case GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).UmgebungBewirtschaftung (YÄnderung, XÄnderung) is
                     when True =>
                        GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).AktuelleNahrungsproduktion
                          := GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).AktuelleNahrungsproduktion
                          + KartenDatenbank.KartenListe (Karten.Karten (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Grund).Nahrungsgewinnung
                          + KartenDatenbank.KartenListe (Karten.Karten (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Ressource).Nahrungsgewinnung
                          + VerbesserungenDatenbank.VerbesserungListe (Karten.Karten (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße).Nahrungsbonus
                          + VerbesserungenDatenbank.VerbesserungListe (Karten.Karten (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungGebiet).Nahrungsbonus;

                        GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).AktuelleProduktionrate
                          := GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).AktuelleProduktionrate
                          + KartenDatenbank.KartenListe (Karten.Karten (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Grund).Ressourcengewinnung
                          + KartenDatenbank.KartenListe (Karten.Karten (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Ressource).Ressourcengewinnung
                          + VerbesserungenDatenbank.VerbesserungListe (Karten.Karten (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße).Ressourcenbonus
                          + VerbesserungenDatenbank.VerbesserungListe (Karten.Karten (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungGebiet).Ressourcenbonus;

                        GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).AktuelleGeldgewinnung
                          := GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).AktuelleGeldgewinnung
                          + KartenDatenbank.KartenListe (Karten.Karten (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Grund).Geldgewinnung
                          + KartenDatenbank.KartenListe (Karten.Karten (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Ressource).Geldgewinnung
                          + VerbesserungenDatenbank.VerbesserungListe (Karten.Karten (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße).Geldbonus
                          + VerbesserungenDatenbank.VerbesserungListe (Karten.Karten (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungGebiet).Geldbonus;

                        GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).AktuelleForschungsrate
                          := GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).AktuelleForschungsrate
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
   


   function StadtBauenPrüfen (EinheitRasseUndNummer : in GlobaleRecords.RasseUndPlatznummerRecord) return Boolean is
   begin
      
      YAchseSchleife:
      for YÄnderung in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
         XAchseSchleife:
         for XÄnderung in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop

            KartenWert := SchleifenPruefungen.KartenUmgebung (Koordinaten    => GlobaleVariablen.EinheitenGebaut (EinheitRasseUndNummer.Rasse, EinheitRasseUndNummer.Platznummer).AchsenPosition,
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
   
   
   
   procedure BelegteStadtfelderFreigeben (StadtRasseUndNummer : GlobaleRecords.RasseUndPlatznummerRecord) is
   begin
      
      YAchseSchleife:
      for YÄnderung in GlobaleDatentypen.LoopRangeMinusDreiZuDrei'Range loop
         XAchseSchleife:
         for XÄnderung in GlobaleDatentypen.LoopRangeMinusDreiZuDrei'Range loop
            
            KartenWert := SchleifenPruefungen.KartenUmgebung (Koordinaten    => GlobaleVariablen.StadtGebaut (StadtRasseUndNummer.Rasse, StadtRasseUndNummer.Platznummer).AchsenPosition,
                                                              Änderung       => (0, YÄnderung, XÄnderung),
                                                              ZusatzYAbstand => 0);
            
            case KartenWert.YAchse is
               when GlobaleDatentypen.Kartenfeld'First =>
                  exit XAchseSchleife;
                  
               when others =>
                  if Karten.Karten (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).DurchStadtBelegterGrund
                    = GlobaleDatentypen.BelegterGrund (StadtRasseUndNummer.Rasse) * StadtWerteFestlegen.RassenMulitplikationWert + GlobaleDatentypen.BelegterGrund (StadtRasseUndNummer.Platznummer) then
                     Karten.Karten (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).DurchStadtBelegterGrund := 0;
                        
                  else
                     null;
                  end if;
            end case;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end BelegteStadtfelderFreigeben;

end InDerStadt;
