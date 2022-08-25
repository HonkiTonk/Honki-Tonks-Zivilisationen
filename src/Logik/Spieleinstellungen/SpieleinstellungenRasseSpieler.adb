pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with ZahlenDatentypen; use ZahlenDatentypen;
with LadezeitenDatentypen; use LadezeitenDatentypen;
with KartengrundDatentypen; use KartengrundDatentypen;
with RassenDatentypen; use RassenDatentypen;
with KartenRecordKonstanten;
with KartenKonstanten;
with EinheitenKonstanten;
with MenueDatentypen;
with SpielVariablen;

with LeseKarten;

with ZufallsgeneratorenSpieleinstellungen;
with ZufallsgeneratorenStartkoordinaten;
with EinheitSuchen;
with Kartenkoordinatenberechnungssystem;
with BewegungPassierbarkeitPruefen;
with EinheitenErzeugenEntfernen;
with Auswahlaufteilungen;
with Fehler;
with Ladezeiten;
with UmwandlungenVerschiedeneDatentypen;

package body SpieleinstellungenRasseSpieler is
   
   procedure RassenWählen
   is begin

      RasseSchleife:
      loop
         
         RassenAuswahl := Auswahlaufteilungen.AuswahlMenüsAufteilung (WelchesMenüExtern => MenueDatentypen.Rassen_Menü_Enum);

         case
           RassenAuswahl
         is
            when RueckgabeDatentypen.Rassen_Verwendet_Enum'Range =>
               BelegungÄndern (RasseExtern => UmwandlungenVerschiedeneDatentypen.RückgabeNachRasse (RückgabeExtern => RassenAuswahl));

            when RueckgabeDatentypen.Zufall_Enum =>
               ZufallsgeneratorenSpieleinstellungen.ZufälligeRassenbelegung;
               
            when RueckgabeDatentypen.Fertig_Enum | RueckgabeDatentypen.Zurück_Enum =>
               return;
               
            when others =>
               Fehler.LogikFehler (FehlermeldungExtern => "SpielEinstellungenRasseSpieler.RassenWählen - Falsche Menüauswahl.");
         end case;
         
      end loop RasseSchleife;
      
   end RassenWählen;
   
   
   
   procedure BelegungÄndern
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      case
        SpielVariablen.RassenImSpiel (RasseExtern)
      is
         when RassenDatentypen.Leer_Spieler_Enum =>
            SpielVariablen.RassenImSpiel (RasseExtern) := RassenDatentypen.Mensch_Spieler_Enum;
                  
         when RassenDatentypen.Mensch_Spieler_Enum =>
            SpielVariablen.RassenImSpiel (RasseExtern) := RassenDatentypen.KI_Spieler_Enum;
                  
         when RassenDatentypen.KI_Spieler_Enum =>
            SpielVariablen.RassenImSpiel (RasseExtern) := RassenDatentypen.Leer_Spieler_Enum;
      end case;
      
   end BelegungÄndern;
   
   
   
   function EineRasseBelegt
     return Boolean
   is begin
      
      RassenSchleife:
      for RasseSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
         
         case
           SpielVariablen.RassenImSpiel (RasseSchleifenwert)
         is
            when RassenDatentypen.Leer_Spieler_Enum =>
               null;
               
            when RassenDatentypen.Spieler_Belegt_Enum'Range =>
               return True;
         end case;
         
      end loop RassenSchleife;
      
      return False;
      
   end EineRasseBelegt;
   
   
   
   procedure RasseAutomatischBelegen
   is begin
      
      SpielVariablen.RassenImSpiel (ZufallsgeneratorenSpieleinstellungen.ZufälligeRasse) := RassenDatentypen.Mensch_Spieler_Enum;
      
   end RasseAutomatischBelegen;
   
   
   
   procedure RasseBelegenSchnellstart
   is begin
      
      RasseMenschSchnellstart := ZufallsgeneratorenSpieleinstellungen.ZufälligeRasse;
      
      SpielVariablen.RassenImSpiel (RasseMenschSchnellstart) := RassenDatentypen.Mensch_Spieler_Enum;
      
      KIBelegenSchleife:
      loop
         
         RasseKISchnellstart := ZufallsgeneratorenSpieleinstellungen.ZufälligeRasse;
         
         if
           RasseMenschSchnellstart = RasseKISchnellstart
         then
            null;
            
         else
            SpielVariablen.RassenImSpiel (RasseKISchnellstart) := RassenDatentypen.KI_Spieler_Enum;
            exit KIBelegenSchleife;
         end if;
         
      end loop KIBelegenSchleife;
      
   end RasseBelegenSchnellstart;



   procedure StartwerteErmitteln
   is begin
      
      SpieleranzahlWerteFestlegen:
      for RasseSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
        
         case
           SpielVariablen.RassenImSpiel (RasseSchleifenwert)
         is
            when RassenDatentypen.Leer_Spieler_Enum =>
               null;
               
            when others =>
               StartwerteFestlegenSchleife:
               for NotAusSchleifenwert in ZahlenDatentypen.NotAus'Range loop
                                    
                  case
                    StartpunktPrüfen (RasseExtern  => RasseSchleifenwert,
                                       NotAusExtern => NotAusSchleifenwert)
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
                        -- Neue Meldung durch den Grafiktask anzeigen lassen. äöü
                        -- Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleTexte.Fehlermeldungen,
                        --                                      TextZeileExtern => 16);
                        -- Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleTexte.Rassen_Beschreibung_Kurz,
                        --                                      TextZeileExtern => RueckgabeDatentypen.Rassen_Verwendet_Enum'Pos (RasseSchleifenwert));
                        -- Anzeige.EinzeiligeAnzeigeOhneAuswahl (TextDateiExtern => GlobaleTexte.Fehlermeldungen,
                        --                                      TextZeileExtern => 17);
                        SpielVariablen.RassenImSpiel (RasseSchleifenwert) := RassenDatentypen.Leer_Spieler_Enum;
                        
                     when others =>
                        null;
                  end case;
         
               end loop StartwerteFestlegenSchleife;
         end case;
         
         Ladezeiten.FortschrittSpielwelt (LadezeitenDatentypen.Platziere_Rassen_Enum) := RassenDatentypen.Rassen_Verwendet_Enum'Pos (RasseSchleifenwert) * 5;
         
      end loop SpieleranzahlWerteFestlegen;
      
      Ladezeiten.FortschrittSpielweltMaximum (WelcheBerechnungenExtern => LadezeitenDatentypen.Platziere_Rassen_Enum);
      
   end StartwerteErmitteln;



   function StartpunktPrüfen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      NotAusExtern : in ZahlenDatentypen.NotAus)
      return Boolean
   is begin
      
      GezogeneKoordinate := ZufallsgeneratorenStartkoordinaten.Startkoordinaten (RasseExtern => RasseExtern);
      
      -- Das ganze hier in einen if-Block verschmelzen? äöü
      case
        LeseKarten.AktuellerGrund (KoordinatenExtern => GezogeneKoordinate)
      is
         when KartengrundDatentypen.Eis_Enum | KartengrundDatentypen.Untereis_Enum =>
            return False;
            
         when others =>
            if
              True = BewegungPassierbarkeitPruefen.PassierbarkeitPrüfenID (RasseExtern           => RasseExtern,
                                                                            IDExtern              => 1,
                                                                            NeueKoordinatenExtern => GezogeneKoordinate)
            then
               null;
               
            else
               return False;
            end if;
      end case;
      
      case
        EinheitSuchen.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => GezogeneKoordinate).Nummer
      is
         when EinheitenKonstanten.LeerNummer =>
            StartKoordinaten (1) := GezogeneKoordinate;
            StartKoordinaten (2) := ZusatzfeldBestimmen (KoordinatenExtern => GezogeneKoordinate,
                                                         RasseExtern       => RasseExtern,
                                                         NotAusExtern      => NotAusExtern);
            
         when others =>
            return False;
      end case;
            
      case
        StartKoordinaten (2).EAchse
      is
         when KartenKonstanten.LeerEAchse =>
            return False;
            
         when others =>
            StartpunktFestlegen (RasseExtern               => RasseExtern,
                                 StartkoordinateEinsExtern => StartKoordinaten (1),
                                 StartkoordinateZweiExtern => StartKoordinaten (2));
            return True;
      end case;
      
   end StartpunktPrüfen;
   
   
   
   function ZusatzfeldBestimmen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      NotAusExtern : in ZahlenDatentypen.NotAus)
      return KartenRecords.AchsenKartenfeldNaturalRecord
   is begin
            
      FreieFelder := 0;
      
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
              LeseKarten.AktuellerGrund (KoordinatenExtern => KartenWert) = KartengrundDatentypen.Eis_Enum
              or
                LeseKarten.AktuellerGrund (KoordinatenExtern => KartenWert) = KartengrundDatentypen.Untereis_Enum
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
              FreieFelder = 0
            then
               case
                 EinheitSuchen.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => KartenWert).Nummer
               is
                  when EinheitenKonstanten.LeerNummer =>
                     Zusatzkoordinate := KartenWert;
                     FreieFelder := FreieFelder + 1;
                                 
                  when others =>
                     null;
               end case;
               
            else
               FreieFelder := FreieFelder + 1;
            end if;

         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
      if
        FreieFelder >= 3
      then
         null;
         
      elsif
        NotAusExtern > ZahlenDatentypen.NotAus'Last - 10
        and
          FreieFelder >= 2
      then
         null;
         
      elsif
        NotAusExtern = ZahlenDatentypen.NotAus'Last
        and
          FreieFelder >= 1
      then
         null;
               
      else
         return KartenRecordKonstanten.LeerKoordinate;
      end if;
      
      return Zusatzkoordinate;
      
   end ZusatzfeldBestimmen;



   procedure StartpunktFestlegen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      StartkoordinateEinsExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      StartkoordinateZweiExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
   is begin

      EinheitenErzeugenEntfernen.EinheitErzeugen (KoordinatenExtern      => StartkoordinateEinsExtern,
                                                  EinheitNummerExtern    => 1,
                                                  IDExtern               => 1,
                                                  StadtRasseNummerExtern => (RasseExtern, 0));
      
      EinheitenErzeugenEntfernen.EinheitErzeugen (KoordinatenExtern      => StartkoordinateZweiExtern,
                                                  EinheitNummerExtern    => 2,
                                                  IDExtern               => 2,
                                                  StadtRasseNummerExtern => (RasseExtern, 0));
      
      SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell := StartkoordinateEinsExtern;
      SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt := StartkoordinateEinsExtern;
      
   end StartpunktFestlegen;

end SpieleinstellungenRasseSpieler;
