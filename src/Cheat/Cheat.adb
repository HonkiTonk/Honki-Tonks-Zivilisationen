pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO, Ada.Wide_Wide_Characters.Handling;
use Ada.Wide_Wide_Text_IO, Ada.Wide_Wide_Characters.Handling;

with GlobaleKonstanten, KIDatentypen;

with Karte, Karten, EinheitenDatenbank, Anzeige, Eingabe, EinheitSuchen, VerbesserungenDatenbank;

package body Cheat is

   procedure Menü (RasseExtern : in GlobaleDatentypen.Rassen) is
   begin
      
      MenüSchleife:
      loop

         Anzeige.AnzeigeOhneAuswahlNeu (ÜberschriftDatei => GlobaleDatentypen.Cheat_Menü,
                                        TextDatei        => GlobaleDatentypen.Cheat_Menü,
                                        ÜberschriftZeile => 1,
                                        ErsteZeile       => 2,
                                        LetzteZeile      => 11,
                                        AbstandAnfang    => GlobaleDatentypen.Keiner,
                                        AbstandMitte     => GlobaleDatentypen.Neue_Zeile,
                                        AbstandEnde      => GlobaleDatentypen.Neue_Zeile);
         Get_Immediate (Item => Taste);

         case To_Lower (Item => Taste) is               
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


   procedure BeliebigeNächsteEinheit (RasseExtern : in GlobaleDatentypen.Rassen) is
   begin
      
      EinheitenSchleife:
      loop         
         
         if GlobaleVariablen.EinheitenGebaut (AktuelleRasseEinheit, AktuelleEinheit).ID = 0 then
            case AktuelleRasseEinheit is
               when GlobaleDatentypen.Rassen'Last =>
                  AktuelleRasseEinheit := GlobaleDatentypen.Rassen'First;
                    
               when others =>
                  AktuelleRasseEinheit := AktuelleRasseEinheit + 1;
            end case;
            AktuelleEinheit := 1;
            
         else
            GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse := GlobaleVariablen.EinheitenGebaut (AktuelleRasseEinheit, AktuelleEinheit).AchsenPosition.YAchse;
            GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse := GlobaleVariablen.EinheitenGebaut (AktuelleRasseEinheit, AktuelleEinheit).AchsenPosition.XAchse;
            case AktuelleEinheit is
               when GlobaleVariablen.EinheitenGebaut'Last (2) =>
                  case AktuelleRasseEinheit is
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



   procedure BeliebigeNächsteStadt (RasseExtern : in GlobaleDatentypen.Rassen) is
   begin
      
      StädteSchleife:
      loop         
         
         if GlobaleVariablen.StadtGebaut (AktuelleRasseStadt, AktuelleStadt).ID = 0 then
            case AktuelleRasseStadt is
               when GlobaleDatentypen.Rassen'Last =>
                  AktuelleRasseStadt := GlobaleDatentypen.Rassen'First;
                    
               when others =>
                  AktuelleRasseStadt := AktuelleRasseStadt + 1;
            end case;
            AktuelleStadt := 1;
            
         else
            GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.YAchse := GlobaleVariablen.StadtGebaut (AktuelleRasseStadt, AktuelleStadt).AchsenPosition.YAchse;
            GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition.XAchse := GlobaleVariablen.StadtGebaut (AktuelleRasseStadt, AktuelleStadt).AchsenPosition.XAchse;
            case AktuelleStadt is
               when GlobaleVariablen.StadtGebaut'Last (2) =>
                  case AktuelleRasseStadt is
                     when GlobaleDatentypen.Rassen'Last =>
                        AktuelleRasseStadt := GlobaleDatentypen.Rassen'First;
                    
                     when others =>
                        AktuelleRasseStadt := AktuelleRasseStadt + 1;
                  end case;
                  AktuelleStadt := AktuelleStadt + 1;
                     
               when others =>
                  AktuelleStadt := AktuelleStadt + 1;
            end case;
            return;
         end if;
         
      end loop StädteSchleife;
      
   end BeliebigeNächsteStadt;



   procedure Informationen is
   begin
      
      GlobaleVariablen.FeindlicheInformationenSehen := not GlobaleVariablen.FeindlicheInformationenSehen;
   
   end Informationen;



   procedure Sichtbarkeit (RasseExtern : in GlobaleDatentypen.Rassen) is
   begin
      
      EbeneSchleife:
      for EAchse in Karten.WeltkarteArray'Range (1) loop
         YAchseSchleife:
         for YAchse in Karten.WeltkarteArray'First (2) .. Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße loop
            XAchseSchleife:
            for XAchse in Karten.WeltkarteArray'First (3) .. Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße loop
            
               Karten.Weltkarte (EAchse, YAchse, XAchse).Sichtbar (RasseExtern) := True;
               
            end loop XAchseSchleife;
         end loop YAchseSchleife;
      end loop EbeneSchleife;
      
   end Sichtbarkeit;



   procedure GrundFestlegen (RasseExtern : in GlobaleDatentypen.Rassen) is
   begin
      
      KartenGrundID := GlobaleDatentypen.KartenGrund (Eingabe.GanzeZahl (TextDatei     => GlobaleDatentypen.Cheat_Menü,
                                                                         Zeile         => 12,
                                                                         ZahlenMinimum => 1,
                                                                         ZahlenMaximum => 42));

      case KartenGrundID is
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
   
   
   
   procedure EinheitFestlegen (RasseExtern : in GlobaleDatentypen.Rassen) is
   begin

      RasseNummer := Eingabe.GanzeZahl (TextDatei     => GlobaleDatentypen.Cheat_Menü,
                                        Zeile         => 13,
                                        ZahlenMinimum => Integer (GlobaleDatentypen.Rassen'First),
                                        ZahlenMaximum => Integer (GlobaleDatentypen.Rassen'Last));

      case RasseNummer is
         when GlobaleKonstanten.GanzeZahlAbbruchKonstante =>
            return;
            
         when others =>
            null;
      end case;

      EinheitID := Eingabe.GanzeZahl (TextDatei     => GlobaleDatentypen.Cheat_Menü,
                                      Zeile         => 14,
                                      ZahlenMinimum => Integer (EinheitenDatenbank.EinheitenListe'First (2)),
                                      ZahlenMaximum => Integer (EinheitenDatenbank.EinheitenListe'Last (2)));

      case EinheitID is
         when GlobaleKonstanten.GanzeZahlAbbruchKonstante =>
            return;
            
         when others =>
            null;
      end case;

      EinheitPosition := EinheitSuchen.KoordinatenEinheitOhneRasseSuchen (Koordinaten => GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition);
      
      case EinheitPosition.Platznummer is
         when GlobaleKonstanten.RückgabeEinheitStadtNummerFalsch =>
            EinheitenSchleife:
            for EinheitNummer in GlobaleVariablen.EinheitenGebautArray'Range (2) loop

               case GlobaleVariablen.EinheitenGebaut (GlobaleDatentypen.Rassen (RasseNummer), EinheitNummer).ID is
                  when 0 =>
                     GlobaleVariablen.EinheitenGebaut (GlobaleDatentypen.Rassen (RasseNummer), EinheitNummer).AktuelleBeschäftigung := 0;
                     GlobaleVariablen.EinheitenGebaut (GlobaleDatentypen.Rassen (RasseNummer), EinheitNummer).AktuelleBeschäftigungNachfolger := 0;
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
            EinheitenDatenbank.EinheitEntfernenMitSortieren (EinheitRasseNummer => EinheitPosition);
            GelöschtEinheitenSchleife:
            for EinheitNummer in GlobaleVariablen.EinheitenGebautArray'Range (2) loop

               case GlobaleVariablen.EinheitenGebaut (GlobaleDatentypen.Rassen (RasseNummer), EinheitNummer).ID is
                  when 0 =>
                     GlobaleVariablen.EinheitenGebaut (GlobaleDatentypen.Rassen (RasseNummer), EinheitNummer).AktuelleBeschäftigung := 0;
                     GlobaleVariablen.EinheitenGebaut (GlobaleDatentypen.Rassen (RasseNummer), EinheitNummer).AktuelleBeschäftigungNachfolger := 0;
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
   
   
   
   procedure Geld (RasseExtern : in GlobaleDatentypen.Rassen) is
   begin
      
      GlobaleVariablen.Wichtiges (RasseExtern).AktuelleGeldmenge := Integer'Last;
      
   end Geld;
   
   
   
   procedure Technologie (RasseExtern : in GlobaleDatentypen.Rassen) is
   begin
      
      null;
      
   end Technologie;
   
   
   
   procedure VerbesserungFestlegen (RasseExtern : in GlobaleDatentypen.Rassen) is
   begin
      
      VerbesserungID := GlobaleDatentypen.KartenVerbesserung (Eingabe.GanzeZahl (TextDatei     => GlobaleDatentypen.Cheat_Menü,
                                                                                 Zeile         => 15,
                                                                                 ZahlenMinimum => 5,
                                                                                 ZahlenMaximum => Integer (VerbesserungenDatenbank.VerbesserungListe'Last)));

      case VerbesserungID is
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



   procedure RassenverteilungÄndern is
   begin
      
      RassenverteilungÄndernSchleife:
      for Rasse in GlobaleDatentypen.Rassen'Range loop
         
         case GlobaleVariablen.RassenImSpiel (Rasse) is
            when 0 =>
               null;
               
            when others =>
               GlobaleVariablen.RassenImSpiel (Rasse) := GlobaleDatentypen.Rassen (Eingabe.GanzeZahl (TextDatei     => GlobaleDatentypen.Cheat_Menü,
                                                                                                      Zeile         => 16,
                                                                                                      ZahlenMinimum => 1,
                                                                                                      ZahlenMaximum => 2));
         end case;
         
      end loop RassenverteilungÄndernSchleife;
      
   end RassenverteilungÄndern;

end Cheat;
