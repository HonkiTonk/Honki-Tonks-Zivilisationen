pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO, Ada.Characters.Wide_Wide_Latin_9, Ada.Wide_Wide_Characters.Handling;
use Ada.Wide_Wide_Text_IO, Ada.Characters.Wide_Wide_Latin_9, Ada.Wide_Wide_Characters.Handling;

with Wachstum, VerbesserungenDatenbank, KartenDatenbank, Auswahl, InDerStadtBauen, GebaeudeDatenbank, KarteStadt, BewegungssystemCursor, Karten, KartenPruefungen;

package body InDerStadt is

   procedure InDerStadt (StadtRasseNummer : in GlobaleRecords.RassePlatznummerRecord) is
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
                           KartenWert := KartenPruefungen.KartenPositionBestimmen (Koordinaten    => GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).AchsenPosition,
                                                                                   Änderung       => (0, RelativeCursorPositionY, RelativeCursorPositionX),
                                                                                   ZusatzYAbstand => 0);
                           
                           case KartenWert.Erfolgreich is
                              when False =>
                                 null;
                                 
                              when True =>
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
                     InDerStadtBauen.Bauen (StadtRasseNummer => StadtRasseNummer);
                     
                  when others =>
                     Wahl := Auswahl.AuswahlJaNein (FrageZeile => 14);
                     case Wahl is
                        when -3 =>
                           InDerStadtBauen.Bauen (StadtRasseNummer => StadtRasseNummer);
                     
                        when others =>
                           null;
                     end case;
               end case;
               
            when 'v' => -- Gebäude verkaufen
               if GlobaleVariablen.CursorImSpiel (StadtRasseNummer.Rasse).AchsenPositionStadt.YAchse = 1 and GlobaleVariablen.CursorImSpiel (StadtRasseNummer.Rasse).AchsenPositionStadt.XAchse < 13 then
                  case GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse,
                                                     StadtRasseNummer.Platznummer).GebäudeVorhanden (GlobaleDatentypen.GebäudeID (GlobaleVariablen.CursorImSpiel (StadtRasseNummer.Rasse).AchsenPositionStadt.XAchse)) is
                     when False =>
                        null;
                        
                     when others =>
                        GlobaleVariablen.Wichtiges (StadtRasseNummer.Rasse).AktuelleGeldmenge
                          := GlobaleVariablen.Wichtiges (StadtRasseNummer.Rasse).AktuelleGeldmenge
                          + Integer (GebaeudeDatenbank.GebäudeListe (StadtRasseNummer.Rasse, GlobaleDatentypen.GebäudeID (GlobaleVariablen.CursorImSpiel (StadtRasseNummer.Rasse).AchsenPositionStadt.XAchse)).PreisGeld / 2);
                        GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse,
                                                      StadtRasseNummer.Platznummer).GebäudeVorhanden (GlobaleDatentypen.GebäudeID (GlobaleVariablen.CursorImSpiel (StadtRasseNummer.Rasse).AchsenPositionStadt.XAchse)) := False;
                  end case;
            
               elsif GlobaleVariablen.CursorImSpiel (StadtRasseNummer.Rasse).AchsenPositionStadt.YAchse = 2 and GlobaleVariablen.CursorImSpiel (StadtRasseNummer.Rasse).AchsenPositionStadt.XAchse < 13 then
                  case GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse,
                                                     StadtRasseNummer.Platznummer).GebäudeVorhanden (GlobaleDatentypen.GebäudeID (GlobaleVariablen.CursorImSpiel (StadtRasseNummer.Rasse).AchsenPositionStadt.XAchse) + 12) is
                     when False =>
                        null;
                        
                     when others =>
                        GlobaleVariablen.Wichtiges (StadtRasseNummer.Rasse).AktuelleGeldmenge := GlobaleVariablen.Wichtiges (StadtRasseNummer.Rasse).AktuelleGeldmenge
                          + Integer (GebaeudeDatenbank.GebäudeListe (StadtRasseNummer.Rasse, GlobaleDatentypen.GebäudeID (GlobaleVariablen.CursorImSpiel (StadtRasseNummer.Rasse).AchsenPositionStadt.XAchse) + 12).PreisGeld / 2);
                        GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse,
                                                      StadtRasseNummer.Platznummer).GebäudeVorhanden (GlobaleDatentypen.GebäudeID (GlobaleVariablen.CursorImSpiel (StadtRasseNummer.Rasse).AchsenPositionStadt.XAchse)
                                                                                                       + 12) := False;
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



   procedure StadtProduktionPrüfen (StadtRasseNummer : in GlobaleRecords.RassePlatznummerRecord) is
   begin
      
      case StadtRasseNummer.Rasse is
         when 0 => -- Überprüfung für alle Rassen bei Runde beenden.
            RassenSchleife:
            for RasseIntern in GlobaleVariablen.StadtGebautArray'Range (1) loop
               StadtSchleife:
               for StadtNummer in GlobaleVariablen.StadtGebautArray'Range (2) loop
               
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
   


   procedure StadtProduktionPrüfenBerechnung (StadtRasseNummer : in GlobaleRecords.RassePlatznummerRecord) is -- Legt erst eine Runde später die neuen Werte fest, prüfen warum.
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

            KartenWert := KartenPruefungen.KartenPositionBestimmen (Koordinaten    => GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).AchsenPosition,
                                                                    Änderung       => (0, YÄnderung, XÄnderung),
                                                                    ZusatzYAbstand => 0);

            case KartenWert.Erfolgreich is
               when False =>
                  exit XAchseSchleife;                                 
                                 
               when True =>
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

end InDerStadt;
