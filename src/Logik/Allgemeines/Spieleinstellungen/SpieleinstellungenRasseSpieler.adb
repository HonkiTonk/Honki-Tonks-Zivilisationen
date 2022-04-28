pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with ZahlenDatentypen; use ZahlenDatentypen;
with KartenKonstanten;
with EinheitenKonstanten;
with MenueDatentypen;
with SpielVariablen;

with LeseEinheitenGebaut;

with ZufallsgeneratorenSpieleinstellungen;
with ZufallsgeneratorenStartkoordinaten;
with EinheitSuchen;
with Kartenkoordinatenberechnungssystem;
with BewegungPassierbarkeitPruefen;
with EinheitenErzeugenEntfernen;
with AuswahlMenues;
with Fehler;

package body SpieleinstellungenRasseSpieler is
   
   procedure RassenWählen
   is begin
      
      SonstigeVariablen.RassenImSpiel := (others => RassenDatentypen.Leer_Spieler_Enum);

      RasseSchleife:
      loop
         
         RassenAuswahl := AuswahlMenues.AuswahlMenüsAufteilung (WelchesMenüExtern => MenueDatentypen.Rassen_Menü_Enum);

         case
           RassenAuswahl
         is
            when RueckgabeDatentypen.Rassen_Verwendet_Enum'Range =>
               BelegungÄndern (RasseExtern => RückgabeZuRasse (RassenAuswahl));

            when RueckgabeDatentypen.Zufall_Enum =>
               ZufallsgeneratorenSpieleinstellungen.ZufälligeRassen;
               
            when RueckgabeDatentypen.Fertig_Enum =>
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
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      case
        SonstigeVariablen.RassenImSpiel (RasseExtern)
      is
         when RassenDatentypen.Leer_Spieler_Enum =>
            SonstigeVariablen.RassenImSpiel (RasseExtern) := RassenDatentypen.Spieler_Mensch_Enum;
                  
         when RassenDatentypen.Spieler_Mensch_Enum =>
            SonstigeVariablen.RassenImSpiel (RasseExtern) := RassenDatentypen.Spieler_KI_Enum;
                  
         when RassenDatentypen.Spieler_KI_Enum =>
            SonstigeVariablen.RassenImSpiel (RasseExtern) := RassenDatentypen.Leer_Spieler_Enum;
      end case;
      
   end BelegungÄndern;
   
   
   
   function EineRasseBelegt
     return Boolean
   is begin
      
      RassenSchleife:
      for RasseSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
         
         case
           SonstigeVariablen.RassenImSpiel (RasseSchleifenwert)
         is
            when RassenDatentypen.Leer_Spieler_Enum =>
               null;
               
            when RassenDatentypen.Spieler_Belegt_Enum =>
               return True;
         end case;
         
      end loop RassenSchleife;
      
      return False;
      
   end EineRasseBelegt;



   procedure StartwerteErmitteln
   is begin
      
      SpieleranzahlWerteFestlegen:
      for RasseSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
        
         case
           SonstigeVariablen.RassenImSpiel (RasseSchleifenwert)
         is
            when RassenDatentypen.Leer_Spieler_Enum =>
               null;
               
            when others =>
               StartwerteFestlegenSchleife:
               for NotAusSchleifenwert in ZahlenDatentypen.NotAus'Range loop
                  
                  StartKoordinaten := ((0, 0, 0), (0, 0, 0));
                  GezogeneWerte := ZufallsgeneratorenStartkoordinaten.Startkoordinaten (RasseExtern => RasseSchleifenwert);
                  
                  case
                    UmgebungPrüfen (KoordinatenExtern => GezogeneWerte,
                                    RasseExtern       => RasseSchleifenwert,
                                    NotAusExtern      => NotAusSchleifenwert)
                  is
                     when True =>
                        exit StartwerteFestlegenSchleife;
                        
                     when False =>
                        null;
                  end case;

                  case
                    NotAusSchleifenwert
                  is
                     when ZahlenDatentypen.NotAus'Last =>
                        -- Neue Meldung durch den Grafiktask anzeigen lassen.
                        -- Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleTexte.Fehlermeldungen,
                        --                                      TextZeileExtern => 16);
                        -- Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleTexte.Rassen_Beschreibung_Kurz,
                        --                                      TextZeileExtern => RueckgabeDatentypen.Rassen_Verwendet_Enum'Pos (RasseSchleifenwert));
                        -- Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleTexte.Fehlermeldungen,
                        --                                      TextZeileExtern => 17);
                        SonstigeVariablen.RassenImSpiel (RasseSchleifenwert) := RassenDatentypen.Leer_Spieler_Enum;
                        
                     when others =>
                        null;
                  end case;
         
               end loop StartwerteFestlegenSchleife;
         end case;
         
      end loop SpieleranzahlWerteFestlegen;
      
   end StartwerteErmitteln;



   function UmgebungPrüfen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      NotAusExtern : in ZahlenDatentypen.NotAus)
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
         
      elsif
        NotAusExtern > ZahlenDatentypen.NotAus'Last - 10
        and
          FreieFelder >= 2
      then
         StartpunktFestlegen (RasseExtern => RasseExtern);
         return True;
               
      else
         return False;
      end if;
      
   end UmgebungPrüfen;
   
   
   
   procedure FelderBestimmen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
            
      StartpositionGefunden := False;
      
      YAchseSchleife:
      for YÄnderungSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
         XAchseSchleife:
         for XÄnderungSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop

            KartenWert := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => KoordinatenExtern,
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
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin

      EinheitenErzeugenEntfernen.EinheitErzeugen (KoordinatenExtern      => StartKoordinaten (1),
                                                  EinheitNummerExtern    => 1,
                                                  IDExtern               => 1,
                                                  StadtRasseNummerExtern => (RasseExtern, 0));
      
      EinheitenErzeugenEntfernen.EinheitErzeugen (KoordinatenExtern      => StartKoordinaten (2),
                                                  EinheitNummerExtern    => 2,
                                                  IDExtern               => 2,
                                                  StadtRasseNummerExtern => (RasseExtern, 0));
      
      ------------------------- Das hier auch noch nach Grafik verschieben?
      SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell := LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => (RasseExtern, 1));
      SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt := SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell;
      
   end StartpunktFestlegen;

end SpieleinstellungenRasseSpieler;