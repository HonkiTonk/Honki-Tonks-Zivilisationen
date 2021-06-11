pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO;
use Ada.Wide_Wide_Text_IO;

with GlobaleKonstanten, KIDatentypen;

with EinheitenDatenbank, VerbesserungenDatenbank;

with Karte, Karten, Anzeige, Eingabe, EinheitSuchen, ForschungAllgemein, EinheitenAllgemein;

package body Cheat is

   procedure Menü
     (RasseExtern : in GlobaleDatentypen.Rassen)
   is begin
      
      MenüSchleife:
      loop

         Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDateiExtern => GlobaleDatentypen.Cheat_Menü,
                                        TextDateiExtern        => GlobaleDatentypen.Cheat_Menü,
                                        ÜberschriftZeileExtern => 1,
                                        ErsteZeileExtern       => 2,
                                        LetzteZeileExtern      => 11,
                                        AbstandAnfangExtern    => GlobaleDatentypen.Keiner,
                                        AbstandMitteExtern     => GlobaleDatentypen.Neue_Zeile,
                                        AbstandEndeExtern      => GlobaleDatentypen.Neue_Zeile);

         case
           Eingabe.TastenEingabe
         is
            when 'n' => -- Nächste Einheit (unabhängig von der Rasse)
               BeliebigeNächsteEinheit (RasseExtern => RasseExtern);

            when 'i' => -- Volle Informationen (unabhängig von der Rasse)
               Informationen;

            when 's' => -- Sichtbarkeit der ganzen Karte
               Sichtbarkeit (RasseExtern => RasseExtern);

            when 'e' => -- Einheit erzeugen
               EinheitFestlegen (RasseExtern => RasseExtern);

            when 'g' => -- Geld auf 1.000.000 setzen
               Geld (RasseExtern => RasseExtern);

            when 't' => -- Technologie auf erforscht setzen
               Technologie (RasseExtern => RasseExtern);

            when 'v' => -- Verbesserung auf dem Cursorfeld erzeugen
               VerbesserungFestlegen  (RasseExtern => RasseExtern);
               
            when 'b' => -- Kartengrund auf dem Cursorfeld festlegen
               GrundFestlegen (RasseExtern => RasseExtern);

            when 'a' => -- Festlegen ob und von wem die Rasse belegt ist
               RassenverteilungÄndern;
               
            when others =>
               return;
         end case;
         Karte.AnzeigeKarte (RasseExtern => RasseExtern);

      end loop MenüSchleife;
      
   end Menü;


   procedure BeliebigeNächsteEinheit
     (RasseExtern : in GlobaleDatentypen.Rassen)
   is begin
      
      EinheitenSchleife:
      loop         
         
         if
           GlobaleVariablen.EinheitenGebaut (AktuelleRasseEinheit, AktuelleEinheit).ID = 0
         then
            case
              AktuelleRasseEinheit
            is
               when GlobaleDatentypen.Rassen'Last =>
                  AktuelleRasseEinheit := GlobaleDatentypen.Rassen'First;
                    
               when others =>
                  AktuelleRasseEinheit := AktuelleRasseEinheit + 1;
            end case;
            AktuelleEinheit := 1;
            
         else
            GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse := GlobaleVariablen.EinheitenGebaut (AktuelleRasseEinheit, AktuelleEinheit).AchsenPosition.YAchse;
            GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse := GlobaleVariablen.EinheitenGebaut (AktuelleRasseEinheit, AktuelleEinheit).AchsenPosition.XAchse;
            case
              AktuelleEinheit
            is
               when GlobaleVariablen.EinheitenGebaut'Last (2) =>
                  case
                    AktuelleRasseEinheit
                  is
                     when GlobaleDatentypen.Rassen'Last =>
                        AktuelleRasseEinheit := GlobaleDatentypen.Rassen'First;
                    
                     when others =>
                        AktuelleRasseEinheit := AktuelleRasseEinheit + 1;
                  end case;
                  AktuelleEinheit := AktuelleEinheit + 1;
                     
               when others =>
                  AktuelleEinheit := AktuelleEinheit + 1;
            end case;
            return;
         end if;
         
      end loop EinheitenSchleife;
      
   end BeliebigeNächsteEinheit;



   procedure BeliebigeNächsteStadt
     (RasseExtern : in GlobaleDatentypen.Rassen)
   is begin
      
      StädteSchleife:
      loop         
         
         if
           GlobaleVariablen.StadtGebaut (AktuelleRasseStadt, AktuelleStadt).ID = 0
         then
            case
              AktuelleRasseStadt
            is
               when GlobaleDatentypen.Rassen'Last =>
                  AktuelleRasseStadt := GlobaleDatentypen.Rassen'First;
                    
               when others =>
                  AktuelleRasseStadt := AktuelleRasseStadt + 1;
            end case;
            AktuelleStadt := 1;
            
         else
            GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse := GlobaleVariablen.StadtGebaut (AktuelleRasseStadt, AktuelleStadt).AchsenPosition.YAchse;
            GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse := GlobaleVariablen.StadtGebaut (AktuelleRasseStadt, AktuelleStadt).AchsenPosition.XAchse;
            case
              AktuelleStadt
            is
               when GlobaleVariablen.StadtGebaut'Last (2) =>
                  if
                    AktuelleRasseStadt = GlobaleDatentypen.Rassen'Last
                  then
                     AktuelleRasseStadt := GlobaleDatentypen.Rassen'First;
                    
                  else
                     AktuelleRasseStadt := AktuelleRasseStadt + 1;
                  end if;
                  AktuelleStadt := AktuelleStadt + 1;
                     
               when others =>
                  AktuelleStadt := AktuelleStadt + 1;
            end case;
            return;
         end if;
         
      end loop StädteSchleife;
      
   end BeliebigeNächsteStadt;



   procedure Informationen
   is begin
      
      GlobaleVariablen.FeindlicheInformationenSehen := not GlobaleVariablen.FeindlicheInformationenSehen;
   
   end Informationen;



   procedure Sichtbarkeit
     (RasseExtern : in GlobaleDatentypen.Rassen)
   is begin
      
      EbeneSchleife:
      for EAchseSchleifenwert in Karten.WeltkarteArray'Range (1) loop
         YAchseSchleife:
         for YAchseSchleifenwert in Karten.WeltkarteArray'First (2) .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße loop
            XAchseSchleife:
            for XAchseSchleifenwert in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
            
               Karten.Weltkarte (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert).Sichtbar (RasseExtern) := True;
               
            end loop XAchseSchleife;
         end loop YAchseSchleife;
      end loop EbeneSchleife;
      
   end Sichtbarkeit;



   procedure GrundFestlegen
     (RasseExtern : in GlobaleDatentypen.Rassen)
   is begin
      
      KartenGrundID := GlobaleDatentypen.KartenGrund (Eingabe.GanzeZahl (TextDateiExtern     => GlobaleDatentypen.Cheat_Menü,
                                                                         ZeileExtern         => 12,
                                                                         ZahlenMinimumExtern => 1,
                                                                         ZahlenMaximumExtern => 42));

      case
        KartenGrundID
      is
         when 1 .. 9 | 31 .. 32 | 35 .. 42 =>
            Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse,
                              GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                              GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).Grund := KartenGrundID;

         when 10 .. 13 | 29 .. 30 | 33 =>
            Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse,
                              GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                              GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).Ressource := KartenGrundID;

         when 14 .. 28 =>
            Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse,
                              GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                              GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).Fluss := KartenGrundID;
            
         when others =>
            null;
      end case;
      
   end GrundFestlegen;
   
   
   
   procedure EinheitFestlegen
     (RasseExtern : in GlobaleDatentypen.Rassen)
   is begin

      RasseNummer := Eingabe.GanzeZahl (TextDateiExtern     => GlobaleDatentypen.Cheat_Menü,
                                        ZeileExtern         => 13,
                                        ZahlenMinimumExtern => Integer (GlobaleDatentypen.Rassen'First),
                                        ZahlenMaximumExtern => Integer (GlobaleDatentypen.Rassen'Last));

      case
        RasseNummer
      is
         when GlobaleKonstanten.GanzeZahlAbbruchKonstante =>
            return;
            
         when others =>
            null;
      end case;

      EinheitID := Eingabe.GanzeZahl (TextDateiExtern     => GlobaleDatentypen.Cheat_Menü,
                                      ZeileExtern         => 14,
                                      ZahlenMinimumExtern => Integer (EinheitenDatenbank.EinheitenListe'First (2)),
                                      ZahlenMaximumExtern => Integer (EinheitenDatenbank.EinheitenListe'Last (2)));

      case
        EinheitID
      is
         when GlobaleKonstanten.GanzeZahlAbbruchKonstante =>
            return;
            
         when others =>
            null;
      end case;

      EinheitPosition := EinheitSuchen.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition);
      
      case
        EinheitPosition.Platznummer
      is
         when GlobaleKonstanten.RückgabeEinheitStadtNummerFalsch =>
            EinheitenSchleife:
            for EinheitNummer in GlobaleVariablen.EinheitenGebautArray'Range (2) loop

               case
                 GlobaleVariablen.EinheitenGebaut (GlobaleDatentypen.Rassen (RasseNummer), EinheitNummer).ID
               is
                  when 0 =>
                     GlobaleVariablen.EinheitenGebaut (GlobaleDatentypen.Rassen (RasseNummer), EinheitNummer).AktuelleBeschäftigung := GlobaleDatentypen.Keine;
                     GlobaleVariablen.EinheitenGebaut (GlobaleDatentypen.Rassen (RasseNummer), EinheitNummer).AktuelleBeschäftigungNachfolger := GlobaleDatentypen.Keine;
                     GlobaleVariablen.EinheitenGebaut (GlobaleDatentypen.Rassen (RasseNummer), EinheitNummer).ID := GlobaleDatentypen.EinheitenID (EinheitID);
                     GlobaleVariablen.EinheitenGebaut (GlobaleDatentypen.Rassen (RasseNummer), EinheitNummer).AchsenPosition := GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition;
                     GlobaleVariablen.EinheitenGebaut (GlobaleDatentypen.Rassen (RasseNummer), EinheitNummer).AktuelleLebenspunkte
                       := EinheitenDatenbank.EinheitenListe (GlobaleDatentypen.Rassen (RasseNummer), GlobaleDatentypen.EinheitenID (EinheitID)).MaximaleLebenspunkte;
                     GlobaleVariablen.EinheitenGebaut (GlobaleDatentypen.Rassen (RasseNummer), EinheitNummer).AktuelleBewegungspunkte
                       := EinheitenDatenbank.EinheitenListe (GlobaleDatentypen.Rassen (RasseNummer), GlobaleDatentypen.EinheitenID (EinheitID)).MaximaleBewegungspunkte;
                     GlobaleVariablen.EinheitenGebaut (GlobaleDatentypen.Rassen (RasseNummer), EinheitNummer).AktuelleErfahrungspunkte := 0;
                     GlobaleVariablen.EinheitenGebaut (GlobaleDatentypen.Rassen (RasseNummer), EinheitNummer).AktuellerRang := 0;
                     GlobaleVariablen.EinheitenGebaut (GlobaleDatentypen.Rassen (RasseNummer), EinheitNummer).AktuelleBeschäftigungszeit := 0;
                     GlobaleVariablen.EinheitenGebaut (GlobaleDatentypen.Rassen (RasseNummer), EinheitNummer).AktuelleBeschäftigungszeitNachfolger := 0;
                     GlobaleVariablen.EinheitenGebaut (GlobaleDatentypen.Rassen (RasseNummer), EinheitNummer).KIZielKoordinaten := (0, 1, 1);
                     GlobaleVariablen.EinheitenGebaut (GlobaleDatentypen.Rassen (RasseNummer), EinheitNummer).KIBeschäftigt := KIDatentypen.Keine_Aufgabe;
                     return;
                     
                  when others =>
                     null;
               end case;
               
            end loop EinheitenSchleife;
            
         when others =>
            EinheitenAllgemein.EinheitEntfernen (EinheitRasseNummerExtern => EinheitPosition);
            GelöschtEinheitenSchleife:
            for EinheitNummer in GlobaleVariablen.EinheitenGebautArray'Range (2) loop

               case
                 GlobaleVariablen.EinheitenGebaut (GlobaleDatentypen.Rassen (RasseNummer), EinheitNummer).ID
               is
                  when 0 =>
                     GlobaleVariablen.EinheitenGebaut (GlobaleDatentypen.Rassen (RasseNummer), EinheitNummer).AktuelleBeschäftigung := GlobaleDatentypen.Keine;
                     GlobaleVariablen.EinheitenGebaut (GlobaleDatentypen.Rassen (RasseNummer), EinheitNummer).AktuelleBeschäftigungNachfolger := GlobaleDatentypen.Keine;
                     GlobaleVariablen.EinheitenGebaut (GlobaleDatentypen.Rassen (RasseNummer), EinheitNummer).ID := GlobaleDatentypen.EinheitenID (EinheitID);
                     GlobaleVariablen.EinheitenGebaut (GlobaleDatentypen.Rassen (RasseNummer), EinheitNummer).AchsenPosition := GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition;
                     GlobaleVariablen.EinheitenGebaut (GlobaleDatentypen.Rassen (RasseNummer), EinheitNummer).AktuelleLebenspunkte
                       := EinheitenDatenbank.EinheitenListe (GlobaleDatentypen.Rassen (RasseNummer), GlobaleDatentypen.EinheitenID (EinheitID)).MaximaleLebenspunkte;
                     GlobaleVariablen.EinheitenGebaut (GlobaleDatentypen.Rassen (RasseNummer), EinheitNummer).AktuelleBewegungspunkte
                       := EinheitenDatenbank.EinheitenListe (GlobaleDatentypen.Rassen (RasseNummer), GlobaleDatentypen.EinheitenID (EinheitID)).MaximaleBewegungspunkte;
                     GlobaleVariablen.EinheitenGebaut (GlobaleDatentypen.Rassen (RasseNummer), EinheitNummer).AktuelleErfahrungspunkte := 0;
                     GlobaleVariablen.EinheitenGebaut (GlobaleDatentypen.Rassen (RasseNummer), EinheitNummer).AktuellerRang := 0;
                     GlobaleVariablen.EinheitenGebaut (GlobaleDatentypen.Rassen (RasseNummer), EinheitNummer).AktuelleBeschäftigungszeit := 0;
                     GlobaleVariablen.EinheitenGebaut (GlobaleDatentypen.Rassen (RasseNummer), EinheitNummer).AktuelleBeschäftigungszeitNachfolger := 0;
                     GlobaleVariablen.EinheitenGebaut (GlobaleDatentypen.Rassen (RasseNummer), EinheitNummer).KIZielKoordinaten := (0, 1, 1);
                     GlobaleVariablen.EinheitenGebaut (GlobaleDatentypen.Rassen (RasseNummer), EinheitNummer).KIBeschäftigt := KIDatentypen.Keine_Aufgabe;
                     return;
                     
                  when others =>
                     null;
               end case;

            end loop GelöschtEinheitenSchleife;
      end case;
      
   end EinheitFestlegen;
   
   
   
   procedure Geld
     (RasseExtern : in GlobaleDatentypen.Rassen)
   is begin
      
      GlobaleVariablen.Wichtiges (RasseExtern).AktuelleGeldmenge := Integer'Last;
      
   end Geld;
   
   

   procedure Technologie
     (RasseExtern : in GlobaleDatentypen.Rassen)
   is begin
      
      null;
      
   end Technologie;
   
   
   
   procedure VerbesserungFestlegen
     (RasseExtern : in GlobaleDatentypen.Rassen)
   is begin
      
      VerbesserungID := GlobaleDatentypen.KartenVerbesserung (Eingabe.GanzeZahl (TextDateiExtern     => GlobaleDatentypen.Cheat_Menü,
                                                                                 ZeileExtern         => 15,
                                                                                 ZahlenMinimumExtern => 5,
                                                                                 ZahlenMaximumExtern => Integer (VerbesserungenDatenbank.VerbesserungListe'Last)));

      case
        VerbesserungID
      is
         when 5 .. 19 =>
            Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse,
                              GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                              GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).VerbesserungStraße := VerbesserungID;

         when 20 .. 22 =>
            Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse,
                              GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                              GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).VerbesserungGebiet := VerbesserungID;
            
         when others =>
            null;
      end case;
      
   end VerbesserungFestlegen;



   procedure RassenverteilungÄndern
   is begin
      
      RassenverteilungÄndernSchleife:
      for RasseSchleifenwert in GlobaleDatentypen.Rassen'Range loop
         
         case
           GlobaleVariablen.RassenImSpiel (RasseSchleifenwert)
         is
            when 0 =>
               null;
               
            when others =>
               GlobaleVariablen.RassenImSpiel (RasseSchleifenwert) := GlobaleDatentypen.Rassen (Eingabe.GanzeZahl (TextDateiExtern     => GlobaleDatentypen.Cheat_Menü,
                                                                                                                   ZeileExtern         => 16,
                                                                                                                   ZahlenMinimumExtern => 1,
                                                                                                                   ZahlenMaximumExtern => 2));
         end case;
         
      end loop RassenverteilungÄndernSchleife;
      
   end RassenverteilungÄndern;
   
   
   
   procedure KarteInfosEinheiten
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      Put_Line (Item => "Aktuelle Rasse: " & EinheitRasseNummerExtern.Rasse'Wide_Wide_Image);
                     
      BewegungPlanSchleife:
      for BewegungGeplantSchleifenwert in GlobaleRecords.KIBewegungPlanArray'Range loop
                        
         Put_Line (Item => "EAchse: " & GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBewegungPlan (BewegungGeplantSchleifenwert).EAchse'Wide_Wide_Image
                   & "    " & "YAchse: " & GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBewegungPlan (BewegungGeplantSchleifenwert).YAchse'Wide_Wide_Image
                   & "    " & "XAchse: " & GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBewegungPlan (BewegungGeplantSchleifenwert).XAchse'Wide_Wide_Image);
                        
      end loop BewegungPlanSchleife;
                     
      Put_Line (Item => "Ziel EAchse: " & GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten.EAchse'Wide_Wide_Image & "    "
                & "Ziel YAchse: " & GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten.YAchse'Wide_Wide_Image & "    "
                & "Ziel XAchse: " & GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten.XAchse'Wide_Wide_Image);
                     
      Put_Line (Item => "KIAufgabe: " & GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBeschäftigt'Wide_Wide_Image);
      Put_Line (Item => "AufgabeEins: " & GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigung'Wide_Wide_Image);
      Put_Line (Item => "AufgabeZwei: " & GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AktuelleBeschäftigungNachfolger'Wide_Wide_Image);
      Put_Line (Item => "Aktuelles Forschungsprojekt: ");
      ForschungAllgemein.Beschreibung (IDExtern    => GlobaleVariablen.Wichtiges (EinheitRasseNummerExtern.Rasse).AktuellesForschungsprojekt,
                                        RasseExtern => EinheitRasseNummerExtern.Rasse);
      
   end KarteInfosEinheiten;
   
   
   
   procedure KarteInfosFeld
     (RasseExtern : in GlobaleDatentypen.Rassen)
   is begin
      
      Put (Item => "Aktuelle EPosition: " & GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse'Wide_Wide_Image);
      Put (Item => "    Aktuelle YPosition: " & GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse'Wide_Wide_Image);
      Put_Line (Item => "    Aktuelle XPosition: " & GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse'Wide_Wide_Image);
      Put (Item => "Kartenfeldbewertung: " & Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse, GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
           GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).Felderwertung'Wide_Wide_Image);
      Put_Line (Item => "    Aktuelle GrundID: " & Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse, GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).Grund'Wide_Wide_Image);
      Put_Line (Item => "Aktuelle Stadtbelegung: " & Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse, GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).DurchStadtBelegterGrund'Wide_Wide_Image);
      Put (Item => "Straße: " & Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse, GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
           GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).VerbesserungStraße'Wide_Wide_Image);
      Put_Line (Item => "    Feldverbesserung: " & Karten.Weltkarte (GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.EAchse, GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse,
                GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse).VerbesserungGebiet'Wide_Wide_Image);
      
   end KarteInfosFeld;
   
   
   
   procedure KarteStadtInfos
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      Put_Line (Item => "Aktuelle Rasse: " & StadtRasseNummerExtern.Rasse'Wide_Wide_Image);
      Put_Line (Item => "KIAufgabe: " & GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).KIAktuelleBeschäftigung'Wide_Wide_Image);
      Put_Line (Item => "Aktuelles Forschungsprojekt: ");
      ForschungAllgemein.Beschreibung (IDExtern    => GlobaleVariablen.Wichtiges (StadtRasseNummerExtern.Rasse).AktuellesForschungsprojekt,
                                        RasseExtern => StadtRasseNummerExtern.Rasse);
      
   end KarteStadtInfos;

end Cheat;
