pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Characters.Wide_Wide_Latin_9, Ada.Integer_Text_IO;
use Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Characters.Wide_Wide_Latin_9;

with GlobaleKonstanten;

with GebaeudeDatenbank, KartenDatenbank, VerbesserungenDatenbank, Sichtbarkeit, Anzeige, KartenPruefungen, StadtSuchen, Karten;

package body KarteStadt is

   procedure AnzeigeStadt (StadtRasseNummer : in GlobaleRecords.RassePlatznummerRecord) is
   begin

      Put (Item => CSI & "2J" & CSI & "3J" & CSI & "H");

      Stadtumgebungsgröße := GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).StadtUmgebungGröße;

      YAchsenabstraktion := -Stadtumgebungsgröße;
      InformationenStadtAufrufen := False;
      
      YAchseSchleife:
      for YAchse in Karten.StadtkarteArray'Range (1) loop
         XAchseSchleife:
         for XAchse in Karten.StadtkarteArray'Range (2) loop
                        
            if YAchse < Karten.Stadtkarte'First (1) + 7 and XAchse > Karten.Stadtkarte'Last (2) - 7 then               
               if YAchsenabstraktion < -Stadtumgebungsgröße or YAchsenabstraktion > Stadtumgebungsgröße then
                  SchleifeFenster (YAchse => YAchse,
                                   XAchse => XAchse,
                                   Rasse  => StadtRasseNummer.Rasse);
                  exit XAchseSchleife;

               elsif Stadtumgebungsgröße = 1 and YAchse < 3 then
                  SchleifeFenster (YAchse => YAchse,
                                   XAchse => XAchse,
                                   Rasse  => StadtRasseNummer.Rasse);
                  exit XAchseSchleife;

               elsif Stadtumgebungsgröße = 2 and YAchse < 2 then
                  SchleifeFenster (YAchse => YAchse,
                                   XAchse => XAchse,
                                   Rasse  => StadtRasseNummer.Rasse);
                  exit XAchseSchleife;               
                  
               else
                  UmgebungsSchleife:
                  for Umgebung in GlobaleDatentypen.LoopRangeMinusDreiZuDrei'Range loop

                     Cursor := CursorKonstant + Umgebung;
                     if GlobaleVariablen.CursorImSpiel (StadtRasseNummer.Rasse).AchsenPositionStadt = (YAchse, XAchse + Cursor) then
                        if Umgebung < -Stadtumgebungsgröße or Umgebung > Stadtumgebungsgröße then
                           Sichtbarkeit.Farben (Einheit      => 0,
                                                Verbesserung => 0,
                                                Ressource    => 0,
                                                Grund        => 0,
                                                Cursor       => True,
                                                RasseExtern  => StadtRasseNummer.Rasse,
                                                RasseIntern  => 0);

                        else
                           CursorYAchseabstraktion := GlobaleVariablen.CursorImSpiel (StadtRasseNummer.Rasse).AchsenPositionStadt.YAchse - 4;
                           CursorXAchseabstraktion := GlobaleVariablen.CursorImSpiel (StadtRasseNummer.Rasse).AchsenPositionStadt.XAchse - 17;

                           KartenWert := KartenPruefungen.KartenPositionBestimmen (Koordinaten    => GlobaleVariablen.CursorImSpiel (StadtRasseNummer.Rasse).AchsenPosition,
                                                                                   Änderung       => (0, CursorYAchseabstraktion, CursorXAchseabstraktion),
                                                                                   ZusatzYAbstand => 0);

                           case KartenWert.Erfolgreich is
                              when False =>
                                 Sichtbarkeit.Farben (Einheit      => 0,
                                                      Verbesserung => 0,
                                                      Ressource    => 0,
                                                      Grund        => 0,
                                                      Cursor       => True,
                                                      RasseExtern  => StadtRasseNummer.Rasse,
                                                      RasseIntern  => 0);
                           
                              when True =>
                                 Sichtbarkeit.Farben (Einheit      => 0,
                                                      Verbesserung => 0,
                                                      Ressource    => 0,
                                                      Grund        => Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Grund,
                                                      Cursor       => True,
                                                      RasseExtern  => StadtRasseNummer.Rasse,
                                                      RasseIntern  => 0);
                           end case;                        
                           InformationenStadtAufrufen := True;
                        end if;
                           
                     elsif Umgebung < -Stadtumgebungsgröße or Umgebung > Stadtumgebungsgröße then
                        Put (Item => " ");

                     else
                        KartenWert := KartenPruefungen.KartenPositionBestimmen (Koordinaten    => GlobaleVariablen.CursorImSpiel (StadtRasseNummer.Rasse).AchsenPosition,
                                                                                Änderung       => (0, YAchsenabstraktion, Umgebung),
                                                                                ZusatzYAbstand => 0);

                        case KartenWert.Erfolgreich is
                           when False =>
                              Put (Item => " ");

                           when True =>
                              Sichtbarkeit.Sichtbarkeit (InDerStadt  => True,
                                                         Koordinaten => (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse),
                                                         RasseExtern => StadtRasseNummer.Rasse);
                        end case;
                     end if;

                  end loop UmgebungsSchleife;

                  New_Line;
                  YAchsenabstraktion := YAchsenabstraktion + 1;
                  exit XAchseSchleife;
               end if;
               
            elsif GlobaleVariablen.CursorImSpiel (StadtRasseNummer.Rasse).AchsenPositionStadt = (YAchse, XAchse) then
               if (YAchse < Karten.Stadtkarte'First (1) + 7 and XAchse = Karten.Stadtkarte'Last (2) - 7) or (YAchse = Karten.Stadtkarte'First (1) + 7 and XAchse >= Karten.Stadtkarte'Last (2) - 7) then
                  Sichtbarkeit.Farben (Einheit      => 0,
                                       Verbesserung => 0,
                                       Ressource    => 0,
                                       Grund        => 0,
                                       Cursor       => True,
                                       RasseExtern  => StadtRasseNummer.Rasse,
                                       RasseIntern  => 0);

               else
                  Sichtbarkeit.Farben (Einheit      => 0,
                                       Verbesserung => 0,
                                       Ressource    => 0,
                                       Grund        => Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (StadtRasseNummer.Rasse).AchsenPosition.EAchse,
                                         GlobaleVariablen.CursorImSpiel (StadtRasseNummer.Rasse).AchsenPosition.YAchse,
                                         GlobaleVariablen.CursorImSpiel (StadtRasseNummer.Rasse).AchsenPosition.XAchse).Grund,
                                       Cursor       => True,
                                       RasseExtern  => StadtRasseNummer.Rasse,
                                       RasseIntern  => 0);

               end if;

            elsif YAchse < Karten.Stadtkarte'First (1) + 7 and XAchse = Karten.Stadtkarte'Last (2) - 7 then
               Put (Item => " ");

            elsif YAchse = Karten.Stadtkarte'First (1) + 7 and XAchse >= Karten.Stadtkarte'Last (2) - 7 then
               Put (Item => " ");

            elsif YAchse = 1 and XAchse < 13 then
               if GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).GebäudeVorhanden (GlobaleDatentypen.GebäudeID (XAchse)) = True then
                  Put (Item => GebaeudeDatenbank.GebäudeListe (StadtRasseNummer.Rasse, GlobaleDatentypen.GebäudeID (XAchse)).GebäudeGrafik);

               else
                  Sichtbarkeit.Farben (Einheit      => 0,
                                       Verbesserung => 0,
                                       Ressource    => 0,
                                       Grund        => Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (StadtRasseNummer.Rasse).AchsenPosition.EAchse,
                                         GlobaleVariablen.CursorImSpiel (StadtRasseNummer.Rasse).AchsenPosition.YAchse,
                                         GlobaleVariablen.CursorImSpiel (StadtRasseNummer.Rasse).AchsenPosition.XAchse).Grund,
                                       Cursor       => False,
                                       RasseExtern  => StadtRasseNummer.Rasse,
                                       RasseIntern  => 0);
               end if;

            elsif YAchse = 2 and XAchse < 13 then
               if GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).GebäudeVorhanden (GlobaleDatentypen.GebäudeID (XAchse) + 12) = True then
                  Put (Item => GebaeudeDatenbank.GebäudeListe (StadtRasseNummer.Rasse, GlobaleDatentypen.GebäudeID (XAchse) + 12).GebäudeGrafik);

               else
                  Sichtbarkeit.Farben (Einheit      => 0,
                                       Verbesserung => 0,
                                       Ressource    => 0,
                                       Grund        => Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (StadtRasseNummer.Rasse).AchsenPosition.EAchse,
                                         GlobaleVariablen.CursorImSpiel (StadtRasseNummer.Rasse).AchsenPosition.YAchse,
                                         GlobaleVariablen.CursorImSpiel (StadtRasseNummer.Rasse).AchsenPosition.XAchse).Grund,
                                       Cursor       => False,
                                       RasseExtern  => StadtRasseNummer.Rasse,
                                       RasseIntern  => 0);
               end if;

            else
               Sichtbarkeit.Farben (Einheit      => 0,
                                    Verbesserung => 0,
                                    Ressource    => 0,
                                    Grund        => Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (StadtRasseNummer.Rasse).AchsenPosition.EAchse,
                                      GlobaleVariablen.CursorImSpiel (StadtRasseNummer.Rasse).AchsenPosition.YAchse,
                                      GlobaleVariablen.CursorImSpiel (StadtRasseNummer.Rasse).AchsenPosition.XAchse).Grund,
                                    Cursor       => False,
                                    RasseExtern  => StadtRasseNummer.Rasse,
                                    RasseIntern  => 0);
            end if;

            case XAchse is
               when Karten.Stadtkarte'Last (2) =>
                  New_Line;
                  
               when others =>
                  null;
            end case;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;

      Beschreibung (RasseExtern => StadtRasseNummer.Rasse);

      case InformationenStadtAufrufen is
         when True =>
            InformationenStadt (StadtRasseNummer => StadtRasseNummer);

         when False =>
            null;
      end case;

      if GlobaleVariablen.CursorImSpiel (StadtRasseNummer.Rasse).AchsenPositionStadt.YAchse = 1 and GlobaleVariablen.CursorImSpiel (StadtRasseNummer.Rasse).AchsenPositionStadt.XAchse < 13 then
         if GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse,
                                          StadtRasseNummer.Platznummer).GebäudeVorhanden (GlobaleDatentypen.GebäudeID (GlobaleVariablen.CursorImSpiel (StadtRasseNummer.Rasse).AchsenPositionStadt.XAchse)) = True then
            GebaeudeDatenbank.Beschreibung (ID => GlobaleDatentypen.GebäudeID (GlobaleVariablen.CursorImSpiel (StadtRasseNummer.Rasse).AchsenPositionStadt.XAchse));
            
         else
            null;
         end if;

      elsif GlobaleVariablen.CursorImSpiel (StadtRasseNummer.Rasse).AchsenPositionStadt.YAchse = 2 and GlobaleVariablen.CursorImSpiel (StadtRasseNummer.Rasse).AchsenPositionStadt.XAchse < 13 then
         if GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse,
                                          StadtRasseNummer.Platznummer).GebäudeVorhanden (GlobaleDatentypen.GebäudeID (GlobaleVariablen.CursorImSpiel (StadtRasseNummer.Rasse).AchsenPositionStadt.XAchse) + 12) = True then
            GebaeudeDatenbank.Beschreibung (ID => GlobaleDatentypen.GebäudeID (GlobaleVariablen.CursorImSpiel (StadtRasseNummer.Rasse).AchsenPositionStadt.XAchse) + 12);
            
         else
            null;
         end if;
        
      else
         null;
      end if;

      New_Line;
      
   end AnzeigeStadt;



   procedure SchleifeFenster (YAchse, XAchse : in GlobaleDatentypen.Stadtfeld; Rasse : in GlobaleDatentypen.Rassen) is
   begin
      
      -- Hier muss nur von 0 .. 6 geloopt werden, da aber Stadtfeld nur von 1 .. 20 geht, wird eins weiter geloopt und im if eins abgezogen
      UmgebungSchleife:      
      for Umgebung in KonstanterWertEins .. KonstanterWertSieben loop
                     
         if GlobaleVariablen.CursorImSpiel (Rasse).AchsenPositionStadt = (YAchse, XAchse + Umgebung - 1) then
            Sichtbarkeit.Farben (Einheit      => 0,
                                 Verbesserung => 0,
                                 Ressource    => 0,
                                 Grund        => 0,
                                 Cursor       => True,
                                 RasseExtern  => Rasse,
                                 RasseIntern  => 0);

         else
            Put (Item => " ");
         end if;
                     
      end loop UmgebungSchleife;
      
      New_Line;
      
   end SchleifeFenster;
   
   
   
   procedure InformationenStadt (StadtRasseNummer : in GlobaleRecords.RassePlatznummerRecord) is
   begin
      
      Nahrungsgewinnung := 0;
      Ressourcengewinnung := 0;
      Geldgewinnung := 0;
      Wissensgewinnung := 0;

      CursorYAchseabstraktion := GlobaleVariablen.CursorImSpiel (StadtRasseNummer.Rasse).AchsenPositionStadt.YAchse - 4;
      CursorXAchseabstraktion := GlobaleVariablen.CursorImSpiel (StadtRasseNummer.Rasse).AchsenPositionStadt.XAchse - 17;

      KartenWert := KartenPruefungen.KartenPositionBestimmen (Koordinaten    => GlobaleVariablen.CursorImSpiel (StadtRasseNummer.Rasse).AchsenPosition,
                                                              Änderung       => (0, CursorYAchseabstraktion, CursorXAchseabstraktion),
                                                              ZusatzYAbstand => 0);

      case KartenWert.Erfolgreich is
         when False =>
            null;
         
         when True =>
            if Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Hügel = True and Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Grund /= 6 then
               Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDatei => GlobaleDatentypen.Leer,
                                              TextDatei        => GlobaleDatentypen.Beschreibungen_Kartenfelder_Kurz,
                                              ÜberschriftZeile => 0,
                                              ErsteZeile       => 34,
                                              LetzteZeile      => 34,
                                              AbstandAnfang    => GlobaleDatentypen.Keiner,
                                              AbstandMitte     => GlobaleDatentypen.Keiner,
                                              AbstandEnde      => GlobaleDatentypen.Keiner);
               KartenDatenbank.Beschreibung (ID => Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Grund);

               Nahrungsgewinnung := Nahrungsgewinnung + KartenDatenbank.KartenListe (Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Grund).Nahrungsgewinnung;
               Ressourcengewinnung := Ressourcengewinnung + KartenDatenbank.KartenListe (Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Grund).Ressourcengewinnung;
               Geldgewinnung := Geldgewinnung + KartenDatenbank.KartenListe (Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Grund).Geldgewinnung;
               Wissensgewinnung := Wissensgewinnung + KartenDatenbank.KartenListe (Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Grund).Wissensgewinnung;
         
            elsif Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Hügel = True then
               KartenDatenbank.Beschreibung (ID => Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Grund);

               Nahrungsgewinnung := Nahrungsgewinnung + KartenDatenbank.KartenListe (Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Grund).Nahrungsgewinnung;
               Ressourcengewinnung := Ressourcengewinnung + KartenDatenbank.KartenListe (Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Grund).Ressourcengewinnung;
               Geldgewinnung := Geldgewinnung + KartenDatenbank.KartenListe (Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Grund).Geldgewinnung;
               Wissensgewinnung := Wissensgewinnung + KartenDatenbank.KartenListe (Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Grund).Wissensgewinnung;
               
            else         
               KartenDatenbank.Beschreibung (ID => Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Grund);

               Nahrungsgewinnung := Nahrungsgewinnung + KartenDatenbank.KartenListe (Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Grund).Nahrungsgewinnung;
               Ressourcengewinnung := Ressourcengewinnung + KartenDatenbank.KartenListe (Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Grund).Ressourcengewinnung;
               Geldgewinnung := Geldgewinnung + KartenDatenbank.KartenListe (Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Grund).Geldgewinnung;
               Wissensgewinnung := Wissensgewinnung + KartenDatenbank.KartenListe (Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Grund).Wissensgewinnung;
            end if;
      
            if Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Ressource /= 0 then
               KartenDatenbank.Beschreibung (ID => Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Ressource);

               Nahrungsgewinnung := Nahrungsgewinnung + KartenDatenbank.KartenListe (Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Ressource).Nahrungsgewinnung;
               Ressourcengewinnung := Ressourcengewinnung + KartenDatenbank.KartenListe (Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Ressource).Ressourcengewinnung;
               Geldgewinnung := Geldgewinnung + KartenDatenbank.KartenListe (Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Ressource).Geldgewinnung;
               Wissensgewinnung := Wissensgewinnung + KartenDatenbank.KartenListe (Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Ressource).Wissensgewinnung;
         
            else
               null;
            end if;
      
            if Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungGebiet /= 0 then
               VerbesserungenDatenbank.Beschreibung (ID => Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungGebiet);

               Nahrungsgewinnung := Nahrungsgewinnung + VerbesserungenDatenbank.VerbesserungListe (Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungGebiet).Nahrungsbonus;
               Ressourcengewinnung := Ressourcengewinnung + VerbesserungenDatenbank.VerbesserungListe (Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungGebiet).Ressourcenbonus;
               Geldgewinnung := Geldgewinnung + VerbesserungenDatenbank.VerbesserungListe (Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungGebiet).Geldbonus;
               Wissensgewinnung := Wissensgewinnung + VerbesserungenDatenbank.VerbesserungListe (Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungGebiet).Wissensbonus;
         
            else
               null;
            end if;
      
            if Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße /= 0 then
               VerbesserungenDatenbank.Beschreibung (ID => Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße);

               Nahrungsgewinnung := Nahrungsgewinnung + VerbesserungenDatenbank.VerbesserungListe (Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße).Nahrungsbonus;
               Ressourcengewinnung := Ressourcengewinnung + VerbesserungenDatenbank.VerbesserungListe (Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße).Ressourcenbonus;
               Geldgewinnung := Geldgewinnung + VerbesserungenDatenbank.VerbesserungListe (Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße).Geldbonus;
               Wissensgewinnung := Wissensgewinnung + VerbesserungenDatenbank.VerbesserungListe (Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße).Wissensbonus;
         
            else
               null;
            end if;
      
            if Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss /= 0 then
               KartenDatenbank.Beschreibung (ID => Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss);

               Nahrungsgewinnung := Nahrungsgewinnung + KartenDatenbank.KartenListe (Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss).Nahrungsgewinnung;
               Ressourcengewinnung := Ressourcengewinnung + KartenDatenbank.KartenListe (Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss).Ressourcengewinnung;
               Geldgewinnung := Geldgewinnung + KartenDatenbank.KartenListe (Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss).Geldgewinnung;
               Wissensgewinnung := Wissensgewinnung + KartenDatenbank.KartenListe (Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss).Wissensgewinnung;
         
            else
               null;
            end if;
            New_Line;
         
            Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDatei => GlobaleDatentypen.Leer,
                                           TextDatei        => GlobaleDatentypen.Zeug,
                                           ÜberschriftZeile => 0,
                                           ErsteZeile       => 20,
                                           LetzteZeile      => 20,
                                           AbstandAnfang    => GlobaleDatentypen.Großer_Abstand,
                                           AbstandMitte     => GlobaleDatentypen.Keiner,
                                           AbstandEnde      => GlobaleDatentypen.Kleiner_Abstand);
            Ada.Integer_Text_IO.Put (Item  => Integer (Nahrungsgewinnung),
                                     Width => 1);
         
            Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDatei => GlobaleDatentypen.Leer,
                                           TextDatei        => GlobaleDatentypen.Zeug,
                                           ÜberschriftZeile => 0,
                                           ErsteZeile       => 21,
                                           LetzteZeile      => 21,
                                           AbstandAnfang    => GlobaleDatentypen.Großer_Abstand,
                                           AbstandMitte     => GlobaleDatentypen.Keiner,
                                           AbstandEnde      => GlobaleDatentypen.Kleiner_Abstand);
            Ada.Integer_Text_IO.Put (Item  => Integer (Ressourcengewinnung),
                                     Width => 1);
            New_Line;
         
            Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDatei => GlobaleDatentypen.Leer,
                                           TextDatei        => GlobaleDatentypen.Zeug,
                                           ÜberschriftZeile => 0,
                                           ErsteZeile       => 22,
                                           LetzteZeile      => 22,
                                           AbstandAnfang    => GlobaleDatentypen.Großer_Abstand,
                                           AbstandMitte     => GlobaleDatentypen.Keiner,
                                           AbstandEnde      => GlobaleDatentypen.Kleiner_Abstand);
            Ada.Integer_Text_IO.Put (Item  => Integer (Geldgewinnung),
                                     Width => 1);
         
            Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDatei => GlobaleDatentypen.Leer,
                                           TextDatei        => GlobaleDatentypen.Zeug,
                                           ÜberschriftZeile => 0,
                                           ErsteZeile       => 23,
                                           LetzteZeile      => 23,
                                           AbstandAnfang    => GlobaleDatentypen.Großer_Abstand,
                                           AbstandMitte     => GlobaleDatentypen.Keiner,
                                           AbstandEnde      => GlobaleDatentypen.Kleiner_Abstand);
            Ada.Integer_Text_IO.Put (Item  => Integer (Wissensgewinnung),
                                     Width => 1);
            New_Line;            

            Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDatei => GlobaleDatentypen.Leer,
                                           TextDatei        => GlobaleDatentypen.Zeug,
                                           ÜberschriftZeile => 0,
                                           ErsteZeile       => 42,
                                           LetzteZeile      => 42,
                                           AbstandAnfang    => GlobaleDatentypen.Großer_Abstand,
                                           AbstandMitte     => GlobaleDatentypen.Keiner,
                                           AbstandEnde      => GlobaleDatentypen.Kleiner_Abstand);
            FeldBelegt := GlobaleVariablen.StadtGebaut (StadtRasseNummer.Rasse, StadtRasseNummer.Platznummer).UmgebungBewirtschaftung (CursorYAchseabstraktion, CursorXAchseabstraktion);
            case FeldBelegt is
               when True =>
                  Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDatei => GlobaleDatentypen.Menü_Auswahl,
                                                        TextZeile => 10);
               
               when False =>
                  Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDatei => GlobaleDatentypen.Menü_Auswahl,
                                                        TextZeile => 11);
            end case;
      end case;
      
   end InformationenStadt;
   
   

   procedure Beschreibung (RasseExtern : in GlobaleDatentypen.Rassen) is
   begin

      RasseUndPlatznummer := StadtSuchen.KoordinatenStadtOhneRasseSuchen (Koordinaten => GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition);

      case RasseUndPlatznummer.Platznummer is
         when GlobaleKonstanten.RückgabeEinheitStadtNummerFalsch =>
            null; -- Sollte nie eintreten, da entweder aus der Stadt aufgerufen oder nur wenn die Kartenprüfung bereits eine Stadt gefunden hat
      
         when others =>
            -- Allgemeine Stadtinformationen, nur sichtbar wenn das Kartenfeld aufgedackt ist und sich dort eine Stadt befindet
            case GlobaleVariablen.StadtGebaut (RasseUndPlatznummer.Rasse, RasseUndPlatznummer.Platznummer).ID is
               when 1 =>
                  if RasseExtern = RasseUndPlatznummer.Rasse then
                     Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDatei => GlobaleDatentypen.Leer,
                                                    TextDatei        => GlobaleDatentypen.Zeug,
                                                    ÜberschriftZeile => 0,
                                                    ErsteZeile       => 1,
                                                    LetzteZeile      => 1,
                                                    AbstandAnfang    => GlobaleDatentypen.Keiner,
                                                    AbstandMitte     => GlobaleDatentypen.Keiner,
                                                    AbstandEnde      => GlobaleDatentypen.Kleiner_Abstand);

                  else
                     Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDatei => GlobaleDatentypen.Leer,
                                                    TextDatei        => GlobaleDatentypen.Zeug,
                                                    ÜberschriftZeile => 0,
                                                    ErsteZeile       => 3,
                                                    LetzteZeile      => 3,
                                                    AbstandAnfang    => GlobaleDatentypen.Keiner,
                                                    AbstandMitte     => GlobaleDatentypen.Keiner,
                                                    AbstandEnde      => GlobaleDatentypen.Kleiner_Abstand);
                  end if;
                  
               when 2 =>
                  if RasseExtern = RasseUndPlatznummer.Rasse then
                     Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDatei => GlobaleDatentypen.Leer,
                                                    TextDatei        => GlobaleDatentypen.Zeug,
                                                    ÜberschriftZeile => 0,
                                                    ErsteZeile       => 2,
                                                    LetzteZeile      => 2,
                                                    AbstandAnfang    => GlobaleDatentypen.Keiner,
                                                    AbstandMitte     => GlobaleDatentypen.Keiner,
                                                    AbstandEnde      => GlobaleDatentypen.Kleiner_Abstand);
                        
                  else
                     Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDatei => GlobaleDatentypen.Leer,
                                                    TextDatei        => GlobaleDatentypen.Zeug,
                                                    ÜberschriftZeile => 0,
                                                    ErsteZeile       => 4,
                                                    LetzteZeile      => 4,
                                                    AbstandAnfang    => GlobaleDatentypen.Keiner,
                                                    AbstandMitte     => GlobaleDatentypen.Keiner,
                                                    AbstandEnde      => GlobaleDatentypen.Kleiner_Abstand);
                  end if;

               when 0 =>
                  null;
            end case;
            Put_Line (Item => To_Wide_Wide_String (Source => GlobaleVariablen.StadtGebaut (RasseUndPlatznummer.Rasse, RasseUndPlatznummer.Platznummer).Name));

            Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDatei => GlobaleDatentypen.Leer,
                                           TextDatei        => GlobaleDatentypen.Zeug,
                                           ÜberschriftZeile => 0,
                                           ErsteZeile       => 5,
                                           LetzteZeile      => 5,
                                           AbstandAnfang    => GlobaleDatentypen.Großer_Abstand,
                                           AbstandMitte     => GlobaleDatentypen.Keiner,
                                           AbstandEnde      => GlobaleDatentypen.Kleiner_Abstand);
            Ada.Integer_Text_IO.Put (Item  => Integer (GlobaleVariablen.StadtGebaut (RasseUndPlatznummer.Rasse, RasseUndPlatznummer.Platznummer).Einwohner),
                                     Width => 1);

            -- "Volle" Stadtinformationen, nur sichtbar wenn eigene Stadt oder wenn Cheat aktiviert ist                      
            if RasseUndPlatznummer.Rasse = RasseExtern or GlobaleVariablen.FeindlicheInformationenSehen = True then
               Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDatei => GlobaleDatentypen.Leer,
                                              TextDatei        => GlobaleDatentypen.Zeug,
                                              ÜberschriftZeile => 0,
                                              ErsteZeile       => 6,
                                              LetzteZeile      => 6,
                                              AbstandAnfang    => GlobaleDatentypen.Großer_Abstand,
                                              AbstandMitte     => GlobaleDatentypen.Keiner,
                                              AbstandEnde      => GlobaleDatentypen.Kleiner_Abstand);
               Ada.Integer_Text_IO.Put (Item  => Integer (GlobaleVariablen.StadtGebaut (RasseUndPlatznummer.Rasse, RasseUndPlatznummer.Platznummer).AktuelleNahrungsmittel),
                                        Width => 1);

               Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDatei => GlobaleDatentypen.Leer,
                                              TextDatei        => GlobaleDatentypen.Zeug,
                                              ÜberschriftZeile => 0,
                                              ErsteZeile       => 7,
                                              LetzteZeile      => 7,
                                              AbstandAnfang    => GlobaleDatentypen.Großer_Abstand,
                                              AbstandMitte     => GlobaleDatentypen.Keiner,
                                              AbstandEnde      => GlobaleDatentypen.Kleiner_Abstand);
               Ada.Integer_Text_IO.Put (Item  => Integer (GlobaleVariablen.StadtGebaut (RasseUndPlatznummer.Rasse, RasseUndPlatznummer.Platznummer).AktuelleNahrungsproduktion),
                                        Width => 1);
               New_Line;
                        
               Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDatei => GlobaleDatentypen.Leer,
                                              TextDatei        => GlobaleDatentypen.Zeug,
                                              ÜberschriftZeile => 0,
                                              ErsteZeile       => 8,
                                              LetzteZeile      => 8,
                                              AbstandAnfang    => GlobaleDatentypen.Großer_Abstand,
                                              AbstandMitte     => GlobaleDatentypen.Keiner,
                                              AbstandEnde      => GlobaleDatentypen.Kleiner_Abstand);
               Ada.Integer_Text_IO.Put (Item  => Integer (GlobaleVariablen.StadtGebaut (RasseUndPlatznummer.Rasse, RasseUndPlatznummer.Platznummer).AktuelleProduktionrate),
                                        Width => 1);

               Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDatei => GlobaleDatentypen.Leer,
                                              TextDatei        => GlobaleDatentypen.Zeug,
                                              ÜberschriftZeile => 0,
                                              ErsteZeile       => 9,
                                              LetzteZeile      => 9,
                                              AbstandAnfang    => GlobaleDatentypen.Großer_Abstand,
                                              AbstandMitte     => GlobaleDatentypen.Keiner,
                                              AbstandEnde      => GlobaleDatentypen.Kleiner_Abstand);
               Ada.Integer_Text_IO.Put (Item  => Integer (GlobaleVariablen.StadtGebaut (RasseUndPlatznummer.Rasse, RasseUndPlatznummer.Platznummer).AktuelleGeldgewinnung),
                                        Width => 1);

               Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDatei => GlobaleDatentypen.Leer,
                                              TextDatei        => GlobaleDatentypen.Zeug,
                                              ÜberschriftZeile => 0,
                                              ErsteZeile       => 10,
                                              LetzteZeile      => 10,
                                              AbstandAnfang    => GlobaleDatentypen.Großer_Abstand,
                                              AbstandMitte     => GlobaleDatentypen.Keiner,
                                              AbstandEnde      => GlobaleDatentypen.Kleiner_Abstand);
               Ada.Integer_Text_IO.Put (Item  => Integer (GlobaleVariablen.StadtGebaut (RasseUndPlatznummer.Rasse, RasseUndPlatznummer.Platznummer).AktuelleForschungsrate),
                                        Width => 1);
               New_Line;

               Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDatei => GlobaleDatentypen.Leer,
                                              TextDatei        => GlobaleDatentypen.Zeug,
                                              ÜberschriftZeile => 0,
                                              ErsteZeile       => 11,
                                              LetzteZeile      => 11,
                                              AbstandAnfang    => GlobaleDatentypen.Großer_Abstand,
                                              AbstandMitte     => GlobaleDatentypen.Keiner,
                                              AbstandEnde      => GlobaleDatentypen.Kleiner_Abstand);
               Ada.Integer_Text_IO.Put (Item  => Integer (GlobaleVariablen.StadtGebaut (RasseUndPlatznummer.Rasse, RasseUndPlatznummer.Platznummer).Korruption),
                                        Width => 1);

               Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDatei => GlobaleDatentypen.Leer,
                                              TextDatei        => GlobaleDatentypen.Zeug,
                                              ÜberschriftZeile => 0,
                                              ErsteZeile       => 41,
                                              LetzteZeile      => 41,
                                              AbstandAnfang    => GlobaleDatentypen.Großer_Abstand,
                                              AbstandMitte     => GlobaleDatentypen.Keiner,
                                              AbstandEnde      => GlobaleDatentypen.Kleiner_Abstand);
               Ada.Integer_Text_IO.Put (Item  => Integer (GlobaleVariablen.StadtGebaut (RasseUndPlatznummer.Rasse, RasseUndPlatznummer.Platznummer).Einwohner
                                        - GlobaleVariablen.StadtGebaut (RasseUndPlatznummer.Rasse, RasseUndPlatznummer.Platznummer).ArbeitendeEinwohner),
                                        Width => 1);

               New_Line;
               
               Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDatei => GlobaleDatentypen.Leer,
                                              TextDatei        => GlobaleDatentypen.Zeug,
                                              ÜberschriftZeile => 0,
                                              ErsteZeile       => 12,
                                              LetzteZeile      => 12,
                                              AbstandAnfang    => GlobaleDatentypen.Großer_Abstand,
                                              AbstandMitte     => GlobaleDatentypen.Keiner,
                                              AbstandEnde      => GlobaleDatentypen.Kleiner_Abstand);
               case GlobaleVariablen.StadtGebaut (RasseUndPlatznummer.Rasse, RasseUndPlatznummer.Platznummer).AktuellesBauprojekt is
                  when 0 => -- Nichts                     
                     Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDatei => GlobaleDatentypen.Leer,
                                                    TextDatei        => GlobaleDatentypen.Zeug,
                                                    ÜberschriftZeile => 0,
                                                    ErsteZeile       => 28,
                                                    LetzteZeile      => 28,
                                                    AbstandAnfang    => GlobaleDatentypen.Keiner,
                                                    AbstandMitte     => GlobaleDatentypen.Keiner,
                                                    AbstandEnde      => GlobaleDatentypen.Keiner);
            
                  when 1 .. 9_999 => -- Gebäude
                     Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDatei => GlobaleDatentypen.Leer,
                                                    TextDatei        => GlobaleDatentypen.Beschreibungen_Gebäude_Kurz,
                                                    ÜberschriftZeile => 0,
                                                    ErsteZeile       => GlobaleVariablen.StadtGebaut (RasseUndPlatznummer.Rasse, RasseUndPlatznummer.Platznummer).AktuellesBauprojekt - 1_000,
                                                    LetzteZeile      => GlobaleVariablen.StadtGebaut (RasseUndPlatznummer.Rasse, RasseUndPlatznummer.Platznummer).AktuellesBauprojekt - 1_000,
                                                    AbstandAnfang    => GlobaleDatentypen.Keiner,
                                                    AbstandMitte     => GlobaleDatentypen.Keiner,
                                                    AbstandEnde      => GlobaleDatentypen.Keiner);

                  when others => -- Einheiten
                     Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDatei => GlobaleDatentypen.Leer,
                                                    TextDatei        => GlobaleDatentypen.Beschreibungen_Einheiten_Kurz,
                                                    ÜberschriftZeile => 0,
                                                    ErsteZeile       => GlobaleVariablen.StadtGebaut (RasseUndPlatznummer.Rasse, RasseUndPlatznummer.Platznummer).AktuellesBauprojekt - 10_000,
                                                    LetzteZeile      => GlobaleVariablen.StadtGebaut (RasseUndPlatznummer.Rasse, RasseUndPlatznummer.Platznummer).AktuellesBauprojekt - 10_000,
                                                    AbstandAnfang    => GlobaleDatentypen.Keiner,
                                                    AbstandMitte     => GlobaleDatentypen.Keiner,
                                                    AbstandEnde      => GlobaleDatentypen.Keiner);
               end case;
                                              
               Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDatei => GlobaleDatentypen.Leer,
                                              TextDatei        => GlobaleDatentypen.Zeug,
                                              ÜberschriftZeile => 0,
                                              ErsteZeile       => 13,
                                              LetzteZeile      => 13,
                                              AbstandAnfang    => GlobaleDatentypen.Großer_Abstand,
                                              AbstandMitte     => GlobaleDatentypen.Keiner,
                                              AbstandEnde      => GlobaleDatentypen.Kleiner_Abstand);
               Ada.Integer_Text_IO.Put (Item  => Integer (GlobaleVariablen.StadtGebaut (RasseUndPlatznummer.Rasse, RasseUndPlatznummer.Platznummer).VerbleibendeBauzeit),
                                        Width => 1);
               New_Line;

            else
               null;
            end if;
      end case;      
      New_Line;
      
   end Beschreibung;

end KarteStadt;
