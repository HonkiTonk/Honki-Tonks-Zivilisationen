pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO, Ada.Characters.Wide_Wide_Latin_9;
use Ada.Wide_Wide_Text_IO, Ada.Characters.Wide_Wide_Latin_9;

with GlobaleKonstanten, GlobaleTexte;

with GebaeudeDatenbank;
  
with KartePositionPruefen, StadtSuchen, Karten, StadtInformationen, Anzeige, GebaeudeAllgemein, KartenAllgemein, GrafischeAnzeige;

package body KarteStadt is

   procedure AnzeigeStadt
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      Put (Item => CSI & "2J" & CSI & "3J" & CSI & "H");

      Stadtumgebungsgröße := GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).UmgebungGröße;

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
              GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).PositionStadt = (YAchseSchleifenwert, XAchseSchleifenwert)
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
                  GrafischeAnzeige.Farben (EinheitExtern      => 0,
                                           VerbesserungExtern => GlobaleDatentypen.Leer,
                                           RessourceExtern    => GlobaleDatentypen.Leer,
                                           GrundExtern        => GlobaleDatentypen.Leer,
                                           CursorExtern       => True,
                                           EigeneRasseExtern  => StadtRasseNummerExtern.Rasse,
                                           RasseExtern        => GlobaleDatentypen.Leer);

               else
                  GrafischeAnzeige.Farben (EinheitExtern      => 0,
                                           VerbesserungExtern => GlobaleDatentypen.Leer,
                                           RessourceExtern    => GlobaleDatentypen.Leer,
                                           GrundExtern        => Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).Position.EAchse,
                                             GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).Position.YAchse,
                                             GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).Position.XAchse).Grund,
                                           CursorExtern       => True,
                                           EigeneRasseExtern  => StadtRasseNummerExtern.Rasse,
                                           RasseExtern        => GlobaleDatentypen.Leer);

               end if;

            elsif
              YAchseSchleifenwert < Karten.Stadtkarte'First (1) + 7
              and
                XAchseSchleifenwert = Karten.Stadtkarte'Last (2) - 7
            then
               Put (Item => GlobaleKonstanten.NichtSichtbar);

            elsif
              YAchseSchleifenwert = Karten.Stadtkarte'First (1) + 7
              and
                XAchseSchleifenwert >= Karten.Stadtkarte'Last (2) - 7
            then
               Put (Item => GlobaleKonstanten.NichtSichtbar);

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
                  GrafischeAnzeige.Farben (EinheitExtern      => 0,
                                           VerbesserungExtern => GlobaleDatentypen.Leer,
                                           RessourceExtern    => GlobaleDatentypen.Leer,
                                           GrundExtern        => Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).Position.EAchse,
                                             GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).Position.YAchse,
                                             GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).Position.XAchse).Grund,
                                           CursorExtern       => False,
                                           EigeneRasseExtern  => StadtRasseNummerExtern.Rasse,
                                           RasseExtern        => GlobaleDatentypen.Leer);
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
                  GrafischeAnzeige.Farben (EinheitExtern      => 0,
                                           VerbesserungExtern => GlobaleDatentypen.Leer,
                                           RessourceExtern    => GlobaleDatentypen.Leer,
                                           GrundExtern        => Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).Position.EAchse,
                                             GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).Position.YAchse,
                                             GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).Position.XAchse).Grund,
                                           CursorExtern       => False,
                                           EigeneRasseExtern  => StadtRasseNummerExtern.Rasse,
                                           RasseExtern        => GlobaleDatentypen.Leer);
               end if;

            else
               GrafischeAnzeige.Farben (EinheitExtern      => 0,
                                        VerbesserungExtern => GlobaleDatentypen.Leer,
                                        RessourceExtern    => GlobaleDatentypen.Leer,
                                        GrundExtern        => Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).Position.EAchse,
                                          GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).Position.YAchse,
                                          GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).Position.XAchse).Grund,
                                        CursorExtern       => False,
                                        EigeneRasseExtern  => StadtRasseNummerExtern.Rasse,
                                        RasseExtern        => GlobaleDatentypen.Leer);
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
        (GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).PositionStadt.YAchse = 1
         or
           GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).PositionStadt.YAchse = 2)
         and
           GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).PositionStadt.XAchse < 13
      then
         Aufschlag := GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).PositionStadt.YAchse;
         
      else
         Aufschlag := 0;
      end if;
      
      case
        Aufschlag
      is
         when 0 =>
            null;
            
         when others =>
            Aufschlag := Aufschlag - 1;
            if
              GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).GebäudeVorhanden
              (GlobaleDatentypen.GebäudeID (GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).PositionStadt.XAchse + Aufschlag * 12)) = True
            then
               GebaeudeAllgemein.Beschreibung (IDExtern => GlobaleDatentypen.GebäudeID (GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).PositionStadt.XAchse + Aufschlag * 12));
            
            else
               null;
            end if;
      end case;

      New_Line;
      
   end AnzeigeStadt;



   procedure SchleifeFenster
     (YAchseExtern, XAchseExtern : in GlobaleDatentypen.Stadtfeld;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      -- Hier muss nur von 0 .. 6 geloopt werden, da aber Stadtfeld nur von 1 .. 20 geht, wird eins weiter geloopt und im if eins abgezogen
      UmgebungSchleife:      
      for UmgebungSchleifenwert in KonstanterWertEins .. KonstanterWertSieben loop
                     
         if
           GlobaleVariablen.CursorImSpiel (RasseExtern).PositionStadt = (YAchseExtern, XAchseExtern + UmgebungSchleifenwert - 1)
         then
            GrafischeAnzeige.Farben (EinheitExtern      => 0,
                                     VerbesserungExtern => GlobaleDatentypen.Leer,
                                     RessourceExtern    => GlobaleDatentypen.Leer,
                                     GrundExtern        => GlobaleDatentypen.Leer,
                                     CursorExtern       => True,
                                     EigeneRasseExtern  => RasseExtern,
                                     RasseExtern        => GlobaleDatentypen.Leer);

         else
            Put (Item => GlobaleKonstanten.NichtSichtbar);
         end if;
                     
      end loop UmgebungSchleife;
      
      New_Line;
      
   end SchleifeFenster;



   procedure AnzeigeStadtUmgebung
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      YAchseExtern, XAchseExtern : in GlobaleDatentypen.Stadtfeld)
   is begin
      
      UmgebungsSchleife:
      for UmgebungSchleifenwert in GlobaleDatentypen.LoopRangeMinusDreiZuDrei'Range loop

         Cursor := CursorKonstant + UmgebungSchleifenwert;
         if
           GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).PositionStadt = (YAchseExtern, XAchseExtern + Cursor)
         then
            if
              UmgebungSchleifenwert < -Stadtumgebungsgröße or UmgebungSchleifenwert > Stadtumgebungsgröße
            then
               GrafischeAnzeige.Farben (EinheitExtern      => 0,
                                        VerbesserungExtern => GlobaleDatentypen.Leer,
                                        RessourceExtern    => GlobaleDatentypen.Leer,
                                        GrundExtern        => GlobaleDatentypen.Leer,
                                        CursorExtern       => True,
                                        EigeneRasseExtern  => StadtRasseNummerExtern.Rasse,
                                        RasseExtern        => GlobaleDatentypen.Leer);

            else
               CursorYAchseabstraktion := GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).PositionStadt.YAchse - 4;
               CursorXAchseabstraktion := GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).PositionStadt.XAchse - 17;
               
               KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern    => GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).Position,
                                                                           ÄnderungExtern       => (0, CursorYAchseabstraktion, CursorXAchseabstraktion));
               case
                 KartenWert.XAchse
               is
                  when GlobaleKonstanten.LeerYXKartenWert =>
                     GrafischeAnzeige.Farben (EinheitExtern      => 0,
                                              VerbesserungExtern => GlobaleDatentypen.Leer,
                                              RessourceExtern    => GlobaleDatentypen.Leer,
                                              GrundExtern        => GlobaleDatentypen.Leer,
                                              CursorExtern       => True,
                                              EigeneRasseExtern  => StadtRasseNummerExtern.Rasse,
                                              RasseExtern        => GlobaleDatentypen.Leer);

                  when others =>
                     GrafischeAnzeige.Farben (EinheitExtern      => 0,
                                              VerbesserungExtern => GlobaleDatentypen.Leer,
                                              RessourceExtern    => GlobaleDatentypen.Leer,
                                              GrundExtern        => Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Grund,
                                              CursorExtern       => True,
                                              EigeneRasseExtern  => StadtRasseNummerExtern.Rasse,
                                              RasseExtern        => GlobaleDatentypen.Leer);
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
            KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern    => GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).Position,
                                                                        ÄnderungExtern       => (0, YAchsenabstraktion, UmgebungSchleifenwert));
            
            case
              KartenWert.XAchse
            is
               when GlobaleKonstanten.LeerYXKartenWert =>
                  Put (Item => " ");

               when others =>
                  GrafischeAnzeige.Sichtbarkeit (InDerStadtExtern  => True,
                                                 KoordinatenExtern => (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse),
                                                 RasseExtern       => StadtRasseNummerExtern.Rasse);
            end case;
         end if;

      end loop UmgebungsSchleife;

      New_Line;
      YAchsenabstraktion := YAchsenabstraktion + 1;
      
   end AnzeigeStadtUmgebung;
   
   
   
   procedure InformationenStadt
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin

      CursorYAchseabstraktion := GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).PositionStadt.YAchse - 4;
      CursorXAchseabstraktion := GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).PositionStadt.XAchse - 17;
      
      KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern    => GlobaleVariablen.CursorImSpiel (StadtRasseNummerExtern.Rasse).Position,
                                                                  ÄnderungExtern       => (0, CursorYAchseabstraktion, CursorXAchseabstraktion));
      
      case
        KartenWert.XAchse
      is
         when GlobaleKonstanten.LeerYXKartenWert =>
            return;

         when others =>
            null;
      end case;
      
      if
        Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Hügel = True
        and
          Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Grund /= GlobaleDatentypen.Hügel
      then
         Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleTexte.Leer,
                                        TextDateiExtern        => GlobaleTexte.Beschreibungen_Kartenfelder_Kurz,
                                        ÜberschriftZeileExtern => 0,
                                        ErsteZeileExtern       => 34,
                                        LetzteZeileExtern      => 34,
                                        AbstandAnfangExtern    => GlobaleTexte.Leer,
                                        AbstandMitteExtern     => GlobaleTexte.Leer,
                                        AbstandEndeExtern      => GlobaleTexte.Leer);
         KartenAllgemein.Beschreibung (KartenGrundExtern => Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Grund);
         
      elsif
        Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Hügel = True
      then
         KartenAllgemein.Beschreibung (KartenGrundExtern => Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Grund);
               
      else         
         KartenAllgemein.Beschreibung (KartenGrundExtern => Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).Grund);
      end if;
      
      StadtInformationen.EinzelnesFeldNahrungsgewinnung (KoordinatenExtern => KartenWert);
      StadtInformationen.EinzelnesFeldRessourcengewinnung (KoordinatenExtern => KartenWert);
      StadtInformationen.EinzelnesFeldGeldgewinnung (KoordinatenExtern => KartenWert);
      StadtInformationen.EinzelnesFeldWissensgewinnung (KoordinatenExtern => KartenWert);
      StadtInformationen.StadtfeldBewirtschaftet (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                  CursorYAchseabstraktionExtern => CursorYAchseabstraktion,
                                                  CursorXAchseabstraktionExtern => CursorXAchseabstraktion);
      
   end InformationenStadt;
   
   

   procedure Beschreibung
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
   is begin

      StadtRasseNummer := StadtSuchen.KoordinatenStadtOhneRasseSuchen (KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).Position);

      case
        StadtRasseNummer.Platznummer
      is
         when GlobaleKonstanten.LeerEinheitStadtNummer =>
            -- Sollte nie eintreten, da entweder aus der Stadt aufgerufen oder nur wenn die Kartenprüfung bereits eine Stadt gefunden hat. Kann entfernt werden?
            return;
      
         when others =>
            null;
      end case;
      
      -- Allgemeine Stadtinformationen, nur sichtbar wenn das Kartenfeld aufgedeckt ist und sich dort eine Stadt befindet
      StadtInformationen.StadtArtBesitzer (RasseExtern               => RasseExtern,
                                           StadtRasseNummerExtern => StadtRasseNummer);
      StadtInformationen.StadtName (StadtRasseNummerExtern => StadtRasseNummer);
      StadtInformationen.Einwohner (StadtRasseNummerExtern => StadtRasseNummer);      

      -- "Volle" Stadtinformationen, nur sichtbar wenn eigene Stadt oder wenn Cheat aktiviert ist                      
      if
        StadtRasseNummer.Rasse = RasseExtern
        or
          GlobaleVariablen.FeindlicheInformationenSehen
      then
         
         StadtInformationen.AktuelleNahrungsmittel (StadtRasseNummerExtern => StadtRasseNummer);
         StadtInformationen.AktuelleNahrungsproduktion (StadtRasseNummerExtern => StadtRasseNummer);         
         New_Line;
                        
         StadtInformationen.AktuelleProduktionrate (StadtRasseNummerExtern => StadtRasseNummer);
         StadtInformationen.AktuelleGeldgewinnung (StadtRasseNummerExtern => StadtRasseNummer);
         StadtInformationen.AktuelleForschungsrate (StadtRasseNummerExtern => StadtRasseNummer);         
         New_Line;

         StadtInformationen.Korruption (StadtRasseNummerExtern => StadtRasseNummer);
         StadtInformationen.EinwohnerOhneArbeit (StadtRasseNummerExtern => StadtRasseNummer);
         New_Line;
               
         StadtInformationen.AktuellesBauprojekt (StadtRasseNummerExtern => StadtRasseNummer);

      else
         null;
      end if;   
      New_Line;
      
   end Beschreibung;

end KarteStadt;
