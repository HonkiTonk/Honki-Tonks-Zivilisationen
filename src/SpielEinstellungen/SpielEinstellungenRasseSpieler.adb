pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO, Ada.Characters.Wide_Wide_Latin_9;
use Ada.Wide_Wide_Text_IO, Ada.Characters.Wide_Wide_Latin_9;

with GlobaleTexte, GlobaleKonstanten;

with LeseEinheitenGebaut;

with Auswahl, ZufallGeneratorenSpieleinstellungen, Anzeige, Eingabe, ZufallGeneratorenKarten, EinheitSuchen, KartePositionPruefen, BewegungPassierbarkeitPruefen, EinheitenErzeugenEntfernen;

package body SpielEinstellungenRasseSpieler is

   function SpieleranzahlWählen
     return Integer
   is begin
      
      SpieleranzahlSchleife:
      loop

         SpieleranzahlAuswahl := Auswahl.Auswahl (FrageDateiExtern  => GlobaleTexte.Spiel_Einstellungen,
                                                  TextDateiExtern   => GlobaleTexte.Spiel_Einstellungen,
                                                  FrageZeileExtern  => 35,
                                                  ErsteZeileExtern  => 36,
                                                  LetzteZeileExtern => 40);
         
         case
           SpieleranzahlAuswahl
         is
            when 1 =>
               SpielerAnzahl := Eingabe.GanzeZahl (TextDateiExtern     => GlobaleTexte.Fragen,
                                                   ZeileExtern         => 1,
                                                   ZahlenMinimumExtern => 1,
                                                   ZahlenMaximumExtern => 18);
               if
                 SpielerAnzahl in 1 .. 18
               then
                  return GlobaleKonstanten.AuswahlBelegung;
                  
               else
                  null;
               end if;

            when 2 =>
               SpielerAnzahl := ZufallGeneratorenSpieleinstellungen.ZufälligeSpieleranzahl;
               return GlobaleKonstanten.AuswahlBelegung;
               
            when GlobaleKonstanten.ZurückKonstante =>
               return GlobaleKonstanten.AuswahlKartenressourcen;

            when GlobaleKonstanten.SpielBeendenKonstante | GlobaleKonstanten.HauptmenüKonstante =>
               return SpieleranzahlAuswahl;
               
            when others =>
               null;
         end case;

         Put (Item => CSI & "2J" & CSI & "H");
         
      end loop SpieleranzahlSchleife;
      
   end SpieleranzahlWählen;



   function SpielerbelegungWählen
     return Integer
   is begin
      
      GlobaleVariablen.RassenImSpiel := (others => GlobaleDatentypen.Leer);
      Spieler := 0;

      SpielerSchleife:
      while Spieler < SpielerAnzahl loop
         
         SpielerartAuswahl := RasseWählen;
         
         case
           SpielerartAuswahl
         is
            when GlobaleKonstanten.ZurückKonstante =>
               return GlobaleKonstanten.AuswahlSpieleranzahl;

            when GlobaleKonstanten.SpielBeendenKonstante | GlobaleKonstanten.HauptmenüKonstante =>
               return SpielerartAuswahl;
               
            when others =>
               null;
         end case;
         
         if
           SpielerartAuswahl = RasseEntfernen
         then
            null;
            
         else
            case
              GlobaleVariablen.RassenImSpiel (GlobaleDatentypen.Rassen_Verwendet_Enum'Val (SpielerartAuswahl))
            is
               when GlobaleDatentypen.Leer =>
                  if
                    Auswahl.AuswahlJaNein (FrageZeileExtern => 21) = GlobaleKonstanten.JaKonstante
                  then
                     GlobaleVariablen.RassenImSpiel (GlobaleDatentypen.Rassen_Verwendet_Enum'Val (SpielerartAuswahl)) := GlobaleDatentypen.Spieler_Mensch;
                     Spieler := Spieler + 1;
                     
                  else
                     GlobaleVariablen.RassenImSpiel (GlobaleDatentypen.Rassen_Verwendet_Enum'Val (SpielerartAuswahl)) := GlobaleDatentypen.Spieler_KI;
                     Spieler := Spieler + 1;
                  end if;
               
               when others =>
                  null;
            end case;
         end if;

         Put (Item => CSI & "2J" & CSI & "H");
         
      end loop SpielerSchleife;

      return GlobaleKonstanten.AuswahlSchwierigkeitsgrad;

   end SpielerbelegungWählen;
   

   
   function RasseWählen
     return Integer
   is begin

      RasseSchleife:
      loop
         
         RassenAuswahl := Auswahl.Auswahl (FrageDateiExtern  => GlobaleTexte.Spiel_Einstellungen,
                                           TextDateiExtern   => GlobaleTexte.Spiel_Einstellungen,
                                           FrageZeileExtern  => 41,
                                           ErsteZeileExtern  => 42,
                                           LetzteZeileExtern => 63);

         case
           RassenAuswahl
         is
            when 1 .. 18 =>
               if
                 GlobaleVariablen.RassenImSpiel (GlobaleDatentypen.Rassen_Verwendet_Enum'Val (RassenAuswahl)) = GlobaleDatentypen.Leer
               then
                  Anzeige.AnzeigeLangerTextNeu (ÜberschriftDateiExtern => GlobaleTexte.Spiel_Einstellungen,
                                                TextDateiExtern        => GlobaleTexte.Rassen_Beschreibung_Lang,
                                                ÜberschriftZeileExtern => RassenAuswahl + 41,
                                                ErsteZeileExtern       => RassenAuswahl,
                                                AbstandAnfangExtern    => GlobaleTexte.Leer,
                                                AbstandEndeExtern      => GlobaleTexte.Leer);
                  Eingabe.WartenEingabe;
               
                  case
                    Auswahl.AuswahlJaNein (FrageZeileExtern => 6)
                  is
                     when GlobaleKonstanten.JaKonstante =>
                        return RassenAuswahl;
                     
                     when others =>
                        null;
                  end case;
                  
               else
                  case
                    Auswahl.AuswahlJaNein (FrageZeileExtern => 32)
                  is
                     when GlobaleKonstanten.JaKonstante =>
                        GlobaleVariablen.RassenImSpiel (GlobaleDatentypen.Rassen_Verwendet_Enum'Val (RassenAuswahl)) := GlobaleDatentypen.Leer;
                        Spieler := Spieler - 1;
                        return RasseEntfernen;
                     
                     when others =>
                        null;
                  end case;
               end if;

            when 19 =>
               return GlobaleDatentypen.Rassen_Verwendet_Enum'Pos (ZufallGeneratorenSpieleinstellungen.ZufälligeRasse);

            when GlobaleKonstanten.ZurückKonstante | GlobaleKonstanten.SpielBeendenKonstante | GlobaleKonstanten.HauptmenüKonstante =>
               return RassenAuswahl;
               
            when others =>
               null;
         end case;

         Put (Item => CSI & "2J" & CSI & "H");
         
      end loop RasseSchleife;
      
   end RasseWählen;



   procedure StartwerteErmitteln
   is begin
      
      SpieleranzahlWerteFestlegen:
      for RasseSchleifenwert in GlobaleDatentypen.Rassen_Verwendet_Enum'Range loop
        
         case
           GlobaleVariablen.RassenImSpiel (RasseSchleifenwert)
         is
            when GlobaleDatentypen.Leer =>
               null;
               
            when others =>
               StartwerteFestlegenSchleife:
               for NotAusSchleifenwert in GlobaleDatentypen.NotAus'Range loop
                  
                  StartKoordinaten := ((0, 0, 0), (0, 0, 0));
                  GezogeneWerte := ZufallGeneratorenKarten.StartPosition (RasseSchleifenwert);

                  exit StartwerteFestlegenSchleife when UmgebungPrüfen (PositionExtern => GezogeneWerte,
                                                                         RasseExtern    => RasseSchleifenwert);

                  case
                    NotAusSchleifenwert
                  is
                     when GlobaleDatentypen.NotAus'Last =>
                        Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleTexte.Fehlermeldungen,
                                                              TextZeileExtern => 16);
                        Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleTexte.Rassen_Beschreibung_Kurz,
                                                              TextZeileExtern => GlobaleDatentypen.Rassen_Verwendet_Enum'Pos (RasseSchleifenwert));
                        Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleTexte.Fehlermeldungen,
                                                              TextZeileExtern => 17);
                        GlobaleVariablen.RassenImSpiel (RasseSchleifenwert) := GlobaleDatentypen.Leer;
                        
                     when others =>
                        null;
                  end case;
         
               end loop StartwerteFestlegenSchleife;
         end case;
         
      end loop SpieleranzahlWerteFestlegen;
      
   end StartwerteErmitteln;



   function UmgebungPrüfen
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return Boolean
   is begin

      FreieFelder := 0;
      
      case
        EinheitSuchen.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => PositionExtern).Platznummer
      is
         when GlobaleKonstanten.LeerEinheitStadtNummer =>
            StartKoordinaten (1) := PositionExtern;
            FelderBestimmen (PositionExtern => PositionExtern,
                             RasseExtern    => RasseExtern);
                           
         when others =>
            null;
      end case;
         
      if
        FreieFelder >= 3
      then
         StartpunktFestlegen (RasseExtern => RasseExtern);
         return True;
               
      else
         return False;
      end if;
      
   end UmgebungPrüfen;
   
   
   
   procedure FelderBestimmen
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
   is begin
            
      StartpositionGefunden := False;
      
      YAchseSchleife:
      for YÄnderungSchleifenwert in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
         XAchseSchleife:
         for XÄnderungSchleifenwert in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop

            KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => PositionExtern,
                                                                        ÄnderungExtern    => (0, YÄnderungSchleifenwert, XÄnderungSchleifenwert));
                  
            if
              KartenWert.XAchse = GlobaleKonstanten.LeerYXKartenWert
            then
               null;
                     
            elsif
              YÄnderungSchleifenwert = 0
              and
                XÄnderungSchleifenwert = 0
            then
               null;
                     
            elsif
              BewegungPassierbarkeitPruefen.PassierbarkeitPrüfenID (RasseExtern        => RasseExtern,
                                                                     IDExtern           => 2,
                                                                     NeuePositionExtern => KartenWert)
              = False
            then
               null;
                     
            elsif
              StartpositionGefunden = False
            then
               case
                 EinheitSuchen.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => KartenWert).Platznummer
               is
                  when GlobaleKonstanten.LeerEinheitStadtNummer =>
                     StartKoordinaten (2) := KartenWert;
                     StartpositionGefunden := True;
                     FreieFelder := FreieFelder + 1;
                                 
                  when others =>
                     null;
               end case;
                     
            else
               FreieFelder := FreieFelder + 1;
            end if;

         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end FelderBestimmen;



   procedure StartpunktFestlegen
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
   is begin

      EinheitenErzeugenEntfernen.EinheitErzeugen (KoordinatenExtern      => StartKoordinaten (1),
                                                  EinheitNummerExtern    => 1,
                                                  IDExtern               => 1,
                                                  StadtRasseNummerExtern => (RasseExtern, 0));
      
      EinheitenErzeugenEntfernen.EinheitErzeugen (KoordinatenExtern      => StartKoordinaten (2),
                                                  EinheitNummerExtern    => 2,
                                                  IDExtern               => 2,
                                                  StadtRasseNummerExtern => (RasseExtern, 0));
      
      GlobaleVariablen.CursorImSpiel (RasseExtern).Position := LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => (RasseExtern, 1));
      GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt := GlobaleVariablen.CursorImSpiel (RasseExtern).Position;
      
   end StartpunktFestlegen;

end SpielEinstellungenRasseSpieler;
