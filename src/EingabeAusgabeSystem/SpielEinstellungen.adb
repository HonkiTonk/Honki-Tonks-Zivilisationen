pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO, Ada.Characters.Wide_Wide_Latin_9, Ada.Calendar;
use Ada.Wide_Wide_Text_IO, Ada.Characters.Wide_Wide_Latin_9, Ada.Calendar;

with GlobaleKonstanten;

with ImSpiel, KartenGenerator, Eingabe, Auswahl, EinheitenDatenbank, Anzeige, ZufallsGeneratoren, Ladezeiten, KartenPruefungen, EinheitSuchen;

package body SpielEinstellungen is

   function SpielEinstellungen return Integer is
   begin

      HauptAuswahl := 1;

      AuswahlSchleife:
      loop

         case HauptAuswahl is
            when 1 =>
               HauptAuswahl := KartengrößeWählen;

            when 2 =>
               HauptAuswahl := KartenartWählen;

            when 3 =>            
               HauptAuswahl := KartentemperaturWählen;
               
            when 4 =>
               HauptAuswahl := SpieleranzahlWählen;

            when 5 =>
               HauptAuswahl := MenschlicheSpieleranzahl;

            when 6 =>
               HauptAuswahl := SchwierigkeitsgradFestlegen;
               
            when 7 =>
               exit AuswahlSchleife;

            when GlobaleKonstanten.SpielBeendenKonstante | GlobaleKonstanten.HauptmenüKonstante =>
               return HauptAuswahl;

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
         
         KartengrößeAuswahl := Auswahl.Auswahl (FrageDatei  => GlobaleDatentypen.Fragen,
                                                  TextDatei   => GlobaleDatentypen.Spiel_Einstellungen,
                                                  FrageZeile  => 1,
                                                  ErsteZeile  => 2,
                                                  LetzteZeile => 14);
         
         case KartengrößeAuswahl is
            when 1 .. 9 =>
               Karten.Kartengröße := KartengrößeAuswahl;
               return 2;

            when 10 =>
               Karten.Kartengröße := KartengrößeAuswahl;
               BenutzerdefinierteGröße := Eingabe.GanzeZahl (TextDatei     => GlobaleDatentypen.Fragen,
                                                               Zeile         => 19,
                                                               ZahlenMinimum => 20,
                                                               ZahlenMaximum => 1_000);
               case BenutzerdefinierteGröße is
                  when GlobaleKonstanten.GanzeZahlAbbruchKonstante =>
                     return 1;
                     
                  when others =>
                     null;
               end case;
               Karten.Kartengrößen (KartengrößeAuswahl).YAchsenGröße := GlobaleDatentypen.KartenfeldPositiv (BenutzerdefinierteGröße);
               BenutzerdefinierteGröße := Eingabe.GanzeZahl (TextDatei     => GlobaleDatentypen.Fragen,
                                                               Zeile         => 25,
                                                               ZahlenMinimum => 20,
                                                               ZahlenMaximum => 1_000);
                     
               case BenutzerdefinierteGröße is
                  when GlobaleKonstanten.GanzeZahlAbbruchKonstante =>
                     return 1;
                           
                  when others =>
                     Karten.Kartengrößen (KartengrößeAuswahl).XAchsenGröße := GlobaleDatentypen.KartenfeldPositiv (BenutzerdefinierteGröße);
                     Karten.Kartengrößen (KartengrößeAuswahl).Ressourcenmenge := Integer (Karten.Kartengrößen (KartengrößeAuswahl).YAchsenGröße) * Integer (Karten.Kartengrößen (KartengrößeAuswahl).XAchsenGröße) / 32;
                     return 2;
               end case;
               
            when 11 =>               
               Karten.Kartengröße := ZufallsGeneratoren.Spieleinstellungen (WelcheEinstellung => 1);
               return 2;

            when GlobaleKonstanten.SpielBeendenKonstante | GlobaleKonstanten.HauptmenüKonstante =>
               return KartengrößeAuswahl;
               
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

         KartenartAuswahl := Auswahl.Auswahl (FrageDatei  => GlobaleDatentypen.Fragen,
                                              TextDatei   => GlobaleDatentypen.Spiel_Einstellungen,
                                              FrageZeile  => 2,
                                              ErsteZeile  => 17,
                                              LetzteZeile => 25);
                  
         case KartenartAuswahl is
         when 1 .. 5 =>
            KartenGenerator.Kartenart := KartenartAuswahl;
            return 3;
               
         when 6 =>               
            KartenGenerator.Kartenart := ZufallsGeneratoren.Spieleinstellungen (WelcheEinstellung => 2);
            return 3;
               
         when -2 =>
            return 1;

         when GlobaleKonstanten.SpielBeendenKonstante | GlobaleKonstanten.HauptmenüKonstante =>
            return KartenartAuswahl;
               
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

         KartentemperaturAuswahl := Auswahl.Auswahl (FrageDatei  => GlobaleDatentypen.Fragen,
                                                     TextDatei   => GlobaleDatentypen.Spiel_Einstellungen,
                                                     FrageZeile  => 3,
                                                     ErsteZeile  => 28,
                                                     LetzteZeile => 36);
                  
         case KartentemperaturAuswahl is
            when 1 .. 5 =>
               KartenGenerator.Kartentemperatur := KartentemperaturAuswahl;
               return 4;
               
            when 6 =>               
               KartenGenerator.Kartentemperatur := ZufallsGeneratoren.Spieleinstellungen (WelcheEinstellung => 3);
               return 4;
               
            when -2 =>
               return 2;

            when GlobaleKonstanten.SpielBeendenKonstante | GlobaleKonstanten.HauptmenüKonstante =>
               return KartentemperaturAuswahl;
               
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

         SpieleranzahlAuswahl := Auswahl.Auswahl (FrageDatei  => GlobaleDatentypen.Fragen,
                                                  TextDatei   => GlobaleDatentypen.Spiel_Einstellungen,
                                                  FrageZeile  => 4,
                                                  ErsteZeile  => 39,
                                                  LetzteZeile => 60);
         
         case SpieleranzahlAuswahl is
            when 1 .. 18 =>
               SpielerAnzahl := SpieleranzahlAuswahl;
               return 5;

            when 19 =>               
               SpielerAnzahl := ZufallsGeneratoren.Spieleinstellungen (WelcheEinstellung => 4);
               return 5;
               
            when -2 =>
               return 3;

            when GlobaleKonstanten.SpielBeendenKonstante | GlobaleKonstanten.HauptmenüKonstante =>
               return SpieleranzahlAuswahl;
               
            when others =>
               null;
         end case;

         Put (Item => CSI & "2J" & CSI & "H");
         
      end loop SpieleranzahlSchleife;
      
   end SpieleranzahlWählen;



   function MenschlicheSpieleranzahl return Integer is
   begin
      
      GlobaleVariablen.RassenImSpiel := (others => 0);
      Spieler := 0;

      SpielerSchleife:
      while Spieler < SpielerAnzahl loop
         
         SpielerartAuswahl := RasseWählen;
         case SpielerartAuswahl is                  
            when -2 =>
               return 4;

            when GlobaleKonstanten.SpielBeendenKonstante | GlobaleKonstanten.HauptmenüKonstante =>
               return SpielerartAuswahl;
               
            when others =>
               null;
         end case;
         
         case GlobaleVariablen.RassenImSpiel (GlobaleDatentypen.Rassen (SpielerartAuswahl))is
            when 0 =>
               JaOderNein := Auswahl.AuswahlJaNein (FrageZeile => 21);
         
               case JaOderNein is
                  when GlobaleKonstanten.JaKonstante =>
                     GlobaleVariablen.RassenImSpiel (GlobaleDatentypen.RassenMitNullwert (SpielerartAuswahl)) := 1;
                     Spieler := Spieler + 1;
                     
                  when GlobaleKonstanten.NeinKonstante =>
                     GlobaleVariablen.RassenImSpiel (GlobaleDatentypen.RassenMitNullwert (SpielerartAuswahl)) := 2;
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
         
         RassenAuswahl := Auswahl.Auswahl (FrageDatei  => GlobaleDatentypen.Fragen,
                                           TextDatei   => GlobaleDatentypen.Spiel_Einstellungen,
                                           FrageZeile  => 5,
                                           ErsteZeile  => 63,
                                           LetzteZeile => 84);

         case RassenAuswahl is
            when 1 .. 18 =>
               Anzeige.AnzeigeLangerTextNeu (ÜberschriftDatei => GlobaleDatentypen.Spiel_Einstellungen,
                                             TextDatei        => GlobaleDatentypen.Rassen_Beschreibung_Lang,
                                             ÜberschriftZeile => RassenAuswahl + 62,
                                             ErsteZeile       => RassenAuswahl,
                                             LetzteZeile      => RassenAuswahl,
                                             AbstandAnfang    => GlobaleDatentypen.Keiner,
                                             AbstandEnde      => GlobaleDatentypen.Keiner);
               Get_Immediate (Taste);
               JaOderNein := Auswahl.AuswahlJaNein (FrageZeile => 6);
               case JaOderNein is
                  when GlobaleKonstanten.JaKonstante =>
                     return RassenAuswahl;
                     
                  when others =>
                     null;
               end case;

            when 19 =>               
               Zufallswahl := ZufallsGeneratoren.Spieleinstellungen (WelcheEinstellung => 5);
               return Zufallswahl;

            when -2 .. 0 =>
               return RassenAuswahl;
               
            when others =>
               null;
         end case;               

         Put (Item => CSI & "2J" & CSI & "H");
         
      end loop RasseSchleife;
      
   end RasseWählen;



   procedure StartwerteErmitteln is
   begin
      
      SpieleranzahlWerteFestlegen:
      for RasseIntern in GlobaleDatentypen.Rassen loop
        
         case GlobaleVariablen.RassenImSpiel (RasseIntern) is
            when 0 =>
               null;
               
            when others =>
               SicherheitsTestWert := 0;
         
               StartwerteFestlegenSchleife:
               loop
                  
                  Koordinaten := ((0, 0, 0), (0, 0, 0));
                  GezogeneWerte := ZufallsGeneratoren.YXPosition;

                  PrüfungEinheit := UmgebungPrüfen (YPosition   => GezogeneWerte.YAchse,
                                                      XPosition   => GezogeneWerte.XAchse,
                                                      RasseExtern => RasseIntern);

                  case PrüfungEinheit is
                     when True =>
                        exit StartwerteFestlegenSchleife;
                        
                     when False =>
                        SicherheitsTestWert := SicherheitsTestWert + 1;
                  end case;

                  case SicherheitsTestWert is
                     when 10_000 =>
                        Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDatei => GlobaleDatentypen.Fehlermeldungen,
                                                              TextZeile => 16);
                        Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDatei => GlobaleDatentypen.Rassen_Beschreibung_Kurz,
                                                              TextZeile => Positive (RasseIntern));
                        Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDatei => GlobaleDatentypen.Fehlermeldungen,
                                                              TextZeile => 17);
                        GlobaleVariablen.RassenImSpiel (RasseIntern) := 0;
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
                        null;
                  end case;
                  
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



   function SchwierigkeitsgradFestlegen return Integer is
   begin
      
      SpieleranzahlSchleife:
      loop

         SchwierigkeitAuswahl := Auswahl.Auswahl (FrageDatei  => GlobaleDatentypen.Fragen,
                                                  TextDatei   => GlobaleDatentypen.Spiel_Einstellungen,
                                                  FrageZeile  => 26,
                                                  ErsteZeile  => 87,
                                                  LetzteZeile => 93);
         
         case SchwierigkeitAuswahl is
         when 1 .. 3 =>
            GlobaleVariablen.Schwierigkeitsgrad := SchwierigkeitAuswahl;
            return 7;

         when 4 =>
            GlobaleVariablen.Schwierigkeitsgrad := ZufallsGeneratoren.Spieleinstellungen (WelcheEinstellung => 6);
            return 7;
               
         when -2 =>
            return 5;

         when GlobaleKonstanten.SpielBeendenKonstante | GlobaleKonstanten.HauptmenüKonstante =>
            return SchwierigkeitAuswahl;
               
         when others =>
            null;
         end case;

         Put (Item => CSI & "2J" & CSI & "H");
         
      end loop SpieleranzahlSchleife;
      
   end SchwierigkeitsgradFestlegen;

end SpielEinstellungen;
