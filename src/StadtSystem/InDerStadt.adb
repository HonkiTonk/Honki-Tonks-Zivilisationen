pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Characters.Wide_Wide_Latin_9, Ada.Wide_Wide_Characters.Handling;
use Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Characters.Wide_Wide_Latin_9, Ada.Wide_Wide_Characters.Handling;

with Wachstum, ForschungsDatenbank, StadtWerteFestlegen, VerbesserungenDatenbank, SchleifenPruefungen, KartenDatenbank, Auswahl, Bauen, GebaeudeDatenbank, KarteStadt, Eingabe, EinheitenDatenbank,
     BewegungssystemCursor, Anzeige, Karten;

package body InDerStadt is

   procedure InDerStadt (RasseExtern : in GlobaleDatentypen.Rassen; StadtNummer : in Positive) is
   begin
      
      StadtSchleife:
      loop
    
         Put (Item => CSI & "2J" & CSI & "3J" & CSI & "H");
         KarteStadt.AnzeigeStadt (StadtNummer => StadtNummer,
                                  RasseExtern => RasseExtern);
         New_Line;  

         Get_Immediate (Item => Taste);
         
         case To_Lower (Item => Taste) is
            when 'w' | 's' | 'a' | 'd' | '1' | '2' | '3' | '4' | '6' | '7' | '8' | '9' =>
               BewegungssystemCursor.BewegungCursorRichtung (Karte       => False,
                                                             Richtung    => To_Lower (Item => Taste),
                                                             RasseExtern => RasseExtern);

            when 'e' => -- Einwohner von Feld entfernen/zuweisen
               if GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionStadt.YAchse < Karten.Stadtkarte'First (1) + 7
                 and GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionStadt.XAchse > Karten.Stadtkarte'Last (2) - 7 then
                  RelativeCursorPositionY := GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionStadt.YAchse - 4;
                  RelativeCursorPositionX := Karten.Stadtkarte'First (2) + GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionStadt.XAchse - 18;
                  NutzbarerBereich := GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).StadtUmgebungGröße;
                  if RelativeCursorPositionY < -NutzbarerBereich or RelativeCursorPositionY > NutzbarerBereich or RelativeCursorPositionX < -NutzbarerBereich or RelativeCursorPositionX > NutzbarerBereich then
                     null;
                  
                  elsif RelativeCursorPositionY = 0 and RelativeCursorPositionX = 0 then
                     null;
                  
                  else
                     case GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).UmgebungBewirtschaftung (RelativeCursorPositionY, RelativeCursorPositionX) is
                        when True =>
                           GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).UmgebungBewirtschaftung (RelativeCursorPositionY, RelativeCursorPositionX) := False;
                           GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).ArbeitendeEinwohner := GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).ArbeitendeEinwohner - 1;
                        
                        when False =>
                           KartenWert := SchleifenPruefungen.KartenUmgebung (Koordinaten    => GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).AchsenPosition,
                                                                             Änderung       => (0, RelativeCursorPositionY, RelativeCursorPositionX),
                                                                             ZusatzYAbstand => 0);
                           
                           case KartenWert.YAchse is
                              when GlobaleDatentypen.Kartenfeld'First =>
                                 null;
                                 
                              when others =>
                                 if GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).ArbeitendeEinwohner < GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).Einwohner then
                                    GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).UmgebungBewirtschaftung (RelativeCursorPositionY, RelativeCursorPositionX) := True;
                                    GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).ArbeitendeEinwohner := GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).ArbeitendeEinwohner + 1;
                           
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
               case GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).AktuellesBauprojekt is
                  when 0 =>
                     Bauen.Bauen (RasseExtern => RasseExtern,
                                  StadtNummer => StadtNummer);
                     
                  when others =>
                     Wahl := Auswahl.AuswahlNeu (AuswahlOderAnzeige => True,
                                                 FrageDatei         => 10,
                                                 FrageZeile         => 14,
                                                 TextDatei          => 5,
                                                 ErsteZeile         => 10,
                                                 LetzteZeile        => 11);
                     case Wahl is
                        when -3 =>
                           Bauen.Bauen (RasseExtern => RasseExtern,
                                        StadtNummer => StadtNummer);
                     
                        when others =>
                           null;
                     end case;
               end case;
               
            when 'v' => -- Gebäude verkaufen
               if GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionStadt.YAchse = 1 and GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionStadt.XAchse < 13 then
                  case GlobaleVariablen.StadtGebaut (RasseExtern, Stadtnummer).GebäudeVorhanden (Integer (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionStadt.XAchse)) is
                     when '0' =>
                        null;
                        
                     when others =>
                        GlobaleVariablen.Wichtiges (RasseExtern).AktuelleGeldmenge
                          := GlobaleVariablen.Wichtiges (RasseExtern).AktuelleGeldmenge + Integer (GebaeudeDatenbank.GebäudeListe (RasseExtern,
                                                                                                   Integer (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionStadt.XAchse)).PreisGeld / 2);
                        GlobaleVariablen.StadtGebaut (RasseExtern, Stadtnummer).GebäudeVorhanden (Integer (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionStadt.XAchse)) := '0';
                  end case;
            
               elsif GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionStadt.YAchse = 2 and GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionStadt.XAchse < 13 then
                  case GlobaleVariablen.StadtGebaut (RasseExtern, Stadtnummer).GebäudeVorhanden (Integer (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionStadt.XAchse) + 12) is
                     when '0' =>
                        null;
                        
                     when others =>
                        GlobaleVariablen.Wichtiges (RasseExtern).AktuelleGeldmenge
                          := GlobaleVariablen.Wichtiges (RasseExtern).AktuelleGeldmenge + Integer (GebaeudeDatenbank.GebäudeListe (RasseExtern,
                                                                                                   Integer (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionStadt.XAchse) + 12).PreisGeld / 2);
                        GlobaleVariablen.StadtGebaut (RasseExtern, Stadtnummer).GebäudeVorhanden (Integer (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionStadt.XAchse) + 12) := '0';
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
   
   
   
   function StadtBauen (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : in Positive) return Boolean is
   begin

      BauMöglich := StadtBauenPrüfen (RasseExtern   => RasseExtern,
                                        EinheitNummer => EinheitNummer);      
        
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
         
         if GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).ID /= 0 then
            null;
            
         elsif StadtNummer = GlobaleVariablen.StadtGebaut'Last (2) and GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).ID /= 0 then
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

            GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer) := 
              (Stadtart, (GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.EAchse, GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.YAchse,
               GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.XAchse), False, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, "000000000000000000000000", To_Unbounded_Wide_Wide_String (Source => "Name"),
               (0 => (0 => True, others => False), 
                others => (others => False)), 1, 1);
               
            case GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.EAchse is
               when 0 | 1 =>
                  YAchsenSchleife:
                  for YÄnderung in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
                     XAchsenSchleife:
                     for XÄnderung in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
                  
                        KartenWert := SchleifenPruefungen.KartenUmgebung (Koordinaten    => GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition,
                                                                          Änderung      => (0, YÄnderung, XÄnderung),
                                                                          ZusatzYAbstand => 0);
                     
                        case KartenWert.YAchse is
                           when GlobaleDatentypen.Kartenfeld'First =>
                              exit XAchsenSchleife;
                        
                           when others =>
                              case Karten.Karten (0, KartenWert.YAchse, KartenWert.XAchse).Grund is
                                 when 2 | 29 .. 31 =>
                                    GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).AmWasser := True;
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

            StadtWerteFestlegen.StadtUmgebungGrößeFestlegen (RasseExtern => RasseExtern,
                                                               StadtNummer => StadtNummer);
            StadtProduktionPrüfen (RasseExtern => RasseExtern,
                                    StadtNummer => StadtNummer);
            ForschungsDatenbank.ForschungZeit (RasseExtern => RasseExtern);            
            
            case GlobaleVariablen.RassenImSpiel (RasseExtern) is
               when 2 =>
                  EinheitenDatenbank.EinheitEntfernenOhneSortieren (RasseExtern   => RasseExtern,
                                                                    EinheitNummer => EinheitNummer);
                  
               when others =>
                  EinheitenDatenbank.EinheitEntfernenMitSortieren (RasseExtern   => RasseExtern,
                                                                   EinheitNummer => EinheitNummer);
            end case;
            
            case GlobaleVariablen.RassenImSpiel (RasseExtern) is
               when 2 =>
                  null; -- KI Stadtnamen hier einfügen
                  
               when others =>
                  GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).Name := Eingabe.StadtName;
            end case;
            return True;
         end if;
         
      end loop StadtSchleife;
      
      return False;
      
   end StadtBauen;



   procedure StadtProduktionPrüfen (RasseExtern : in GlobaleDatentypen.RassenMitNullwert; StadtNummer : in Natural) is
   begin
      
      case RasseExtern is
         when 0 => -- Überprüfung für alle Rassen bei Runde beenden.
            RassenSchleife:
            for RasseIntern in GlobaleVariablen.StadtGebaut'Range (1) loop
               StadtSchleife:
               for Stadt in GlobaleVariablen.StadtGebaut'Range (2) loop
               
                  case GlobaleVariablen.StadtGebaut (RasseIntern, Stadt).ID is
                     when 0 =>
                        exit StadtSchleife;
                  
                     when others =>
                        StadtProduktionPrüfenBerechnung (RasseExtern => RasseIntern,
                                                          StadtNummer => Stadt);             
                  end case;
               
               end loop StadtSchleife;
            end loop RassenSchleife;
         
         when others => -- Überprüfung beim Bauen einer Stadt
            StadtProduktionPrüfenBerechnung (RasseExtern => RasseExtern,
                                              StadtNummer => StadtNummer);
            Wachstum.WachstumBeiStadtGründung (RasseExtern => RasseExtern);
      end case;
      
   end StadtProduktionPrüfen;
   


   procedure StadtProduktionPrüfenBerechnung (RasseExtern : in GlobaleDatentypen.Rassen; StadtNummer : in Positive) is -- Legt erst eine Runde später die neuen Werte fest, prüfen warum.
   begin
      
      GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).AktuelleNahrungsproduktion := 0;
      GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).AktuelleProduktionrate := 0;
      GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).AktuelleGeldgewinnung := 0;
      GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).AktuelleForschungsrate := 0;

      NutzbarerBereich := GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).StadtUmgebungGröße;
      
      YAchseSchleife:
      for YÄnderung in -NutzbarerBereich .. NutzbarerBereich loop
         XAchseSchleife:
         for XÄnderung in -NutzbarerBereich .. NutzbarerBereich loop

            KartenWert := SchleifenPruefungen.KartenUmgebung (Koordinaten    => GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).AchsenPosition,
                                                              Änderung       => (0, YÄnderung, XÄnderung),
                                                              ZusatzYAbstand => 0);

            case KartenWert.YAchse is
               when GlobaleDatentypen.Kartenfeld'First =>
                  exit XAchseSchleife;                                 
                                 
               when others =>
                  case GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).UmgebungBewirtschaftung (YÄnderung, XÄnderung) is
                     when True =>
                        GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).AktuelleNahrungsproduktion
                          := GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).AktuelleNahrungsproduktion
                          + KartenDatenbank.KartenListe (Karten.Karten (GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).AchsenPosition.EAchse, KartenWert.YAchse, KartenWert.XAchse).Grund).Nahrungsgewinnung
                          + KartenDatenbank.KartenListe (Karten.Karten (0, KartenWert.YAchse, KartenWert.XAchse).Ressource).Nahrungsgewinnung
                          + VerbesserungenDatenbank.VerbesserungListe (Karten.Karten (GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).AchsenPosition.EAchse,
                                                                       KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße).Nahrungsbonus
                          + VerbesserungenDatenbank.VerbesserungListe (Karten.Karten (GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).AchsenPosition.EAchse,
                                                                       KartenWert.YAchse, KartenWert.XAchse).VerbesserungGebiet).Nahrungsbonus;

                        GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).AktuelleProduktionrate
                          := GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).AktuelleProduktionrate
                          + KartenDatenbank.KartenListe (Karten.Karten (GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).AchsenPosition.EAchse, KartenWert.YAchse, KartenWert.XAchse).Grund).Ressourcengewinnung
                          + KartenDatenbank.KartenListe (Karten.Karten (GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).AchsenPosition.EAchse, KartenWert.YAchse, KartenWert.XAchse).Ressource).Ressourcengewinnung
                          + VerbesserungenDatenbank.VerbesserungListe (Karten.Karten (GlobaleVariablen.StadtGebaut (RasseExtern,
                                                                       StadtNummer).AchsenPosition.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße).Ressourcenbonus
                          + VerbesserungenDatenbank.VerbesserungListe (Karten.Karten (GlobaleVariablen.StadtGebaut (RasseExtern,
                                                                       StadtNummer).AchsenPosition.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungGebiet).Ressourcenbonus;

                        GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).AktuelleGeldgewinnung
                          := GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).AktuelleGeldgewinnung
                          + KartenDatenbank.KartenListe (Karten.Karten (GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).AchsenPosition.EAchse, KartenWert.YAchse, KartenWert.XAchse).Grund).Geldgewinnung
                          + KartenDatenbank.KartenListe (Karten.Karten (GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).AchsenPosition.EAchse, KartenWert.YAchse, KartenWert.XAchse).Ressource).Geldgewinnung
                          + VerbesserungenDatenbank.VerbesserungListe (Karten.Karten (GlobaleVariablen.StadtGebaut (RasseExtern,
                                                                       StadtNummer).AchsenPosition.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße).Geldbonus
                          + VerbesserungenDatenbank.VerbesserungListe (Karten.Karten (GlobaleVariablen.StadtGebaut (RasseExtern,
                                                                       StadtNummer).AchsenPosition.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungGebiet).Geldbonus;

                        GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).AktuelleForschungsrate
                          := GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).AktuelleForschungsrate
                          + KartenDatenbank.KartenListe (Karten.Karten (GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).AchsenPosition.EAchse, KartenWert.YAchse, KartenWert.XAchse).Grund).Wissensgewinnung
                          + KartenDatenbank.KartenListe (Karten.Karten (GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).AchsenPosition.EAchse, KartenWert.YAchse, KartenWert.XAchse).Ressource).Wissensgewinnung
                          + VerbesserungenDatenbank.VerbesserungListe (Karten.Karten (GlobaleVariablen.StadtGebaut (RasseExtern,
                                                                       StadtNummer).AchsenPosition.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße).Wissensbonus
                          + VerbesserungenDatenbank.VerbesserungListe (Karten.Karten (GlobaleVariablen.StadtGebaut (RasseExtern,
                                                                       StadtNummer).AchsenPosition.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungGebiet).Wissensbonus;

                     when others =>
                        null;
                  end case;
            end case;
                           
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end StadtProduktionPrüfenBerechnung;
   


   function StadtBauenPrüfen (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : in Positive) return Boolean is
   begin
      
      YAchseSchleife:
      for YÄnderung in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
         XAchseSchleife:
         for XÄnderung in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop

            KartenWert := SchleifenPruefungen.KartenUmgebung (Koordinaten    => GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition,
                                                              Änderung       => (0, YÄnderung, XÄnderung),
                                                              ZusatzYAbstand => 0);
                     
            case KartenWert.YAchse is
               when GlobaleDatentypen.Kartenfeld'First =>
                  exit XAchseSchleife;
                  
               when others =>
                  case Karten.Karten (GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.EAchse, KartenWert.YAchse, KartenWert.XAchse).DurchStadtBelegterGrund is
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
   
   
   
   procedure BelegteStadtfelderFreigeben (RasseExtern : in GlobaleDatentypen.Rassen; StadtNummer : in Positive) is
   begin
      
      YAchseSchleife:
      for YÄnderung in GlobaleDatentypen.LoopRangeMinusDreiZuDrei'Range loop
         XAchseSchleife:
         for XÄnderung in GlobaleDatentypen.LoopRangeMinusDreiZuDrei'Range loop
            
            KartenWert := SchleifenPruefungen.KartenUmgebung (Koordinaten    => GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).AchsenPosition,
                                                              Änderung       => (0, YÄnderung, XÄnderung),
                                                              ZusatzYAbstand => 0);
            
            case KartenWert.YAchse is
               when GlobaleDatentypen.Kartenfeld'First =>
                  exit XAchseSchleife;
                  
               when others =>
                  if Karten.Karten (GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).AchsenPosition.EAchse, KartenWert.YAchse, KartenWert.XAchse).DurchStadtBelegterGrund
                    = GlobaleDatentypen.BelegterGrund (RasseExtern) * StadtWerteFestlegen.RassenMulitplikationWert + GlobaleDatentypen.BelegterGrund (StadtNummer) then
                     Karten.Karten (GlobaleVariablen.StadtGebaut (RasseExtern, StadtNummer).AchsenPosition.EAchse, KartenWert.YAchse, KartenWert.XAchse).DurchStadtBelegterGrund := 0;
                        
                  else
                     null;
                  end if;
            end case;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end BelegteStadtfelderFreigeben;

end InDerStadt;
