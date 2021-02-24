pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO, Ada.Characters.Wide_Wide_Latin_9, Ada.Calendar;
use Ada.Wide_Wide_Text_IO, Ada.Characters.Wide_Wide_Latin_9, Ada.Calendar;

with GlobaleVariablen, ImSpiel, KartenGenerator, Eingabe, Auswahl, EinheitenDatenbank, Anzeige, ZufallsGeneratoren, Ladezeiten, KartenPruefungen, EinheitSuchen;

package body SpielEinstellungen is

   function SpielEinstellungen return Integer is
   begin

      Wahl := 1;

      AuswahlSchleife:
      loop

         case Wahl is
            when 1 =>
               Wahl := KartengrößeWählen;

            when 2 =>
               Wahl := KartenartWählen;

            when 3 =>            
               Wahl := KartentemperaturWählen;
               
            when 4 =>
               Wahl := SpieleranzahlWählen;

            when 5 =>
               Wahl := MenschlicheSpieleranzahl;

            when 6 =>
               exit AuswahlSchleife;

            when -1 | 0 =>
               return Wahl;

            when others =>
               null;
         end case;

      end loop AuswahlSchleife;

      KartenGenerator.KartenGenerator;
      
      Ladezeiten.LadezeitenSpielweltErstellenZeit (1, 12) := Clock;
      StartwerteErmitteln;
      Ladezeiten.LadezeitenSpielweltErstellenZeit (2, 12) := Clock;
      Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeit => 12);
      Ladezeiten.LadezeitenSpielweltErstellen (WelcheZeit => 1);
         
      return ImSpiel.ImSpiel;
              
   end SpielEinstellungen;



   function KartengrößeWählen return Integer is
   begin
      
      KartengrößeSchleife:
      loop
         
         Wahl := Auswahl.Auswahl (FrageDatei  => GlobaleDatentypen.Fragen,
                                  TextDatei   => GlobaleDatentypen.Spiel_Einstellungen,
                                  FrageZeile  => 1,
                                  ErsteZeile  => 2,
                                  LetzteZeile => 14);
         
         case Wahl is
            when 1 .. 9 =>
               Karten.Kartengröße := Wahl;
               return 2;

            when 10 =>
               Karten.Kartengröße := Wahl;
               Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDatei => GlobaleDatentypen.Fragen,
                                                     TextZeile => 19);

               BenutzerdefinierteGröße := Eingabe.GanzeZahl (WelcheDatei   => 0,
                                                               WelcherText   => 0,
                                                               ZahlenMinimum => 10,
                                                               ZahlenMaximum => 1_000);
               case BenutzerdefinierteGröße is
                  when -1 =>
                     return 1;
                     
                  when others =>
                     Karten.Kartengrößen (Wahl).YAchsenGröße := GlobaleDatentypen.KartenfeldPositiv (BenutzerdefinierteGröße);
                     BenutzerdefinierteGröße := Eingabe.GanzeZahl (WelcheDatei   => 0,
                                                                     WelcherText   => 0,
                                                                     ZahlenMinimum => 10,
                                                                     ZahlenMaximum => 1_000);
                     
                     case BenutzerdefinierteGröße is
                        when -1 =>
                           return 1;
                           
                        when others =>
                           Karten.Kartengrößen (Wahl).XAchsenGröße := GlobaleDatentypen.KartenfeldPositiv (BenutzerdefinierteGröße);
                           Karten.Kartengrößen (Wahl).Ressourcenmenge := Integer (Karten.Kartengrößen (Wahl).YAchsenGröße) * Integer (Karten.Kartengrößen (Wahl).XAchsenGröße) / 32;
                           return 2;
                     end case;
               end case;
               
            when 11 =>
               ZufälligeKartengrößeWählen.Reset (ZufälligeKartenGrößeGewählt);
               Karten.Kartengröße := ZufälligeKartengrößeWählen.Random (ZufälligeKartengrößeGewählt);
               return 2;

            when -1 | 0 =>
               return Wahl;
               
            when others =>
               null;
         end case;

         Put (Item => CSI & "2J" & CSI & "H");
                  
      end loop KartengrößeSchleife;
      
   end KartengrößeWählen;



   function KartenartWählen return Integer is
   begin
            
      KartenartSchleife:
      loop

         Wahl := Auswahl.Auswahl (FrageDatei  => GlobaleDatentypen.Fragen,
                                  TextDatei   => GlobaleDatentypen.Spiel_Einstellungen,
                                  FrageZeile  => 2,
                                  ErsteZeile  => 17,
                                  LetzteZeile => 25);
                  
         case Wahl is
            when 1 .. 5 =>
               KartenGenerator.Kartenart := Wahl;
               return 3;
               
            when 6 =>
               ZufälligeKartenartWählen.Reset (ZufälligeKartenartGewählt);
               KartenGenerator.Kartenart := ZufälligeKartenartWählen.Random (ZufälligeKartenartGewählt);
               return 3;
               
            when -2 =>
               return 1;

            when -1 | 0 =>
               return Wahl;
               
            when others =>
               null;
         end case;

         Put (Item => CSI & "2J" & CSI & "H");                  

      end loop KartenartSchleife;
      
   end KartenartWählen;



   function KartentemperaturWählen return Integer is
   begin
            
      KartentemperaturSchleife:
      loop

         Wahl := Auswahl.Auswahl (FrageDatei  => GlobaleDatentypen.Fragen,
                                  TextDatei   => GlobaleDatentypen.Spiel_Einstellungen,
                                  FrageZeile  => 3,
                                  ErsteZeile  => 28,
                                  LetzteZeile => 36);
                  
         case Wahl is
            when 1 .. 5 =>
               KartenGenerator.Kartentemperatur := Wahl;
               return 4;
               
            when 6 =>
               ZufälligeKartentemperaturWählen.Reset (ZufälligeKartentemperaturGewählt);
               KartenGenerator.Kartentemperatur := ZufälligeKartentemperaturWählen.Random (ZufälligeKartentemperaturGewählt);
               return 4;
               
            when -2 =>
               return 2;

            when -1 | 0 =>
               return Wahl;
               
            when others =>
               null;
         end case;

         Put (Item => CSI & "2J" & CSI & "H");
                  
      end loop KartentemperaturSchleife;
      
   end KartentemperaturWählen;



   function SpieleranzahlWählen return Integer is
   begin
      
      SpieleranzahlSchleife:
      loop

         Wahl := Auswahl.Auswahl (FrageDatei  => GlobaleDatentypen.Fragen,
                                  TextDatei   => GlobaleDatentypen.Spiel_Einstellungen,
                                  FrageZeile  => 4,
                                  ErsteZeile  => 39,
                                  LetzteZeile => 60);
         
         case Wahl is
            when 1 .. 18 =>
               SpielerAnzahl := Wahl;
               return 5;

            when 19 => 
               ZufälligeSpieleranzahlWählen.Reset (ZufälligeSpieleranzahlGewählt);
               SpielerAnzahl := ZufälligeSpieleranzahlWählen.Random (ZufälligeSpieleranzahlGewählt);
               return 5;
               
            when -2 =>
               return 3;

            when -1 | 0 =>
               return Wahl;
               
            when others =>
               null;
         end case;

         Put (Item => CSI & "2J" & CSI & "H");
         
      end loop SpieleranzahlSchleife;
      
   end SpielerAnzahlWählen;



   function MenschlicheSpieleranzahl return Integer is
   begin
      
      GlobaleVariablen.RassenImSpiel := (others => 0);
      Spieler := 0;

      SpielerSchleife:
      while Spieler < SpielerAnzahl loop
         
         Wert := RasseWählen;
         case Wert is                  
            when -2 =>
               return 4;

            when -1 | 0 =>
               return Wahl;
               
            when others =>
               null;
         end case;
         
         case GlobaleVariablen.RassenImSpiel (GlobaleDatentypen.Rassen (Wert))is
            when 0 =>
               Wahl := Auswahl.AuswahlJaNein (FrageZeile => 21);
         
               case Wahl is
                  when -3 =>
                     GlobaleVariablen.RassenImSpiel (GlobaleDatentypen.RassenMitNullwert (Wert)) := 1;
                     Spieler := Spieler + 1;
                     
                  when -4 =>
                     GlobaleVariablen.RassenImSpiel (GlobaleDatentypen.RassenMitNullwert (Wert)) := 2;
                     Spieler := Spieler + 1;

                  when others =>
                     null;
               end case;
               
            when others =>
               null;
         end case;

         Put (Item => CSI & "2J" & CSI & "H");
         
      end loop SpielerSchleife;

      return 6;

   end MenschlicheSpieleranzahl;


   
   function RasseWählen return Integer is -- 0 = Nicht belegt, 1 = Menschlicher Spieler, 2 = KI
   begin

      RasseSchleife:
      loop
         
         Wahl := Auswahl.Auswahl (FrageDatei  => GlobaleDatentypen.Fragen,
                                  TextDatei   => GlobaleDatentypen.Spiel_Einstellungen,
                                  FrageZeile  => 5,
                                  ErsteZeile  => 63,
                                  LetzteZeile => 84);

         case Wahl is
            when 1 .. 18 =>      
               Anzeige.AnzeigeLangerText (WelcherText => 7,
                                          WelcheZeile => Wahl);
               Wahl2 := Auswahl.AuswahlJaNein (FrageZeile => 6);
               case Wahl2 is
                  when -3 =>
                     return Wahl;
                     
                  when others =>
                     null;
               end case;

            when 19 =>
               ZufälligeRasseWählen.Reset (ZufälligeRasseGewählt);
               Zufallswahl := ZufälligeRasseWählen.Random (ZufälligeRasseGewählt);
               return Zufallswahl;

            when -2 .. 0 =>
               return Wahl;
               
            when others =>
               null;
         end case;               

         Put (Item => CSI & "2J" & CSI & "H");
         
      end loop RasseSchleife;
      
   end RasseWählen;



   procedure StartwerteErmitteln is
   begin
      
      SpieleranzahlWerteFestlegen:
      for RasseIntern in GlobaleVariablen.RassenImSpiel'Range loop
        
         case GlobaleVariablen.RassenImSpiel (RasseIntern) is
            when 0 =>
               null;
               
            when others =>
               SicherheitsTestWert := 0;
         
               StartwerteFestlegenSchleife:
               loop
                  
                  Koordinaten := ((0, 0, 0), (0, 0, 0));
                  GezogeneWerte := ZufallsGeneratoren.YXPosition;

                  PrüfungEinheit := UmgebungPrüfen (YPosition       => GezogeneWerte.YAchse,
                                                      XPosition       => GezogeneWerte.XAchse,
                                                      RasseExtern     => RasseIntern);

                  case PrüfungEinheit is
                     when True =>
                        exit StartwerteFestlegenSchleife;
                        
                     when False =>
                        SicherheitsTestWert := SicherheitsTestWert + 1;
                  end case;

                  case SicherheitsTestWert is
                     when 10_000 =>
                        Put_Line ("Keine geeignete Startposition für Rasse" & RasseIntern'Wide_Wide_Image & " gefunden!");
                        Put_Line ("Rasse wird entfernt. Wenden sie sich an den Entwickler.");
                        GlobaleVariablen.RassenImSpiel (RasseIntern) := 0;
                        delay 1.5;
                        exit StartwerteFestlegenSchleife;
                        
                     when others =>
                        null;
                  end case;
         
               end loop StartwerteFestlegenSchleife;
               
         end case;
         
      end loop SpieleranzahlWerteFestlegen;
      
   end StartwerteErmitteln;



   function UmgebungPrüfen (YPosition, XPosition : in GlobaleDatentypen.KartenfeldPositiv; RasseExtern : in GlobaleDatentypen.Rassen) return Boolean is
   begin
      
      PrüfungGrund := KartenPruefungen.KartenGrund (Koordinaten => (0, YPosition, XPosition));

      case PrüfungGrund is
         when False =>
            return False;
            
         when True =>
            PositionWert := EinheitSuchen.KoordinatenEinheitOhneRasseSuchen (Koordinaten => (0, YPosition, XPosition));
      end case;

      case PositionWert.Platznummer is
         when 0 =>
            Koordinaten (1) := (0, YPosition, XPosition);
            YAchseSchleife:
            for YÄnderung in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
               XAchseSchleife:
               for XÄnderung in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop

                  KartenWert := KartenPruefungen.KartenPositionBestimmen (Koordinaten    => (0, YPosition, XPosition),
                                                                          Änderung       => (0, YÄnderung, XÄnderung),
                                                                          ZusatzYAbstand => 0);
                  case KartenWert.Erfolgreich is
                     when False =>
                        exit XAchseSchleife;
                  
                     when True =>
                        if YÄnderung /= 0 or XÄnderung /= 0 then
                           PrüfungGrund := KartenPruefungen.KartenGrund (Koordinaten => (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse));

                           case PrüfungGrund is
                              when False =>
                                 PlatzBelegt := (1, 1);
            
                              when True =>
                                 PlatzBelegt := EinheitSuchen.KoordinatenEinheitOhneRasseSuchen (Koordinaten => (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse));
                           end case;                    
                           
                           case PlatzBelegt.Platznummer is
                              when 0 =>
                                 Koordinaten (2) := (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse);
                                 StartpunktFestlegen (RasseExtern => RasseExtern);
                                 return True;
                                 
                              when others =>
                                 null;
                           end case;
                                             
                        else
                           null;
                        end if;
                  end case;

               end loop XAchseSchleife;
            end loop YAchseSchleife;
                           
         when others =>
            null;
      end case;
         
      return False;
      
   end UmgebungPrüfen;



   procedure StartpunktFestlegen (RasseExtern : in GlobaleDatentypen.Rassen) is
   begin

      GlobaleVariablen.EinheitenGebaut (RasseExtern, 1).ID := 1;
      GlobaleVariablen.EinheitenGebaut (RasseExtern, 1).AchsenPosition.EAchse := Koordinaten (1).EAchse;
      GlobaleVariablen.EinheitenGebaut (RasseExtern, 1).AchsenPosition.YAchse := Koordinaten (1).YAchse;
      GlobaleVariablen.EinheitenGebaut (RasseExtern, 1).AchsenPosition.XAchse := Koordinaten (1).XAchse;
      EinheitenDatenbank.LebenspunkteBewegungspunkteAufMaximumSetzen (EinheitRasseNummer => (RasseExtern, 1));

      GlobaleVariablen.EinheitenGebaut (RasseExtern, 2).ID := 2;
      GlobaleVariablen.EinheitenGebaut (RasseExtern, 2).AchsenPosition.EAchse := Koordinaten (2).EAchse;
      GlobaleVariablen.EinheitenGebaut (RasseExtern, 2).AchsenPosition.YAchse := Koordinaten (2).YAchse;
      GlobaleVariablen.EinheitenGebaut (RasseExtern, 2).AchsenPosition.XAchse := Koordinaten (2).XAchse;
      EinheitenDatenbank.LebenspunkteBewegungspunkteAufMaximumSetzen (EinheitRasseNummer => (RasseExtern, 2));
      
      GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPosition := GlobaleVariablen.EinheitenGebaut (RasseExtern, 1).AchsenPosition;
      GlobaleVariablen.CursorImSpiel (RasseExtern).AchsenPositionAlt := GlobaleVariablen.EinheitenGebaut (RasseExtern, 1).AchsenPosition;
      
   end StartpunktFestlegen;

end SpielEinstellungen;
