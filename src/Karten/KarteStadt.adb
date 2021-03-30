pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Characters.Wide_Wide_Latin_9, Ada.Integer_Text_IO;
use Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, Ada.Characters.Wide_Wide_Latin_9;

with GlobaleKonstanten;

with GebaeudeDatenbank, KartenDatenbank, VerbesserungenDatenbank, Sichtbarkeit, Anzeige, KartenPruefungen, StadtSuchen, Karten;

package body KarteStadt is

   procedure AnzeigeStadt (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord) is
   begin

      Put (Item => CSI & "2J" & CSI & "3J" & CSI & "H");

      Stadtumgebungsgröße := GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).StadtUmgebungGröße;

      YAchsenabstraktion := -Stadtumgebungsgröße;
      InformationenStadtAufrufen := False;
      
      YAchseSchleife:
      for YAchseSchleifenwert in Karten.StadtkarteArray'Range (1) loop
         XAchseSchleife:
         for XAchseSchleifenwert in Karten.StadtkarteArray'Range (2) loop
                        
            if
              YAchseSchleifenwert < Karten.Stadtkarte'First (1) + 7
              and
                XAchseSchleifenwert > Karten.Stadtkarte'Last (2) - 7
            then               
               if
                 YAchsenabstraktion < -Stadtumgebungsgröße
                 or
                   YAchsenabstraktion > Stadtumgebungsgröße
               then
                  SchleifeFenster (YAchseExtern => YAchseSchleifenwert,
                                   XAchseExtern => XAchseSchleifenwert,
                                   RasseExtern  => StadtRasseNummerExtern.Rasse);
                  exit XAchseSchleife;

               elsif
                 Stadtumgebungsgröße = 1
                 and
                   YAchseSchleifenwert < 3
               then
                  SchleifeFenster (YAchseExtern => YAchseSchleifenwert,
                                   XAchseExtern => XAchseSchleifenwert,
                                   RasseExtern  => StadtRasseNummerExtern.Rasse);
                  exit XAchseSchleife;

               elsif
                 Stadtumgebungsgröße = 2
                 and
                   YAchseSchleifenwert < 2
               then
                  SchleifeFenster (YAchseExtern => YAchseSchleifenwert,
                                   XAchseExtern => XAchseSchleifenwert,
                                   RasseExtern  => StadtRasseNummerExtern.Rasse);
                  exit XAchseSchleife;               
                  
               else
                  AnzeigeStadtUmgebung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                        YAchseExtern           => YAchseSchleifenwert,
                                        XAchseExtern           => XAchseSchleifenwert);
                  exit XAchseSchleife;
               end if;
               
            elsif
              GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).AchsenPositionStadt = (YAchseSchleifenwert, XAchseSchleifenwert)
            then
               if
                 (YAchseSchleifenwert < Karten.Stadtkarte'First (1) + 7
                  and
                    XAchseSchleifenwert = Karten.Stadtkarte'Last (2) - 7)
                 or
                   (YAchseSchleifenwert = Karten.Stadtkarte'First (1) + 7
                    and
                      XAchseSchleifenwert >= Karten.Stadtkarte'Last (2) - 7)
               then
                  Sichtbarkeit.Farben (EinheitExtern      => 0,
                                       VerbesserungExtern => 0,
                                       RessourceExtern    => 0,
                                       GrundExtern        => 0,
                                       CursorExtern       => True,
                                       EigeneRasseExtern  => StadtRasseNummerExtern.Rasse,
                                       RasseExtern        => 0);

               else
                  Sichtbarkeit.Farben (EinheitExtern      => 0,
                                       VerbesserungExtern => 0,
                                       RessourceExtern    => 0,
                                       GrundExtern        => Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).AchsenPosition.EAchse,
                                         GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).AchsenPosition.YAchse,
                                         GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).AchsenPosition.XAchse).Grund,
                                       CursorExtern       => True,
                                       EigeneRasseExtern  => StadtRasseNummerExtern.Rasse,
                                       RasseExtern        => 0);

               end if;

            elsif
              YAchseSchleifenwert < Karten.Stadtkarte'First (1) + 7
              and
                XAchseSchleifenwert = Karten.Stadtkarte'Last (2) - 7
            then
               Put (Item => " ");

            elsif
              YAchseSchleifenwert = Karten.Stadtkarte'First (1) + 7
              and
                XAchseSchleifenwert >= Karten.Stadtkarte'Last (2) - 7
            then
               Put (Item => " ");

            elsif
              YAchseSchleifenwert = 1
              and
                XAchseSchleifenwert < 13
            then
               if
                 GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).GebäudeVorhanden (GlobaleDatentypen.GebäudeID (XAchseSchleifenwert)) = True
               then
                  Put (Item => GebaeudeDatenbank.GebäudeListe (StadtRasseNummerExtern.Rasse, GlobaleDatentypen.GebäudeID (XAchseSchleifenwert)).GebäudeGrafik);

               else
                  Sichtbarkeit.Farben (EinheitExtern      => 0,
                                       VerbesserungExtern => 0,
                                       RessourceExtern    => 0,
                                       GrundExtern        => Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).AchsenPosition.EAchse,
                                         GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).AchsenPosition.YAchse,
                                         GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).AchsenPosition.XAchse).Grund,
                                       CursorExtern       => False,
                                       EigeneRasseExtern  => StadtRasseNummerExtern.Rasse,
                                       RasseExtern        => 0);
               end if;

            elsif
              YAchseSchleifenwert = 2
              and
                XAchseSchleifenwert < 13
            then
               if
                 GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).GebäudeVorhanden (GlobaleDatentypen.GebäudeID (XAchseSchleifenwert) + 12) = True
               then
                  Put (Item => GebaeudeDatenbank.GebäudeListe (StadtRasseNummerExtern.Rasse, GlobaleDatentypen.GebäudeID (XAchseSchleifenwert) + 12).GebäudeGrafik);

               else
                  Sichtbarkeit.Farben (EinheitExtern      => 0,
                                       VerbesserungExtern => 0,
                                       RessourceExtern    => 0,
                                       GrundExtern        => Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).AchsenPosition.EAchse,
                                         GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).AchsenPosition.YAchse,
                                         GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).AchsenPosition.XAchse).Grund,
                                       CursorExtern       => False,
                                       EigeneRasseExtern  => StadtRasseNummerExtern.Rasse,
                                       RasseExtern        => 0);
               end if;

            else
               Sichtbarkeit.Farben (EinheitExtern      => 0,
                                    VerbesserungExtern => 0,
                                    RessourceExtern    => 0,
                                    GrundExtern        => Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).AchsenPosition.EAchse,
                                      GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).AchsenPosition.YAchse,
                                      GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).AchsenPosition.XAchse).Grund,
                                    CursorExtern       => False,
                                    EigeneRasseExtern  => StadtRasseNummerExtern.Rasse,
                                    RasseExtern        => 0);
            end if;

            case
              XAchseSchleifenwert
            is
               when Karten.Stadtkarte'Last (2) =>
                  New_Line;
                  
               when others =>
                  null;
            end case;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;

      Beschreibung (RasseExtern => StadtRasseNummerExtern.Rasse);

      case
        InformationenStadtAufrufen
      is
         when True =>
            InformationenStadt (StadtRasseNummerExtern => StadtRasseNummerExtern);

         when False =>
            null;
      end case;

      if
        GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).AchsenPositionStadt.YAchse = 1
        and
          GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).AchsenPositionStadt.XAchse < 13
      then
         if
           GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).GebäudeVorhanden
           (GlobaleDatentypen.GebäudeID (GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).AchsenPositionStadt.XAchse)) = True
         then
            GebaeudeDatenbank.Beschreibung (IDExtern => GlobaleDatentypen.GebäudeID (GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).AchsenPositionStadt.XAchse));
            
         else
            null;
         end if;

      elsif
        GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).AchsenPositionStadt.YAchse = 2
        and
          GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).AchsenPositionStadt.XAchse < 13
      then
         if
           GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).GebäudeVorhanden
           (GlobaleDatentypen.GebäudeID(GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).AchsenPositionStadt.XAchse) + 12) = True
         then
            GebaeudeDatenbank.Beschreibung (IDExtern => GlobaleDatentypen.GebäudeID (GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).AchsenPositionStadt.XAchse) + 12);
            
         else
            null;
         end if;
        
      else
         null;
      end if;

      New_Line;
      
   end AnzeigeStadt;



   procedure SchleifeFenster (YAchseExtern, XAchseExtern : in GlobaleDatentypen.Stadtfeld; RasseExtern : in GlobaleDatentypen.Rassen) is
   begin
      
      -- Hier muss nur von 0 .. 6 geloopt werden, da aber Stadtfeld nur von 1 .. 20 geht, wird eins weiter geloopt und im if eins abgezogen
      UmgebungSchleife:      
      for UmgebungSchleifenwert in KonstanterWertEins .. KonstanterWertSieben loop
                     
         if
           GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionStadt = (YAchseExtern, XAchseExtern + UmgebungSchleifenwert - 1)
         then
            Sichtbarkeit.Farben (EinheitExtern      => 0,
                                 VerbesserungExtern => 0,
                                 RessourceExtern    => 0,
                                 GrundExtern        => 0,
                                 CursorExtern       => True,
                                 EigeneRasseExtern  => RasseExtern,
                                 RasseExtern        => 0);

         else
            Put (Item => " ");
         end if;
                     
      end loop UmgebungSchleife;
      
      New_Line;
      
   end SchleifeFenster;



   procedure AnzeigeStadtUmgebung (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord; YAchseExtern, XAchseExtern : in GlobaleDatentypen.Stadtfeld) is
   begin
      
      UmgebungsSchleife:
      for UmgebungSchleifenwert in GlobaleDatentypen.LoopRangeMinusDreiZuDrei'Range loop

         Cursor := CursorKonstant + UmgebungSchleifenwert;
         if
           GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).AchsenPositionStadt = (YAchseExtern, XAchseExtern + Cursor)
         then
            if
              UmgebungSchleifenwert < -Stadtumgebungsgröße or UmgebungSchleifenwert > Stadtumgebungsgröße
            then
               Sichtbarkeit.Farben (EinheitExtern      => 0,
                                    VerbesserungExtern => 0,
                                    RessourceExtern    => 0,
                                    GrundExtern        => 0,
                                    CursorExtern       => True,
                                    EigeneRasseExtern  => StadtRasseNummerExtern.Rasse,
                                    RasseExtern        => 0);

            else
               CursorYAchseabstraktion := GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).AchsenPositionStadt.YAchse - 4;
               CursorXAchseabstraktion := GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).AchsenPositionStadt.XAchse - 17;

               KartenWert := KartenPruefungen.KartenPositionBestimmen (KoordinatenExtern    => GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).AchsenPosition,
                                                                       ÄnderungExtern       => (0, CursorYAchseabstraktion, CursorXAchseabstraktion),
                                                                       ZusatzYAbstandExtern => 0);

               case
                 KartenWert.Erfolgreich
               is
                  when False =>
                     Sichtbarkeit.Farben (EinheitExtern      => 0,
                                          VerbesserungExtern => 0,
                                          RessourceExtern    => 0,
                                          GrundExtern        => 0,
                                          CursorExtern       => True,
                                          EigeneRasseExtern  => StadtRasseNummerExtern.Rasse,
                                          RasseExtern        => 0);
                           
                  when True =>
                     Sichtbarkeit.Farben (EinheitExtern      => 0,
                                          VerbesserungExtern => 0,
                                          RessourceExtern    => 0,
                                          GrundExtern        => Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Grund,
                                          CursorExtern       => True,
                                          EigeneRasseExtern  => StadtRasseNummerExtern.Rasse,
                                          RasseExtern        => 0);
               end case;                        
               InformationenStadtAufrufen := True;
            end if;
                           
         elsif
           UmgebungSchleifenwert < -Stadtumgebungsgröße
           or
             UmgebungSchleifenwert > Stadtumgebungsgröße
         then
            Put (Item => " ");

         else
            KartenWert := KartenPruefungen.KartenPositionBestimmen (KoordinatenExtern    => GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).AchsenPosition,
                                                                    ÄnderungExtern       => (0, YAchsenabstraktion, UmgebungSchleifenwert),
                                                                    ZusatzYAbstandExtern => 0);

            case
              KartenWert.Erfolgreich
            is
               when False =>
                  Put (Item => " ");

               when True =>
                  Sichtbarkeit.Sichtbarkeit (InDerStadtExtern  => True,
                                             KoordinatenExtern => (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse),
                                             RasseExtern       => StadtRasseNummerExtern.Rasse);
            end case;
         end if;

      end loop UmgebungsSchleife;

      New_Line;
      YAchsenabstraktion := YAchsenabstraktion + 1;
      
   end AnzeigeStadtUmgebung;
   
   
   
   procedure InformationenStadt (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord) is
   begin
      
      Nahrungsgewinnung := 0;
      Ressourcengewinnung := 0;
      Geldgewinnung := 0;
      Wissensgewinnung := 0;

      CursorYAchseabstraktion := GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).AchsenPositionStadt.YAchse - 4;
      CursorXAchseabstraktion := GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).AchsenPositionStadt.XAchse - 17;

      KartenWert := KartenPruefungen.KartenPositionBestimmen (KoordinatenExtern    => GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).AchsenPosition,
                                                              ÄnderungExtern       => (0, CursorYAchseabstraktion, CursorXAchseabstraktion),
                                                              ZusatzYAbstandExtern => 0);

      case
        KartenWert.Erfolgreich
      is
         when False =>
            null;
         
         when True =>
            if
              Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Hügel = True
              and
                Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Grund /= 6
            then
               Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                              TextDateiExtern        => GlobaleDatentypen.Beschreibungen_Kartenfelder_Kurz,
                                              ÜberschriftZeileExtern => 0,
                                              ErsteZeileExtern       => 34,
                                              LetzteZeileExtern      => 34,
                                              AbstandAnfangExtern    => GlobaleDatentypen.Keiner,
                                              AbstandMitteExtern     => GlobaleDatentypen.Keiner,
                                              AbstandEndeExtern      => GlobaleDatentypen.Keiner);
               KartenDatenbank.Beschreibung (IDExtern => Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Grund);

               Nahrungsgewinnung := Nahrungsgewinnung + KartenDatenbank.KartenListe (Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Grund).Nahrungsgewinnung;
               Ressourcengewinnung := Ressourcengewinnung + KartenDatenbank.KartenListe (Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Grund).Ressourcengewinnung;
               Geldgewinnung := Geldgewinnung + KartenDatenbank.KartenListe (Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Grund).Geldgewinnung;
               Wissensgewinnung := Wissensgewinnung + KartenDatenbank.KartenListe (Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Grund).Wissensgewinnung;
         
            elsif
              Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Hügel = True
            then
               KartenDatenbank.Beschreibung (IDExtern => Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Grund);

               Nahrungsgewinnung := Nahrungsgewinnung + KartenDatenbank.KartenListe (Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Grund).Nahrungsgewinnung;
               Ressourcengewinnung := Ressourcengewinnung + KartenDatenbank.KartenListe (Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Grund).Ressourcengewinnung;
               Geldgewinnung := Geldgewinnung + KartenDatenbank.KartenListe (Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Grund).Geldgewinnung;
               Wissensgewinnung := Wissensgewinnung + KartenDatenbank.KartenListe (Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Grund).Wissensgewinnung;
               
            else         
               KartenDatenbank.Beschreibung (IDExtern => Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Grund);

               Nahrungsgewinnung := Nahrungsgewinnung + KartenDatenbank.KartenListe (Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Grund).Nahrungsgewinnung;
               Ressourcengewinnung := Ressourcengewinnung + KartenDatenbank.KartenListe (Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Grund).Ressourcengewinnung;
               Geldgewinnung := Geldgewinnung + KartenDatenbank.KartenListe (Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Grund).Geldgewinnung;
               Wissensgewinnung := Wissensgewinnung + KartenDatenbank.KartenListe (Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Grund).Wissensgewinnung;
            end if;
      
            if
              Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Ressource /= 0
            then
               KartenDatenbank.Beschreibung (IDExtern => Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Ressource);

               Nahrungsgewinnung := Nahrungsgewinnung + KartenDatenbank.KartenListe (Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Ressource).Nahrungsgewinnung;
               Ressourcengewinnung := Ressourcengewinnung + KartenDatenbank.KartenListe (Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Ressource).Ressourcengewinnung;
               Geldgewinnung := Geldgewinnung + KartenDatenbank.KartenListe (Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Ressource).Geldgewinnung;
               Wissensgewinnung := Wissensgewinnung + KartenDatenbank.KartenListe (Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Ressource).Wissensgewinnung;
         
            else
               null;
            end if;
      
            if
              Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungGebiet /= 0
            then
               VerbesserungenDatenbank.Beschreibung (IDExtern => Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungGebiet);

               Nahrungsgewinnung := Nahrungsgewinnung + VerbesserungenDatenbank.VerbesserungListe (Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungGebiet).Nahrungsbonus;
               Ressourcengewinnung := Ressourcengewinnung + VerbesserungenDatenbank.VerbesserungListe (Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungGebiet).Ressourcenbonus;
               Geldgewinnung := Geldgewinnung + VerbesserungenDatenbank.VerbesserungListe (Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungGebiet).Geldbonus;
               Wissensgewinnung := Wissensgewinnung + VerbesserungenDatenbank.VerbesserungListe (Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungGebiet).Wissensbonus;
         
            else
               null;
            end if;
      
            if
              Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße /= 0
            then
               VerbesserungenDatenbank.Beschreibung (IDExtern => Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße);

               Nahrungsgewinnung := Nahrungsgewinnung + VerbesserungenDatenbank.VerbesserungListe (Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße).Nahrungsbonus;
               Ressourcengewinnung := Ressourcengewinnung + VerbesserungenDatenbank.VerbesserungListe (Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße).Ressourcenbonus;
               Geldgewinnung := Geldgewinnung + VerbesserungenDatenbank.VerbesserungListe (Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße).Geldbonus;
               Wissensgewinnung := Wissensgewinnung + VerbesserungenDatenbank.VerbesserungListe (Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).VerbesserungStraße).Wissensbonus;
         
            else
               null;
            end if;
      
            if
              Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss /= 0
            then
               KartenDatenbank.Beschreibung (IDExtern => Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss);

               Nahrungsgewinnung := Nahrungsgewinnung + KartenDatenbank.KartenListe (Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss).Nahrungsgewinnung;
               Ressourcengewinnung := Ressourcengewinnung + KartenDatenbank.KartenListe (Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss).Ressourcengewinnung;
               Geldgewinnung := Geldgewinnung + KartenDatenbank.KartenListe (Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss).Geldgewinnung;
               Wissensgewinnung := Wissensgewinnung + KartenDatenbank.KartenListe (Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Fluss).Wissensgewinnung;
         
            else
               null;
            end if;
            New_Line;
         
            Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                           TextDateiExtern        => GlobaleDatentypen.Zeug,
                                           ÜberschriftZeileExtern => 0,
                                           ErsteZeileExtern       => 20,
                                           LetzteZeileExtern      => 20,
                                           AbstandAnfangExtern    => GlobaleDatentypen.Großer_Abstand,
                                           AbstandMitteExtern     => GlobaleDatentypen.Keiner,
                                           AbstandEndeExtern      => GlobaleDatentypen.Kleiner_Abstand);
            Ada.Integer_Text_IO.Put (Item  => Integer (Nahrungsgewinnung),
                                     Width => 1);
         
            Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                           TextDateiExtern        => GlobaleDatentypen.Zeug,
                                           ÜberschriftZeileExtern => 0,
                                           ErsteZeileExtern       => 21,
                                           LetzteZeileExtern      => 21,
                                           AbstandAnfangExtern    => GlobaleDatentypen.Großer_Abstand,
                                           AbstandMitteExtern     => GlobaleDatentypen.Keiner,
                                           AbstandEndeExtern      => GlobaleDatentypen.Kleiner_Abstand);
            Ada.Integer_Text_IO.Put (Item  => Integer (Ressourcengewinnung),
                                     Width => 1);
            New_Line;
         
            Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                           TextDateiExtern        => GlobaleDatentypen.Zeug,
                                           ÜberschriftZeileExtern => 0,
                                           ErsteZeileExtern       => 22,
                                           LetzteZeileExtern      => 22,
                                           AbstandAnfangExtern    => GlobaleDatentypen.Großer_Abstand,
                                           AbstandMitteExtern     => GlobaleDatentypen.Keiner,
                                           AbstandEndeExtern      => GlobaleDatentypen.Kleiner_Abstand);
            Ada.Integer_Text_IO.Put (Item  => Integer (Geldgewinnung),
                                     Width => 1);
         
            Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                           TextDateiExtern        => GlobaleDatentypen.Zeug,
                                           ÜberschriftZeileExtern => 0,
                                           ErsteZeileExtern       => 23,
                                           LetzteZeileExtern      => 23,
                                           AbstandAnfangExtern    => GlobaleDatentypen.Großer_Abstand,
                                           AbstandMitteExtern     => GlobaleDatentypen.Keiner,
                                           AbstandEndeExtern      => GlobaleDatentypen.Kleiner_Abstand);
            Ada.Integer_Text_IO.Put (Item  => Integer (Wissensgewinnung),
                                     Width => 1);
            New_Line;            

            Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                           TextDateiExtern        => GlobaleDatentypen.Zeug,
                                           ÜberschriftZeileExtern => 0,
                                           ErsteZeileExtern       => 42,
                                           LetzteZeileExtern      => 42,
                                           AbstandAnfangExtern    => GlobaleDatentypen.Großer_Abstand,
                                           AbstandMitteExtern     => GlobaleDatentypen.Keiner,
                                           AbstandEndeExtern      => GlobaleDatentypen.Kleiner_Abstand);
            FeldBelegt := GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).UmgebungBewirtschaftung (CursorYAchseabstraktion, CursorXAchseabstraktion);
            case
              FeldBelegt
            is
               when True =>
                  Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleDatentypen.Menü_Auswahl,
                                                        TextZeileExtern => 10);
               
               when False =>
                  Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleDatentypen.Menü_Auswahl,
                                                        TextZeileExtern => 11);
            end case;
      end case;
      
   end InformationenStadt;
   
   

   procedure Beschreibung (RasseExtern : in GlobaleDatentypen.Rassen) is
   begin

      RasseUndPlatznummer := StadtSuchen.KoordinatenStadtOhneRasseSuchen (KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition);

      case
        RasseUndPlatznummer.Platznummer
      is
         when GlobaleKonstanten.RückgabeEinheitStadtNummerFalsch =>
            null; -- Sollte nie eintreten, da entweder aus der Stadt aufgerufen oder nur wenn die Kartenprüfung bereits eine Stadt gefunden hat
      
         when others =>
            -- Allgemeine Stadtinformationen, nur sichtbar wenn das Kartenfeld aufgedackt ist und sich dort eine Stadt befindet
            case
              GlobaleVariablen.StadtGebaut (RasseUndPlatznummer.Rasse, RasseUndPlatznummer.Platznummer).ID
            is
               when 1 =>
                  if
                    RasseExtern = RasseUndPlatznummer.Rasse
                  then
                     Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                                    TextDateiExtern        => GlobaleDatentypen.Zeug,
                                                    ÜberschriftZeileExtern => 0,
                                                    ErsteZeileExtern       => 1,
                                                    LetzteZeileExtern      => 1,
                                                    AbstandAnfangExtern    => GlobaleDatentypen.Keiner,
                                                    AbstandMitteExtern     => GlobaleDatentypen.Keiner,
                                                    AbstandEndeExtern      => GlobaleDatentypen.Kleiner_Abstand);

                  else
                     Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                                    TextDateiExtern        => GlobaleDatentypen.Zeug,
                                                    ÜberschriftZeileExtern => 0,
                                                    ErsteZeileExtern       => 3,
                                                    LetzteZeileExtern      => 3,
                                                    AbstandAnfangExtern    => GlobaleDatentypen.Keiner,
                                                    AbstandMitteExtern     => GlobaleDatentypen.Keiner,
                                                    AbstandEndeExtern      => GlobaleDatentypen.Kleiner_Abstand);
                  end if;
                  
               when 2 =>
                  if
                    RasseExtern = RasseUndPlatznummer.Rasse
                  then
                     Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                                    TextDateiExtern        => GlobaleDatentypen.Zeug,
                                                    ÜberschriftZeileExtern => 0,
                                                    ErsteZeileExtern       => 2,
                                                    LetzteZeileExtern      => 2,
                                                    AbstandAnfangExtern    => GlobaleDatentypen.Keiner,
                                                    AbstandMitteExtern     => GlobaleDatentypen.Keiner,
                                                    AbstandEndeExtern      => GlobaleDatentypen.Kleiner_Abstand);
                        
                  else
                     Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                                    TextDateiExtern        => GlobaleDatentypen.Zeug,
                                                    ÜberschriftZeileExtern => 0,
                                                    ErsteZeileExtern       => 4,
                                                    LetzteZeileExtern      => 4,
                                                    AbstandAnfangExtern    => GlobaleDatentypen.Keiner,
                                                    AbstandMitteExtern     => GlobaleDatentypen.Keiner,
                                                    AbstandEndeExtern      => GlobaleDatentypen.Kleiner_Abstand);
                  end if;

               when 0 =>
                  null;
            end case;
            Put_Line (Item => To_Wide_Wide_String (Source => GlobaleVariablen.StadtGebaut (RasseUndPlatznummer.Rasse, RasseUndPlatznummer.Platznummer).Name));

            Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                           TextDateiExtern        => GlobaleDatentypen.Zeug,
                                           ÜberschriftZeileExtern => 0,
                                           ErsteZeileExtern       => 5,
                                           LetzteZeileExtern      => 5,
                                           AbstandAnfangExtern    => GlobaleDatentypen.Großer_Abstand,
                                           AbstandMitteExtern     => GlobaleDatentypen.Keiner,
                                           AbstandEndeExtern      => GlobaleDatentypen.Kleiner_Abstand);
            Ada.Integer_Text_IO.Put (Item  => Integer (GlobaleVariablen.StadtGebaut (RasseUndPlatznummer.Rasse, RasseUndPlatznummer.Platznummer).Einwohner),
                                     Width => 1);

            -- "Volle" Stadtinformationen, nur sichtbar wenn eigene Stadt oder wenn Cheat aktiviert ist                      
            if
              RasseUndPlatznummer.Rasse = RasseExtern
              or
                GlobaleVariablen.FeindlicheInformationenSehen = True
            then
               Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                              TextDateiExtern        => GlobaleDatentypen.Zeug,
                                              ÜberschriftZeileExtern => 0,
                                              ErsteZeileExtern       => 6,
                                              LetzteZeileExtern      => 6,
                                              AbstandAnfangExtern    => GlobaleDatentypen.Großer_Abstand,
                                              AbstandMitteExtern     => GlobaleDatentypen.Keiner,
                                              AbstandEndeExtern      => GlobaleDatentypen.Kleiner_Abstand);
               Ada.Integer_Text_IO.Put (Item  => Integer (GlobaleVariablen.StadtGebaut (RasseUndPlatznummer.Rasse, RasseUndPlatznummer.Platznummer).AktuelleNahrungsmittel),
                                        Width => 1);

               Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                              TextDateiExtern        => GlobaleDatentypen.Zeug,
                                              ÜberschriftZeileExtern => 0,
                                              ErsteZeileExtern       => 7,
                                              LetzteZeileExtern      => 7,
                                              AbstandAnfangExtern    => GlobaleDatentypen.Großer_Abstand,
                                              AbstandMitteExtern     => GlobaleDatentypen.Keiner,
                                              AbstandEndeExtern      => GlobaleDatentypen.Kleiner_Abstand);
               Ada.Integer_Text_IO.Put (Item  => Integer (GlobaleVariablen.StadtGebaut (RasseUndPlatznummer.Rasse, RasseUndPlatznummer.Platznummer).AktuelleNahrungsproduktion),
                                        Width => 1);
               New_Line;
                        
               Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                              TextDateiExtern        => GlobaleDatentypen.Zeug,
                                              ÜberschriftZeileExtern => 0,
                                              ErsteZeileExtern       => 8,
                                              LetzteZeileExtern      => 8,
                                              AbstandAnfangExtern    => GlobaleDatentypen.Großer_Abstand,
                                              AbstandMitteExtern     => GlobaleDatentypen.Keiner,
                                              AbstandEndeExtern      => GlobaleDatentypen.Kleiner_Abstand);
               Ada.Integer_Text_IO.Put (Item  => Integer (GlobaleVariablen.StadtGebaut (RasseUndPlatznummer.Rasse, RasseUndPlatznummer.Platznummer).AktuelleProduktionrate),
                                        Width => 1);

               Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                              TextDateiExtern        => GlobaleDatentypen.Zeug,
                                              ÜberschriftZeileExtern => 0,
                                              ErsteZeileExtern       => 9,
                                              LetzteZeileExtern      => 9,
                                              AbstandAnfangExtern    => GlobaleDatentypen.Großer_Abstand,
                                              AbstandMitteExtern     => GlobaleDatentypen.Keiner,
                                              AbstandEndeExtern      => GlobaleDatentypen.Kleiner_Abstand);
               Ada.Integer_Text_IO.Put (Item  => Integer (GlobaleVariablen.StadtGebaut (RasseUndPlatznummer.Rasse, RasseUndPlatznummer.Platznummer).AktuelleGeldgewinnung),
                                        Width => 1);

               Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                              TextDateiExtern        => GlobaleDatentypen.Zeug,
                                              ÜberschriftZeileExtern => 0,
                                              ErsteZeileExtern       => 10,
                                              LetzteZeileExtern      => 10,
                                              AbstandAnfangExtern    => GlobaleDatentypen.Großer_Abstand,
                                              AbstandMitteExtern     => GlobaleDatentypen.Keiner,
                                              AbstandEndeExtern      => GlobaleDatentypen.Kleiner_Abstand);
               Ada.Integer_Text_IO.Put (Item  => Integer (GlobaleVariablen.StadtGebaut (RasseUndPlatznummer.Rasse, RasseUndPlatznummer.Platznummer).AktuelleForschungsrate),
                                        Width => 1);
               New_Line;

               Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                              TextDateiExtern        => GlobaleDatentypen.Zeug,
                                              ÜberschriftZeileExtern => 0,
                                              ErsteZeileExtern       => 11,
                                              LetzteZeileExtern      => 11,
                                              AbstandAnfangExtern    => GlobaleDatentypen.Großer_Abstand,
                                              AbstandMitteExtern     => GlobaleDatentypen.Keiner,
                                              AbstandEndeExtern      => GlobaleDatentypen.Kleiner_Abstand);
               Ada.Integer_Text_IO.Put (Item  => Integer (GlobaleVariablen.StadtGebaut (RasseUndPlatznummer.Rasse, RasseUndPlatznummer.Platznummer).Korruption),
                                        Width => 1);

               Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                              TextDateiExtern        => GlobaleDatentypen.Zeug,
                                              ÜberschriftZeileExtern => 0,
                                              ErsteZeileExtern       => 41,
                                              LetzteZeileExtern      => 41,
                                              AbstandAnfangExtern    => GlobaleDatentypen.Großer_Abstand,
                                              AbstandMitteExtern     => GlobaleDatentypen.Keiner,
                                              AbstandEndeExtern      => GlobaleDatentypen.Kleiner_Abstand);
               Ada.Integer_Text_IO.Put (Item  => Integer (GlobaleVariablen.StadtGebaut (RasseUndPlatznummer.Rasse, RasseUndPlatznummer.Platznummer).Einwohner
                                        - GlobaleVariablen.StadtGebaut (RasseUndPlatznummer.Rasse, RasseUndPlatznummer.Platznummer).ArbeitendeEinwohner),
                                        Width => 1);

               New_Line;
               
               Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                              TextDateiExtern        => GlobaleDatentypen.Zeug,
                                              ÜberschriftZeileExtern => 0,
                                              ErsteZeileExtern       => 12,
                                              LetzteZeileExtern      => 12,
                                              AbstandAnfangExtern    => GlobaleDatentypen.Großer_Abstand,
                                              AbstandMitteExtern     => GlobaleDatentypen.Keiner,
                                              AbstandEndeExtern      => GlobaleDatentypen.Kleiner_Abstand);
               case
                 GlobaleVariablen.StadtGebaut (RasseUndPlatznummer.Rasse, RasseUndPlatznummer.Platznummer).AktuellesBauprojekt
               is
                  when 0 => -- Nichts                     
                     Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                                    TextDateiExtern        => GlobaleDatentypen.Zeug,
                                                    ÜberschriftZeileExtern => 0,
                                                    ErsteZeileExtern       => 28,
                                                    LetzteZeileExtern      => 28,
                                                    AbstandAnfangExtern    => GlobaleDatentypen.Keiner,
                                                    AbstandMitteExtern     => GlobaleDatentypen.Keiner,
                                                    AbstandEndeExtern      => GlobaleDatentypen.Keiner);
            
                  when 1 .. 9_999 => -- Gebäude
                     Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                                    TextDateiExtern        => GlobaleDatentypen.Beschreibungen_Gebäude_Kurz,
                                                    ÜberschriftZeileExtern => 0,
                                                    ErsteZeileExtern       => GlobaleVariablen.StadtGebaut (RasseUndPlatznummer.Rasse, RasseUndPlatznummer.Platznummer).AktuellesBauprojekt - 1_000,
                                                    LetzteZeileExtern      => GlobaleVariablen.StadtGebaut (RasseUndPlatznummer.Rasse, RasseUndPlatznummer.Platznummer).AktuellesBauprojekt - 1_000,
                                                    AbstandAnfangExtern    => GlobaleDatentypen.Keiner,
                                                    AbstandMitteExtern     => GlobaleDatentypen.Keiner,
                                                    AbstandEndeExtern      => GlobaleDatentypen.Keiner);

                  when others => -- Einheiten
                     Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                                    TextDateiExtern        => GlobaleDatentypen.Beschreibungen_Einheiten_Kurz,
                                                    ÜberschriftZeileExtern => 0,
                                                    ErsteZeileExtern       => GlobaleVariablen.StadtGebaut (RasseUndPlatznummer.Rasse, RasseUndPlatznummer.Platznummer).AktuellesBauprojekt - 10_000,
                                                    LetzteZeileExtern      => GlobaleVariablen.StadtGebaut (RasseUndPlatznummer.Rasse, RasseUndPlatznummer.Platznummer).AktuellesBauprojekt - 10_000,
                                                    AbstandAnfangExtern    => GlobaleDatentypen.Keiner,
                                                    AbstandMitteExtern     => GlobaleDatentypen.Keiner,
                                                    AbstandEndeExtern      => GlobaleDatentypen.Keiner);
               end case;
                                              
               Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                              TextDateiExtern        => GlobaleDatentypen.Zeug,
                                              ÜberschriftZeileExtern => 0,
                                              ErsteZeileExtern       => 13,
                                              LetzteZeileExtern      => 13,
                                              AbstandAnfangExtern    => GlobaleDatentypen.Großer_Abstand,
                                              AbstandMitteExtern     => GlobaleDatentypen.Keiner,
                                              AbstandEndeExtern      => GlobaleDatentypen.Kleiner_Abstand);
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
