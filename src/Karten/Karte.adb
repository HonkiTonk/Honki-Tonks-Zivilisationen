pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO, Ada.Float_Text_IO, Ada.Characters.Wide_Wide_Latin_9, Ada.Integer_Text_IO;
use Ada.Wide_Wide_Text_IO, Ada.Characters.Wide_Wide_Latin_9;

with GlobaleKonstanten;

with KarteStadt, KartenDatenbank, Karten, EinheitenDatenbank, VerbesserungenDatenbank, ForschungsDatenbank, Sichtbarkeit, KartenPruefungen, EinheitSuchen, StadtSuchen, Anzeige;

package body Karte is

   procedure AnzeigeKarte
     (RasseExtern : in GlobaleDatentypen.Rassen)
   is begin
      
      case
        Karten.Kartengröße
      is
         when 1 =>
            SichtweiteFestlegen := 1;
            BewegungsfeldFestlegen := 1;
            
         when 2 =>
            SichtweiteFestlegen := 2;
            BewegungsfeldFestlegen := 2;

         when Karten.KartengrößenArray'Last =>
            if
              Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße <= Karten.Kartengrößen (1).YAchsenGröße
              or
                Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße <= Karten.Kartengrößen (1).XAchsenGröße
            then
               SichtweiteFestlegen := 1;
               BewegungsfeldFestlegen := 1;
               
            elsif
              Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße <= Karten.Kartengrößen (2).YAchsenGröße
              or
                Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße <= Karten.Kartengrößen (2).XAchsenGröße
            then
               SichtweiteFestlegen := 2;
               BewegungsfeldFestlegen := 2;
               
            else
               SichtweiteFestlegen := 3;
               BewegungsfeldFestlegen := 3; 
            end if;
            
         when others =>
            SichtweiteFestlegen := 3;
            BewegungsfeldFestlegen := 3;            
      end case;
      
      if
        GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionAlt.EAchse = GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse
      then
         null;
            
      else
         GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionAlt.EAchse := GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse;
      end if;

      if
        GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse > GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionAlt.YAchse + Bewegungsfeld (BewegungsfeldFestlegen).YAchse
        or
          GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse < GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionAlt.YAchse - Bewegungsfeld (BewegungsfeldFestlegen).YAchse
      then
         GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionAlt.YAchse := GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse;
         
      else
         null;
      end if;
            
      if
        GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionAlt.XAchse + Bewegungsfeld (BewegungsfeldFestlegen).XAchse > Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
      then
         if
           GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse < GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionAlt.XAchse - Bewegungsfeld (BewegungsfeldFestlegen).XAchse
           and
             GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse > GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionAlt.XAchse + Bewegungsfeld (BewegungsfeldFestlegen).XAchse
           - Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
         then
            GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionAlt.XAchse := GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse;         
            
         else
            null;
         end if;
         
      elsif
        GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionAlt.XAchse - Bewegungsfeld (BewegungsfeldFestlegen).XAchse < Karten.WeltkarteArray'First (3)
      then
         if
           GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse > GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionAlt.XAchse + Bewegungsfeld (BewegungsfeldFestlegen).XAchse
           and
             GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse < GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionAlt.XAchse - Bewegungsfeld (BewegungsfeldFestlegen).XAchse
           + Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
         then
            GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionAlt.XAchse := GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse;         
            
         else
            null;
         end if;
         
      else
         if
           GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse > GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionAlt.XAchse + Bewegungsfeld (BewegungsfeldFestlegen).XAchse
           or
             GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse < GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionAlt.XAchse - Bewegungsfeld (BewegungsfeldFestlegen).XAchse
         then
            GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionAlt.XAchse := GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse;
            
         else
            null;
         end if;
      end if;
      
      Put (Item => CSI & "2J" & CSI & "3J" & CSI & "H");

      YAchseSchleife:
      for YAchseSchleifenwert in -Sichtweiten (SichtweiteFestlegen).YAchse .. Sichtweiten (SichtweiteFestlegen).YAchse loop
         XAchseSchleife:
         for XAchseSchleifenwert in -Sichtweiten (SichtweiteFestlegen).XAchse .. Sichtweiten (SichtweiteFestlegen).XAchse loop
            
            Kartenwert := KartenPruefungen.KartenPositionBestimmen (KoordinatenExtern    => GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionAlt,
                                                                    ÄnderungExtern       => (0, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                    ZusatzYAbstandExtern => 0);
            
            case
              Kartenwert.Erfolgreich
            is
               when False =>
                  exit XAchseSchleife;
                  
               when True =>
                  Sichtbarkeit.Sichtbarkeit (InDerStadtExtern  => False,
                                             KoordinatenExtern => (Kartenwert.EAchse, Kartenwert.YAchse, Kartenwert.XAchse),
                                             RasseExtern       => RasseExtern);
            end case;
            
            if
              XAchseSchleifenwert = Sichtweiten (SichtweiteFestlegen).XAchse
            then
               New_Line;
                  
            else
               null;
            end if;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;    
         
      Information (RasseExtern => RasseExtern);

   end AnzeigeKarte;
   


   procedure Information
     (RasseExtern : in GlobaleDatentypen.Rassen)
   is begin

      Verteidigungsbonus := 0;
      Nahrungsgewinnung := 0;
      Ressourcengewinnung := 0;
      Geldgewinnung := 0;
      Wissensgewinnung := 0;
      
      -- Allgemeine Informationen über die eigene Rasse, immer sichtbar
      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                     TextDateiExtern        => GlobaleDatentypen.Zeug,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 33,
                                     LetzteZeileExtern      => 33,
                                     AbstandAnfangExtern    => GlobaleDatentypen.Keiner,
                                     AbstandMitteExtern     => GlobaleDatentypen.Keiner,
                                     AbstandEndeExtern      => GlobaleDatentypen.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => GlobaleVariablen.RundenAnzahl,
                               Width => 1);

      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                     TextDateiExtern        => GlobaleDatentypen.Zeug,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 34,
                                     LetzteZeileExtern      => 34,
                                     AbstandAnfangExtern    => GlobaleDatentypen.Großer_Abstand,
                                     AbstandMitteExtern     => GlobaleDatentypen.Keiner,
                                     AbstandEndeExtern      => GlobaleDatentypen.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => GlobaleVariablen.Wichtiges (RasseExtern).AktuelleGeldmenge,
                               Width => 1);

      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                     TextDateiExtern        => GlobaleDatentypen.Zeug,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 35,
                                     LetzteZeileExtern      => 35,
                                     AbstandAnfangExtern    => GlobaleDatentypen.Großer_Abstand,
                                     AbstandMitteExtern     => GlobaleDatentypen.Keiner,
                                     AbstandEndeExtern      => GlobaleDatentypen.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => Integer (GlobaleVariablen.Wichtiges (RasseExtern).GeldZugewinnProRunde),
                               Width => 1);
      New_Line;

      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                     TextDateiExtern        => GlobaleDatentypen.Zeug,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 38,
                                     LetzteZeileExtern      => 38,
                                     AbstandAnfangExtern    => GlobaleDatentypen.Großer_Abstand,
                                     AbstandMitteExtern     => GlobaleDatentypen.Keiner,
                                     AbstandEndeExtern      => GlobaleDatentypen.Kleiner_Abstand);
      ForschungsDatenbank.Beschreibung (IDExtern => GlobaleVariablen.Wichtiges (RasseExtern).AktuellesForschungsprojekt);

      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                     TextDateiExtern        => GlobaleDatentypen.Zeug,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 36,
                                     LetzteZeileExtern      => 36,
                                     AbstandAnfangExtern    => GlobaleDatentypen.Großer_Abstand,
                                     AbstandMitteExtern     => GlobaleDatentypen.Keiner,
                                     AbstandEndeExtern      => GlobaleDatentypen.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => Integer (GlobaleVariablen.Wichtiges (RasseExtern).VerbleibendeForschungszeit),
                               Width => 1);
      New_Line;

      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                     TextDateiExtern        => GlobaleDatentypen.Zeug,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 39,
                                     LetzteZeileExtern      => 39,
                                     AbstandAnfangExtern    => GlobaleDatentypen.Großer_Abstand,
                                     AbstandMitteExtern     => GlobaleDatentypen.Keiner,
                                     AbstandEndeExtern      => GlobaleDatentypen.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => Integer (GlobaleVariablen.Wichtiges (RasseExtern).AktuelleForschungsmenge),
                               Width => 1);

      Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                     TextDateiExtern        => GlobaleDatentypen.Zeug,
                                     ÜberschriftZeileExtern => 0,
                                     ErsteZeileExtern       => 37,
                                     LetzteZeileExtern      => 37,
                                     AbstandAnfangExtern    => GlobaleDatentypen.Großer_Abstand,
                                     AbstandMitteExtern     => GlobaleDatentypen.Keiner,
                                     AbstandEndeExtern      => GlobaleDatentypen.Kleiner_Abstand);
      Ada.Integer_Text_IO.Put (Item  => Integer (GlobaleVariablen.Wichtiges (RasseExtern).AktuelleForschungsrate),
                               Width => 1);
      New_Line (Spacing => 2);
      
      case
        Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse, GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                          GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).Sichtbar (RasseExtern)
      is
         when True =>
            RasseUndPlatznummer := EinheitSuchen.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition);
            
            case
              RasseUndPlatznummer.Platznummer
            is
               when GlobaleKonstanten.RückgabeEinheitStadtNummerFalsch =>
                  null;
                 
               when others => -- Allgemeine Einheiteninformationen, nur sichtbar wenn das Kartenfeld aufgedackt ist und sich dort eine Einheit befindet
                  case
                    GlobaleVariablen.EinheitenGebaut (RasseUndPlatznummer.Rasse, RasseUndPlatznummer.Platznummer).WirdTransportiert
                  is -- Das hier noch besser einbauen
                     when 0 =>
                        EinheitNummer := RasseUndPlatznummer.Platznummer;
                        
                     when others =>
                        EinheitNummer := GlobaleVariablen.EinheitenGebaut (RasseUndPlatznummer.Rasse, RasseUndPlatznummer.Platznummer).WirdTransportiert;
                  end case;
                  EinheitenDatenbank.Beschreibung (GlobaleVariablen.EinheitenGebaut (RasseUndPlatznummer.Rasse, RasseUndPlatznummer.Platznummer).ID);
                  New_Line;
                  
                  Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                                 TextDateiExtern        => GlobaleDatentypen.Zeug,
                                                 ÜberschriftZeileExtern => 0,
                                                 ErsteZeileExtern       => 14,
                                                 LetzteZeileExtern      => 14,
                                                 AbstandAnfangExtern    => GlobaleDatentypen.Großer_Abstand,
                                                 AbstandMitteExtern     => GlobaleDatentypen.Keiner,
                                                 AbstandEndeExtern      => GlobaleDatentypen.Kleiner_Abstand);
                  Ada.Integer_Text_IO.Put (Item  => GlobaleVariablen.EinheitenGebaut (RasseUndPlatznummer.Rasse, RasseUndPlatznummer.Platznummer).AktuelleLebenspunkte,
                                           Width => 1);
                  Put (Item => " / ");
                  Ada.Integer_Text_IO.Put (Item  => EinheitenDatenbank.EinheitenListe (RasseUndPlatznummer.Rasse,
                                           GlobaleVariablen.EinheitenGebaut (RasseUndPlatznummer.Rasse, RasseUndPlatznummer.Platznummer).ID).MaximaleLebenspunkte,
                                           Width => 1);
            
                  -- "Volle" Einheiteninformationen, nur sichtbar wenn eigene Einheit oder wenn Cheat aktiviert ist
                  if
                    RasseExtern = RasseUndPlatznummer.Rasse
                    or
                      GlobaleVariablen.FeindlicheInformationenSehen = True 
                  then
                     Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                                    TextDateiExtern        => GlobaleDatentypen.Zeug,
                                                    ÜberschriftZeileExtern => 0,
                                                    ErsteZeileExtern       => 15,
                                                    LetzteZeileExtern      => 15,
                                                    AbstandAnfangExtern    => GlobaleDatentypen.Großer_Abstand,
                                                    AbstandMitteExtern     => GlobaleDatentypen.Keiner,
                                                    AbstandEndeExtern      => GlobaleDatentypen.Kleiner_Abstand);
                     Ada.Float_Text_IO.Put (Item => GlobaleVariablen.EinheitenGebaut (RasseUndPlatznummer.Rasse, RasseUndPlatznummer.Platznummer).AktuelleBewegungspunkte,
                                            Fore => 1,
                                            Aft  => 2,
                                            Exp  => 0);
                     Put (Item => " / ");
                     Ada.Float_Text_IO.Put (Item => EinheitenDatenbank.EinheitenListe (RasseUndPlatznummer.Rasse, GlobaleVariablen.EinheitenGebaut (RasseUndPlatznummer.Rasse,
                                            RasseUndPlatznummer.Platznummer).ID).MaximaleBewegungspunkte,
                                            Fore => 1,
                                            Aft  => 2,
                                            Exp  => 0);

                     Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                                    TextDateiExtern        => GlobaleDatentypen.Zeug,
                                                    ÜberschriftZeileExtern => 0,
                                                    ErsteZeileExtern       => 16,
                                                    LetzteZeileExtern      => 16,
                                                    AbstandAnfangExtern    => GlobaleDatentypen.Großer_Abstand,
                                                    AbstandMitteExtern     => GlobaleDatentypen.Keiner,
                                                    AbstandEndeExtern      => GlobaleDatentypen.Kleiner_Abstand);
                     Ada.Integer_Text_IO.Put (Item  => GlobaleVariablen.EinheitenGebaut (RasseUndPlatznummer.Rasse, RasseUndPlatznummer.Platznummer).AktuelleErfahrungspunkte,
                                              Width => 1);
                     Put (Item => " / ");
                     Ada.Integer_Text_IO.Put (Item  => EinheitenDatenbank.EinheitenListe (RasseUndPlatznummer.Rasse, GlobaleVariablen.EinheitenGebaut (RasseUndPlatznummer.Rasse,
                                              RasseUndPlatznummer.Platznummer).ID).Beförderungsgrenze,
                                              Width => 1);
                     New_Line;
                              
                     Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                                    TextDateiExtern        => GlobaleDatentypen.Zeug,
                                                    ÜberschriftZeileExtern => 0,
                                                    ErsteZeileExtern       => 17,
                                                    LetzteZeileExtern      => 17,
                                                    AbstandAnfangExtern    => GlobaleDatentypen.Großer_Abstand,
                                                    AbstandMitteExtern     => GlobaleDatentypen.Keiner,
                                                    AbstandEndeExtern      => GlobaleDatentypen.Kleiner_Abstand);
                     EinheitenDatenbank.Beschäftigung (GlobaleVariablen.EinheitenGebaut (RasseUndPlatznummer.Rasse, RasseUndPlatznummer.Platznummer).AktuelleBeschäftigung);

                     Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                                    TextDateiExtern        => GlobaleDatentypen.Zeug,
                                                    ÜberschriftZeileExtern => 0,
                                                    ErsteZeileExtern       => 18,
                                                    LetzteZeileExtern      => 18,
                                                    AbstandAnfangExtern    => GlobaleDatentypen.Großer_Abstand,
                                                    AbstandMitteExtern     => GlobaleDatentypen.Keiner,
                                                    AbstandEndeExtern      => GlobaleDatentypen.Kleiner_Abstand);
                     Ada.Integer_Text_IO.Put (Item  => GlobaleVariablen.EinheitenGebaut (RasseUndPlatznummer.Rasse, RasseUndPlatznummer.Platznummer).AktuelleBeschäftigungszeit,
                                              Width => 1);
                     New_Line;

                     Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                                    TextDateiExtern        => GlobaleDatentypen.Zeug,
                                                    ÜberschriftZeileExtern => 0,
                                                    ErsteZeileExtern       => 24,
                                                    LetzteZeileExtern      => 24,
                                                    AbstandAnfangExtern    => GlobaleDatentypen.Großer_Abstand,
                                                    AbstandMitteExtern     => GlobaleDatentypen.Keiner,
                                                    AbstandEndeExtern      => GlobaleDatentypen.Kleiner_Abstand);
                     Ada.Integer_Text_IO.Put (Item  => Integer (EinheitenDatenbank.EinheitenListe (RasseUndPlatznummer.Rasse,
                                              GlobaleVariablen.EinheitenGebaut (RasseUndPlatznummer.Rasse, RasseUndPlatznummer.Platznummer).ID).Angriff),
                                              Width => 1);

                     Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                                    TextDateiExtern        => GlobaleDatentypen.Zeug,
                                                    ÜberschriftZeileExtern => 0,
                                                    ErsteZeileExtern       => 25,
                                                    LetzteZeileExtern      => 25,
                                                    AbstandAnfangExtern    => GlobaleDatentypen.Großer_Abstand,
                                                    AbstandMitteExtern     => GlobaleDatentypen.Keiner,
                                                    AbstandEndeExtern      => GlobaleDatentypen.Kleiner_Abstand);
                     Ada.Integer_Text_IO.Put (Item  => Integer (EinheitenDatenbank.EinheitenListe (RasseUndPlatznummer.Rasse,
                                              GlobaleVariablen.EinheitenGebaut (RasseUndPlatznummer.Rasse, RasseUndPlatznummer.Platznummer).ID).Verteidigung),
                                              Width => 1);
                     
                     Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                                    TextDateiExtern        => GlobaleDatentypen.Zeug,
                                                    ÜberschriftZeileExtern => 0,
                                                    ErsteZeileExtern       => 26,
                                                    LetzteZeileExtern      => 26,
                                                    AbstandAnfangExtern    => GlobaleDatentypen.Großer_Abstand,
                                                    AbstandMitteExtern     => GlobaleDatentypen.Keiner,
                                                    AbstandEndeExtern      => GlobaleDatentypen.Kleiner_Abstand);
                     Ada.Integer_Text_IO.Put (Item  => GlobaleVariablen.EinheitenGebaut (RasseUndPlatznummer.Rasse, RasseUndPlatznummer.Platznummer).AktuellerRang,
                                              Width => 1);
                     Put (Item => " / ");
                     Ada.Integer_Text_IO.Put (Item  => EinheitenDatenbank.EinheitenListe (RasseUndPlatznummer.Rasse,
                                              GlobaleVariablen.EinheitenGebaut (RasseUndPlatznummer.Rasse, RasseUndPlatznummer.Platznummer).ID).MaximalerRang,
                                              Width => 1);
                     New_Line;
                              
                  else
                     null;
                  end if;
                        
                  New_Line;
                  case
                    GlobaleVariablen.FeindlicheInformationenSehen
                  is
                     when False =>
                        null;
                                 
                     when True =>
                        Put_Line (Item => "Aktuelle Rasse: " & RasseUndPlatznummer.Rasse'Wide_Wide_Image);
                  end case;
            end case;
            
            RasseUndPlatznummer := StadtSuchen.KoordinatenStadtOhneRasseSuchen (KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition);

            case
              RasseUndPlatznummer.Platznummer
            is
               when GlobaleKonstanten.RückgabeEinheitStadtNummerFalsch =>
                  null;
                     
               when others => -- Stadtinformationsaufruf
                  if
                    GlobaleVariablen.StadtGebaut (RasseUndPlatznummer.Rasse, RasseUndPlatznummer.Platznummer).AchsenPosition = GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition
                  then
                     KarteStadt.Beschreibung (RasseExtern => RasseExtern);

                     -- Stadtverteidigungsinformation, nur sichtbar wenn eigene Stadt oder wenn Cheat aktiviert ist
                     if
                       RasseUndPlatznummer.Rasse = RasseExtern
                       or
                         GlobaleVariablen.FeindlicheInformationenSehen = True
                     then                              
                        Verteidigungsbonus := Verteidigungsbonus + VerbesserungenDatenbank.VerbesserungListe (KartenVerbesserung (GlobaleVariablen.StadtGebaut (RasseUndPlatznummer.Rasse,
                                                                                                              RasseUndPlatznummer.Platznummer).ID)).Verteidigungsbonus;

                     else
                        null;
                     end if;

                     case
                       GlobaleVariablen.FeindlicheInformationenSehen
                     is
                        when False =>
                           null;
                                 
                        when True =>
                           Put_Line (Item => "Aktuelle Rasse: " & RasseUndPlatznummer.Rasse'Wide_Wide_Image);
                     end case;
                     
                  else
                     null;
                  end if;
            end case;
                  
            -- Allgemeine Karteninformationen, nur sichtbar wenn das Kartenfeld aufgedackt ist
            if
              Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse,
                                GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse, GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).Hügel = True
              and
                Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse,
                                  GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse, GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).Grund /= 6
            then
               Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                              TextDateiExtern        => GlobaleDatentypen.Beschreibungen_Kartenfelder_Kurz,
                                              ÜberschriftZeileExtern => 0,
                                              ErsteZeileExtern       => 34,
                                              LetzteZeileExtern      => 34,
                                              AbstandAnfangExtern    => GlobaleDatentypen.Keiner,
                                              AbstandMitteExtern     => GlobaleDatentypen.Keiner,
                                              AbstandEndeExtern      => GlobaleDatentypen.Keiner);
               KartenDatenbank.Beschreibung (IDExtern => Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse, GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                                             GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).Grund);

               Verteidigungsbonus := Verteidigungsbonus + KartenDatenbank.KartenListe (Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse,
                                                                                       GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                                                                                       GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).Grund).Verteidigungsbonus;
               Nahrungsgewinnung := Nahrungsgewinnung + KartenDatenbank.KartenListe (Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse,
                                                                                     GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                                                                                     GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).Grund).Nahrungsgewinnung;
               Ressourcengewinnung := Ressourcengewinnung + KartenDatenbank.KartenListe (Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse,
                                                                                         GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                                                                                         GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).Grund).Ressourcengewinnung;
               Geldgewinnung := Geldgewinnung + KartenDatenbank.KartenListe (Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse,
                                                                             GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                                                                             GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).Grund).Geldgewinnung;
               Wissensgewinnung := Wissensgewinnung + KartenDatenbank.KartenListe (Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse,
                                                                                   GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                                                                                   GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).Grund).Wissensgewinnung;
         
            elsif
              Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse, GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                                GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).Hügel = True
            then
               KartenDatenbank.Beschreibung (IDExtern => Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse, GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                                             GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).Grund);

               Verteidigungsbonus := Verteidigungsbonus + KartenDatenbank.KartenListe (Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse,
                                                                                       GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                                                                                       GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).Grund).Verteidigungsbonus;
               Nahrungsgewinnung := Nahrungsgewinnung + KartenDatenbank.KartenListe (Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse,
                                                                                     GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                                                                                     GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).Grund).Nahrungsgewinnung;
               Ressourcengewinnung := Ressourcengewinnung + KartenDatenbank.KartenListe (Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse,
                                                                                         GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                                                                                         GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).Grund).Ressourcengewinnung;
               Geldgewinnung := Geldgewinnung + KartenDatenbank.KartenListe (Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse,
                                                                             GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                                                                             GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).Grund).Geldgewinnung;
               Wissensgewinnung := Wissensgewinnung + KartenDatenbank.KartenListe (Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse,
                                                                                   GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                                                                                   GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).Grund).Wissensgewinnung;
               
            else         
               KartenDatenbank.Beschreibung (IDExtern => Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse, GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                                             GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).Grund);

               Verteidigungsbonus := Verteidigungsbonus + KartenDatenbank.KartenListe (Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse,
                                                                                       GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                                                                                       GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).Grund).Verteidigungsbonus;
               Nahrungsgewinnung := Nahrungsgewinnung + KartenDatenbank.KartenListe (Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse,
                                                                                     GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                                                                                     GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).Grund).Nahrungsgewinnung;
               Ressourcengewinnung := Ressourcengewinnung + KartenDatenbank.KartenListe (Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse,
                                                                                         GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                                                                                         GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).Grund).Ressourcengewinnung;
               Geldgewinnung := Geldgewinnung + KartenDatenbank.KartenListe (Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse,
                                                                             GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                                                                             GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).Grund).Geldgewinnung;
               Wissensgewinnung := Wissensgewinnung + KartenDatenbank.KartenListe (Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse,
                                                                                   GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                                                                                   GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).Grund).Wissensgewinnung;
            end if;
      
            if
              Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse, GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                                GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).Ressource /= 0
            then
               KartenDatenbank.Beschreibung (IDExtern => Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse, GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                                             GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).Ressource);

               Verteidigungsbonus
                 := Verteidigungsbonus + KartenDatenbank.KartenListe (Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse, GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                                                                      GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).Ressource).Verteidigungsbonus;
               Nahrungsgewinnung := Nahrungsgewinnung + KartenDatenbank.KartenListe (Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse,
                                                                                     GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                                                                                     GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).Ressource).Nahrungsgewinnung;
               Ressourcengewinnung
                 := Ressourcengewinnung + KartenDatenbank.KartenListe (Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse, GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                                                                       GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).Ressource).Ressourcengewinnung;
               Geldgewinnung := Geldgewinnung + KartenDatenbank.KartenListe (Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse,
                                                                             GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                                                                             GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).Ressource).Geldgewinnung;
               Wissensgewinnung := Wissensgewinnung + KartenDatenbank.KartenListe (Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse,
                                                                                   GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                                                                                   GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).Ressource).Wissensgewinnung;
         
            else
               null;
            end if;
      
            if
              Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse, GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                                GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).VerbesserungGebiet /= 0
            then
               VerbesserungenDatenbank.Beschreibung (IDExtern => Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse, GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                                                     GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).VerbesserungGebiet);

               Verteidigungsbonus
                 := Verteidigungsbonus + VerbesserungenDatenbank.VerbesserungListe (Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse,
                                                                                    GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                                                                                    GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).VerbesserungGebiet).Verteidigungsbonus;
               Nahrungsgewinnung
                 := Nahrungsgewinnung + VerbesserungenDatenbank.VerbesserungListe (Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse,
                                                                                   GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                                                                                   GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).VerbesserungGebiet).Nahrungsbonus;
               Ressourcengewinnung
                 := Ressourcengewinnung + VerbesserungenDatenbank.VerbesserungListe (Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse,
                                                                                     GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                                                                                     GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).VerbesserungGebiet).Ressourcenbonus;
               Geldgewinnung := Geldgewinnung + VerbesserungenDatenbank.VerbesserungListe (Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse,
                                                                                           GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                                                                                           GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).VerbesserungGebiet).Geldbonus;
               Wissensgewinnung
                 := Wissensgewinnung + VerbesserungenDatenbank.VerbesserungListe (Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse,
                                                                                  GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                                                                                  GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).VerbesserungGebiet).Wissensbonus;
         
            else
               null;
            end if;
      
            if
              Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse, GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                                GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).VerbesserungStraße /= 0
            then
               VerbesserungenDatenbank.Beschreibung (IDExtern => Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse, GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                                                     GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).VerbesserungStraße);

               Verteidigungsbonus
                 := Verteidigungsbonus + VerbesserungenDatenbank.VerbesserungListe (Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse,
                                                                                    GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                                                                                    GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).VerbesserungStraße).Verteidigungsbonus;
               Nahrungsgewinnung
                 := Nahrungsgewinnung + VerbesserungenDatenbank.VerbesserungListe (Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse,
                                                                                   GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                                                                                   GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).VerbesserungStraße).Nahrungsbonus;
               Ressourcengewinnung
                 := Ressourcengewinnung + VerbesserungenDatenbank.VerbesserungListe (Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse, GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                                                                                     GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).VerbesserungStraße).Ressourcenbonus;
               Geldgewinnung := Geldgewinnung + VerbesserungenDatenbank.VerbesserungListe (Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse,
                                                                                           GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                                                                                           GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).VerbesserungStraße).Geldbonus;
               Wissensgewinnung
                 := Wissensgewinnung + VerbesserungenDatenbank.VerbesserungListe (Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse,
                                                                                  GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                                                                                  GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).VerbesserungStraße).Wissensbonus;
               
            else
               null;
            end if;
      
            if
              Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse, GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                                GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).Fluss /= 0
            then
               KartenDatenbank.Beschreibung (IDExtern => Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse, GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                                             GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).Fluss);

               Verteidigungsbonus := Verteidigungsbonus + KartenDatenbank.KartenListe (Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse,
                                                                                       GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                                                                                       GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).Fluss).Verteidigungsbonus;
               Nahrungsgewinnung := Nahrungsgewinnung + KartenDatenbank.KartenListe (Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse,
                                                                                     GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                                                                                     GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).Fluss).Nahrungsgewinnung;
               Ressourcengewinnung := Ressourcengewinnung + KartenDatenbank.KartenListe (Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse,
                                                                                         GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                                                                                         GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).Fluss).Ressourcengewinnung;
               Geldgewinnung := Geldgewinnung + KartenDatenbank.KartenListe (Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse,
                                                                             GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                                                                             GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).Fluss).Geldgewinnung;
               Wissensgewinnung := Wissensgewinnung + KartenDatenbank.KartenListe (Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse,
                                                                                   GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                                                                                   GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).Fluss).Wissensgewinnung;
         
            else
               null;
            end if;
            
            New_Line;
            Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Leer,
                                           TextDateiExtern        => GlobaleDatentypen.Zeug,
                                           ÜberschriftZeileExtern => 0,
                                           ErsteZeileExtern       => 19,
                                           LetzteZeileExtern      => 19,
                                           AbstandAnfangExtern    => GlobaleDatentypen.Großer_Abstand,
                                           AbstandMitteExtern     => GlobaleDatentypen.Keiner,
                                           AbstandEndeExtern      => GlobaleDatentypen.Kleiner_Abstand);
            Ada.Integer_Text_IO.Put (Item  => Integer (Verteidigungsbonus),
                                     Width => 1);
            
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
            New_Line;
            
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
            
         when False =>
            null;
      end case;

      New_Line;
      case
        GlobaleVariablen.FeindlicheInformationenSehen
      is -- Für Cheat
         when False =>
            null;
                                 
         when True =>
            Put (Item => "Aktuelle EPosition: " & GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse'Wide_Wide_Image);
            Put (Item => "    Aktuelle YPosition: " & GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse'Wide_Wide_Image);
            Put_Line (Item => "    Aktuelle XPosition: " & GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse'Wide_Wide_Image);
            Put (Item => "Kartenfeldbewertung: " & Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse, GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                 GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).Felderwertung'Wide_Wide_Image);
            Put_Line (Item => "    Aktuelle GrundID: " & Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse, GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                      GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).Grund'Wide_Wide_Image);
            Put_Line (Item => "Aktuelle Stadtbelegung: " & Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse, GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                      GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).DurchStadtBelegterGrund'Wide_Wide_Image);
      end case;
      
   end Information; 
   
end Karte;
