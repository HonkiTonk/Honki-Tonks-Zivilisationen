pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenKonstanten;
with EinheitenKonstanten;

with LeseEinheitenGebaut;

with ZufallGeneratorenSpieleinstellungen;
with ZufallGeneratorenKarten;
with EinheitSuchen;
with KarteKoordinatenPruefen;
with BewegungPassierbarkeitPruefen;
with EinheitenErzeugenEntfernen;
with AuswahlMenues;
with Fehler;

package body SpieleinstellungenRasseSpieler is
   
   procedure RassenWählen
   is begin
      
      GlobaleVariablen.RassenImSpiel := (others => SystemDatentypen.Leer_Spieler_Enum);

      RasseSchleife:
      loop
         
         RassenAuswahl := AuswahlMenues.AuswahlMenüsAufteilung (WelchesMenüExtern => SystemDatentypen.Rassen_Menü_Enum);

         case
           RassenAuswahl
         is
            when SystemDatentypen.Rassen_Verwendet_Enum'Range =>
               BelegungÄndern (RasseExtern => RassenAuswahl);

            when SystemDatentypen.Zufall_Enum =>
               ZufallGeneratorenSpieleinstellungen.ZufälligeRassen;
               
            when SystemDatentypen.Fertig_Enum =>
               if
                 EineRasseBelegt = True
               then
                  return;
                  
               else
                  null;
               end if;
               
            when others =>
               Fehler.LogikFehler (FehlermeldungExtern => "SpielEinstellungenRasseSpieler.RassenWählen - Ungültige Menüauswahl.");
         end case;
         
      end loop RasseSchleife;
      
   end RassenWählen;
   
   
   
   procedure BelegungÄndern
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      if
        GlobaleVariablen.RassenImSpiel (RasseExtern) = SystemDatentypen.Leer_Spieler_Enum
      then
         GlobaleVariablen.RassenImSpiel (RasseExtern) := SystemDatentypen.Spieler_Mensch_Enum;
                  
      elsif
        GlobaleVariablen.RassenImSpiel (RasseExtern) = SystemDatentypen.Spieler_Mensch_Enum
      then
         GlobaleVariablen.RassenImSpiel (RasseExtern) := SystemDatentypen.Spieler_KI_Enum;
                  
      else
         GlobaleVariablen.RassenImSpiel (RasseExtern) := SystemDatentypen.Leer_Spieler_Enum;
      end if;
      
   end BelegungÄndern;
   
   
   
   function EineRasseBelegt
     return Boolean
   is begin
      
      RassenSchleife:
      for RasseSchleifenwert in SystemDatentypen.Rassen_Verwendet_Enum'Range loop
         
         if
           GlobaleVariablen.RassenImSpiel (RasseSchleifenwert) /= SystemDatentypen.Leer_Spieler_Enum
         then
            return True;
            
         else
            null;
         end if;
         
      end loop RassenSchleife;
      
      return False;
      
   end EineRasseBelegt;



   procedure StartwerteErmitteln
   is begin
      
      SpieleranzahlWerteFestlegen:
      for RasseSchleifenwert in SystemDatentypen.Rassen_Verwendet_Enum'Range loop
        
         case
           GlobaleVariablen.RassenImSpiel (RasseSchleifenwert)
         is
            when SystemDatentypen.Leer_Spieler_Enum =>
               null;
               
            when others =>
               StartwerteFestlegenSchleife:
               for NotAusSchleifenwert in NotAus'Range loop
                  
                  StartKoordinaten := ((0, 0, 0), (0, 0, 0));
                  GezogeneWerte := ZufallGeneratorenKarten.StartPosition (RasseSchleifenwert);
                  
                  case
                    UmgebungPrüfen (KoordinatenExtern => GezogeneWerte,
                                     RasseExtern       => RasseSchleifenwert)
                  is
                     when True =>
                        exit StartwerteFestlegenSchleife;
                        
                     when False =>
                        null;
                  end case;

                  case
                    NotAusSchleifenwert
                  is
                     when NotAus'Last =>
                        -- Neue Meldung durch den Grafiktask anzeigen lassen.
                        -- Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleTexte.Fehlermeldungen,
                        --                                      TextZeileExtern => 16);
                        -- Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleTexte.Rassen_Beschreibung_Kurz,
                        --                                      TextZeileExtern => SystemDatentypen.Rassen_Verwendet_Enum'Pos (RasseSchleifenwert));
                        -- Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleTexte.Fehlermeldungen,
                        --                                      TextZeileExtern => 17);
                        GlobaleVariablen.RassenImSpiel (RasseSchleifenwert) := SystemDatentypen.Leer_Spieler_Enum;
                        
                     when others =>
                        null;
                  end case;
         
               end loop StartwerteFestlegenSchleife;
         end case;
         
      end loop SpieleranzahlWerteFestlegen;
      
   end StartwerteErmitteln;



   function UmgebungPrüfen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return Boolean
   is begin

      FreieFelder := 0;
      
      case
        EinheitSuchen.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => KoordinatenExtern).Platznummer
      is
         when EinheitenKonstanten.LeerNummer =>
            StartKoordinaten (1) := KoordinatenExtern;
            FelderBestimmen (KoordinatenExtern => KoordinatenExtern,
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
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin
            
      StartpositionGefunden := False;
      
      YAchseSchleife:
      for YÄnderungSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
         XAchseSchleife:
         for XÄnderungSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop

            KartenWert := KarteKoordinatenPruefen.KarteKoordinatenPrüfen (KoordinatenExtern => KoordinatenExtern,
                                                                           ÄnderungExtern    => (0, YÄnderungSchleifenwert, XÄnderungSchleifenwert),
                                                                           LogikGrafikExtern => True);
                  
            if
              KartenWert.XAchse = KartenKonstanten.LeerXAchse
            then
               null;
                     
            elsif
              YÄnderungSchleifenwert = 0
              and
                XÄnderungSchleifenwert = 0
            then
               null;
                     
            elsif
              BewegungPassierbarkeitPruefen.PassierbarkeitPrüfenID (RasseExtern           => RasseExtern,
                                                                     IDExtern              => 2,
                                                                     NeueKoordinatenExtern => KartenWert)
              = False
            then
               null;
                     
            elsif
              StartpositionGefunden = False
            then
               case
                 EinheitSuchen.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => KartenWert).Platznummer
               is
                  when EinheitenKonstanten.LeerNummer =>
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
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
   is begin

      EinheitenErzeugenEntfernen.EinheitErzeugen (KoordinatenExtern      => StartKoordinaten (1),
                                                  EinheitNummerExtern    => 1,
                                                  IDExtern               => 1,
                                                  StadtRasseNummerExtern => (RasseExtern, 0));
      
      EinheitenErzeugenEntfernen.EinheitErzeugen (KoordinatenExtern      => StartKoordinaten (2),
                                                  EinheitNummerExtern    => 2,
                                                  IDExtern               => 2,
                                                  StadtRasseNummerExtern => (RasseExtern, 0));
      
      GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell := LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => (RasseExtern, 1));
      GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt := GlobaleVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell;
      
   end StartpunktFestlegen;

end SpieleinstellungenRasseSpieler;
