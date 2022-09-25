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

with LeseWeltkarte;

with ZufallsgeneratorenSpieleinstellungenLogik;
with ZufallsgeneratorenStartkoordinatenLogik;
with EinheitSuchenLogik;
with KartenkoordinatenberechnungssystemLogik;
with PassierbarkeitspruefungLogik;
with EinheitenErzeugenEntfernenLogik;
with AuswahlaufteilungLogik;
with Fehler;
with LadezeitenLogik;
with UmwandlungenVerschiedeneDatentypen;
with CursorbewegungLogik;

package body SpieleinstellungenRasseLogik is
   
   procedure RassenWählen
   is begin

      RasseSchleife:
      loop
         
         RassenAuswahl := AuswahlaufteilungLogik.AuswahlMenüsAufteilung (WelchesMenüExtern => MenueDatentypen.Rassen_Menü_Enum);

         case
           RassenAuswahl
         is
            when RueckgabeDatentypen.Rassen_Verwendet_Enum'Range =>
               BelegungÄndern (RasseExtern => UmwandlungenVerschiedeneDatentypen.RückgabeNachRasse (RückgabeExtern => RassenAuswahl));

            when RueckgabeDatentypen.Auswahl_Neunzehn_Enum =>
               ZufallsgeneratorenSpieleinstellungenLogik.ZufälligeRassenbelegung;
               
            when RueckgabeDatentypen.Fertig_Enum | RueckgabeDatentypen.Zurück_Enum =>
               return;
               
            when others =>
               Fehler.LogikFehler (FehlermeldungExtern => "SpielEinstellungenRasseSpieler.RassenWählen: Falsche Auswahl: " & RassenAuswahl'Wide_Wide_Image);
         end case;
         
      end loop RasseSchleife;
      
   end RassenWählen;
   
   
   
   procedure BelegungÄndern
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      case
        SpielVariablen.Rassenbelegung (RasseExtern).Belegung
      is
         when RassenDatentypen.Leer_Spieler_Enum =>
            SpielVariablen.Rassenbelegung (RasseExtern).Belegung := RassenDatentypen.Mensch_Spieler_Enum;
                  
         when RassenDatentypen.Mensch_Spieler_Enum =>
            SpielVariablen.Rassenbelegung (RasseExtern).Belegung := RassenDatentypen.KI_Spieler_Enum;
                  
         when RassenDatentypen.KI_Spieler_Enum =>
            SpielVariablen.Rassenbelegung (RasseExtern).Belegung := RassenDatentypen.Leer_Spieler_Enum;
      end case;
      
   end BelegungÄndern;
   
   
   
   function EineRasseBelegt
     return Boolean
   is begin
      
      RassenSchleife:
      for RasseSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
         
         case
           SpielVariablen.Rassenbelegung (RasseSchleifenwert).Belegung
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
      
      SpielVariablen.Rassenbelegung (ZufallsgeneratorenSpieleinstellungenLogik.ZufälligeRasse).Belegung := RassenDatentypen.Mensch_Spieler_Enum;
      
   end RasseAutomatischBelegen;
   
   
   
   procedure RasseBelegenSchnellstart
   is begin
      
      RasseMenschSchnellstart := ZufallsgeneratorenSpieleinstellungenLogik.ZufälligeRasse;
      
      SpielVariablen.Rassenbelegung (RasseMenschSchnellstart).Belegung := RassenDatentypen.Mensch_Spieler_Enum;
      
      KIBelegenSchleife:
      loop
         
         RasseKISchnellstart := ZufallsgeneratorenSpieleinstellungenLogik.ZufälligeRasse;
         
         if
           RasseMenschSchnellstart = RasseKISchnellstart
         then
            null;
            
         else
            SpielVariablen.Rassenbelegung (RasseKISchnellstart).Belegung := RassenDatentypen.KI_Spieler_Enum;
            exit KIBelegenSchleife;
         end if;
         
      end loop KIBelegenSchleife;
      
   end RasseBelegenSchnellstart;



   procedure StartwerteErmitteln
   is begin
      
      SpieleranzahlWerteFestlegen:
      for RasseSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
        
         case
           SpielVariablen.Rassenbelegung (RasseSchleifenwert).Belegung
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
                        -- Hier wieder eine Meldung einbauen für den Fall dass die Rasse nicht platziert werden konnte? äöü
                        SpielVariablen.Rassenbelegung (RasseSchleifenwert).Belegung := RassenDatentypen.Leer_Spieler_Enum;
                        
                     when others =>
                        null;
                  end case;
         
               end loop StartwerteFestlegenSchleife;
         end case;
         
         LadezeitenLogik.FortschrittSpielwelt (LadezeitenDatentypen.Platziere_Rassen_Enum) := RassenDatentypen.Rassen_Verwendet_Enum'Pos (RasseSchleifenwert) * 5;
         
      end loop SpieleranzahlWerteFestlegen;
      
      LadezeitenLogik.FortschrittSpielweltMaximum (WelcheBerechnungenExtern => LadezeitenDatentypen.Platziere_Rassen_Enum);
      
   end StartwerteErmitteln;



   function StartpunktPrüfen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      NotAusExtern : in ZahlenDatentypen.NotAus)
      return Boolean
   is begin
      
      GezogeneKoordinate := ZufallsgeneratorenStartkoordinatenLogik.Startkoordinaten (RasseExtern => RasseExtern);
      
      case
        LeseWeltkarte.AktuellerGrund (KoordinatenExtern => GezogeneKoordinate)
      is
         when KartengrundDatentypen.Eis_Enum | KartengrundDatentypen.Untereis_Enum =>
            return False;
            
         when others =>
            if
              True = PassierbarkeitspruefungLogik.PassierbarkeitPrüfenID (RasseExtern           => RasseExtern,
                                                                           IDExtern              => 1,
                                                                           NeueKoordinatenExtern => GezogeneKoordinate)
            then
               null;
               
            else
               return False;
            end if;
      end case;
      
      case
        EinheitSuchenLogik.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => GezogeneKoordinate,
                                                              LogikGrafikExtern => True).Nummer
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

            KartenWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => KoordinatenExtern,
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
              LeseWeltkarte.AktuellerGrund (KoordinatenExtern => KartenWert) = KartengrundDatentypen.Eis_Enum
              or
                LeseWeltkarte.AktuellerGrund (KoordinatenExtern => KartenWert) = KartengrundDatentypen.Untereis_Enum
            then
               null;
                                    
            elsif
              False = PassierbarkeitspruefungLogik.PassierbarkeitPrüfenID (RasseExtern           => RasseExtern,
                                                                            IDExtern              => 2,
                                                                            NeueKoordinatenExtern => KartenWert)
            then
               null;
               
            elsif
              FreieFelder = 0
            then
               case
                 EinheitSuchenLogik.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => KartenWert,
                                                                       LogikGrafikExtern => True).Nummer
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

      EinheitenErzeugenEntfernenLogik.EinheitErzeugen (KoordinatenExtern      => StartkoordinateEinsExtern,
                                                       EinheitNummerExtern    => 1,
                                                       IDExtern               => 1,
                                                       StadtRasseNummerExtern => (RasseExtern, 0));
      
      EinheitenErzeugenEntfernenLogik.EinheitErzeugen (KoordinatenExtern      => StartkoordinateZweiExtern,
                                                       EinheitNummerExtern    => 2,
                                                       IDExtern               => 2,
                                                       StadtRasseNummerExtern => (RasseExtern, 0));
      
      case
        SpielVariablen.Rassenbelegung (RasseExtern).Belegung
      is
         when RassenDatentypen.Mensch_Spieler_Enum =>
            SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAktuell := (StartkoordinateEinsExtern.EAchse, Weltkarte.Karteneinstellungen.Kartengröße.YAchse / 2, Weltkarte.Karteneinstellungen.Kartengröße.XAchse / 2);
            SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt := StartkoordinateEinsExtern;
            CursorbewegungLogik.ZoomanpassungCursor (RasseExtern => RasseExtern);
            
         when others =>
            null;
      end case;
            
   end StartpunktFestlegen;

end SpieleinstellungenRasseLogik;
