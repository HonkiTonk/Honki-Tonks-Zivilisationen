with LadezeitenDatentypen;
with KartengrundDatentypen;
with SystemDatentypen;
with KartenRecordKonstanten;
with KartenKonstanten;
with EinheitenKonstanten;
with MenueDatentypen;

with LeseWeltkarte;
with LeseSpeziesbelegung;
with SchreibeSpeziesbelegung;
with SchreibeCursor;

with ZufallsgeneratorenSpieleinstellungenLogik;
with ZufallsgeneratorenStartkoordinatenLogik;
with EinheitSuchenLogik;
with KartenkoordinatenberechnungssystemLogik;
with PassierbarkeitspruefungLogik;
with EinheitenErzeugenEntfernenLogik;
with AuswahlaufteilungLogik;
with Fehlermeldungssystem;
with LadezeitenLogik;
with UmwandlungenVerschiedeneDatentypen;

package body SpieleinstellungenSpeziesLogik is
   
   procedure SpeziesWählen
   is begin

      SpeziesSchleife:
      loop
         
         SpeziesAuswahl := AuswahlaufteilungLogik.AuswahlMenüsAufteilung (WelchesMenüExtern => MenueDatentypen.Spezies_Menü_Enum);

         case
           SpeziesAuswahl
         is
            when RueckgabeDatentypen.Spezies_Verwendet_Enum'Range =>
               BelegungÄndern (SpeziesExtern => UmwandlungenVerschiedeneDatentypen.RückgabeNachSpezies (RückgabeExtern => SpeziesAuswahl));

            when RueckgabeDatentypen.Auswahl_Neunzehn_Enum =>
               ZufallsgeneratorenSpieleinstellungenLogik.ZufälligeSpeziesbelegung;
               
            when RueckgabeDatentypen.Fertig_Enum | RueckgabeDatentypen.Zurück_Enum =>
               return;
               
            when others =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "SpieleinstellungenSpeziesLogik.SpeziesWählen: Falsche Auswahl: " & SpeziesAuswahl'Wide_Wide_Image);
         end case;
         
      end loop SpeziesSchleife;
      
   end SpeziesWählen;
   
   
   
   procedure BelegungÄndern
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
   is begin
      
      case
        LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern)
      is
         when SpeziesDatentypen.Leer_Spieler_Enum =>
            SchreibeSpeziesbelegung.Belegung (SpeziesExtern  => SpeziesExtern,
                                              BelegungExtern => SpeziesDatentypen.Mensch_Spieler_Enum);
                  
         when SpeziesDatentypen.Mensch_Spieler_Enum =>
            SchreibeSpeziesbelegung.Belegung (SpeziesExtern  => SpeziesExtern,
                                              BelegungExtern => SpeziesDatentypen.KI_Spieler_Enum);
                  
         when SpeziesDatentypen.KI_Spieler_Enum =>
            SchreibeSpeziesbelegung.Belegung (SpeziesExtern  => SpeziesExtern,
                                              BelegungExtern => SpeziesDatentypen.Leer_Spieler_Enum);
      end case;
      
   end BelegungÄndern;
   
   
   
   function EineSpeziesBelegt
     return Boolean
   is begin
      
      SpeziesSchleife:
      for SpeziesSchleifenwert in SpeziesDatentypen.Spezies_Verwendet_Enum'Range loop
         
         case
           LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesSchleifenwert)
         is
            when SpeziesDatentypen.Leer_Spieler_Enum =>
               null;
               
            when SpeziesDatentypen.Spieler_Belegt_Enum'Range =>
               return True;
         end case;
         
      end loop SpeziesSchleife;
      
      return False;
      
   end EineSpeziesBelegt;
   
   
   
   procedure SpeziesAutomatischBelegen
   is begin
      
      SchreibeSpeziesbelegung.Belegung (SpeziesExtern  => ZufallsgeneratorenSpieleinstellungenLogik.ZufälligeSpezies,
                                        BelegungExtern => SpeziesDatentypen.Mensch_Spieler_Enum);
      
   end SpeziesAutomatischBelegen;
   
   
   
   procedure SpeziesBelegenSchnellstart
   is
      use type SpeziesDatentypen.Spezies_Enum;
   begin
      
      SpeziesMenschSchnellstart := ZufallsgeneratorenSpieleinstellungenLogik.ZufälligeSpezies;
      
      SchreibeSpeziesbelegung.Belegung (SpeziesExtern  => SpeziesMenschSchnellstart,
                                        BelegungExtern => SpeziesDatentypen.Mensch_Spieler_Enum);
      
      KIBelegenSchleife:
      loop
         
         SpeziesKISchnellstart := ZufallsgeneratorenSpieleinstellungenLogik.ZufälligeSpezies;
         
         if
           SpeziesMenschSchnellstart = SpeziesKISchnellstart
         then
            null;
            
         else
            SchreibeSpeziesbelegung.Belegung (SpeziesExtern  => SpeziesKISchnellstart,
                                              BelegungExtern => SpeziesDatentypen.KI_Spieler_Enum);
            exit KIBelegenSchleife;
         end if;
         
      end loop KIBelegenSchleife;
      
   end SpeziesBelegenSchnellstart;



   procedure StartwerteErmitteln
   is
      use type SystemDatentypen.NullBisHundert;
   begin
      
      SpieleranzahlWerteFestlegen:
      for SpeziesSchleifenwert in SpeziesDatentypen.Spezies_Verwendet_Enum'Range loop
        
         case
           LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesSchleifenwert)
         is
            when SpeziesDatentypen.Leer_Spieler_Enum =>
               null;
               
            when others =>
               StartwerteFestlegenSchleife:
               for NotAusSchleifenwert in ZahlenDatentypen.NotAus'Range loop
                                    
                  case
                    StartpunktPrüfen (SpeziesExtern => SpeziesSchleifenwert,
                                       NotAusExtern  => NotAusSchleifenwert)
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
                        -- Hier wieder eine Meldung einbauen für den Fall dass die Spezies nicht platziert werden konnte? äöü
                        SchreibeSpeziesbelegung.Belegung (SpeziesExtern  => SpeziesSchleifenwert,
                                                          BelegungExtern => SpeziesDatentypen.Leer_Spieler_Enum);
                        
                     when others =>
                        null;
                  end case;
         
               end loop StartwerteFestlegenSchleife;
         end case;
         
         LadezeitenLogik.FortschrittSpielwelt (LadezeitenDatentypen.Platziere_Spezies_Enum) := SpeziesDatentypen.Spezies_Verwendet_Enum'Pos (SpeziesSchleifenwert) * 5;
         
      end loop SpieleranzahlWerteFestlegen;
      
      LadezeitenLogik.FortschrittSpielweltMaximum (WelcheBerechnungenExtern => LadezeitenDatentypen.Platziere_Spezies_Enum);
      
   end StartwerteErmitteln;



   function StartpunktPrüfen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      NotAusExtern : in ZahlenDatentypen.NotAus)
      return Boolean
   is begin
      
      GezogeneKoordinate := ZufallsgeneratorenStartkoordinatenLogik.Startkoordinaten (SpeziesExtern => SpeziesExtern);
      
      case
        LeseWeltkarte.Basisgrund (KoordinatenExtern => GezogeneKoordinate)
      is
         when KartengrundDatentypen.Eis_Enum | KartengrundDatentypen.Untereis_Enum =>
            return False;
            
         when others =>
            if
              True = PassierbarkeitspruefungLogik.PassierbarkeitPrüfenID (SpeziesExtern              => SpeziesExtern,
                                                                           IDExtern                   => 1,
                                                                           NeueKoordinatenExtern      => GezogeneKoordinate,
                                                                           StadtBerücksichtigenExtern => False)
            then
               null;
               
            else
               return False;
            end if;
      end case;
      
      case
        EinheitSuchenLogik.KoordinatenEinheitOhneSpeziesSuchen (KoordinatenExtern => GezogeneKoordinate,
                                                                LogikGrafikExtern => True).Nummer
      is
         when EinheitenKonstanten.LeerNummer =>
            StartKoordinaten (1) := GezogeneKoordinate;
            StartKoordinaten (2) := ZusatzfeldBestimmen (KoordinatenExtern => GezogeneKoordinate,
                                                         SpeziesExtern     => SpeziesExtern,
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
            StartpunktFestlegen (SpeziesExtern             => SpeziesExtern,
                                 StartkoordinateEinsExtern => StartKoordinaten (1),
                                 StartkoordinateZweiExtern => StartKoordinaten (2));
            return True;
      end case;
      
   end StartpunktPrüfen;
   
   
   
   function ZusatzfeldBestimmen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      NotAusExtern : in ZahlenDatentypen.NotAus)
      return KartenRecords.AchsenKartenfeldNaturalRecord
   is
      use type KartengrundDatentypen.Basisgrund_Enum;
      use type ZahlenDatentypen.NotAus;
   begin
            
      FreieFelder := 0;
      
      YAchseSchleife:
      for YAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
         XAchseSchleife:
         for XAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop

            KartenWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => KoordinatenExtern,
                                                                                                      ÄnderungExtern    => (KartenKonstanten.LeerEAchseÄnderung, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                      LogikGrafikExtern => True);
                  
            if
              KartenWert.XAchse = KartenKonstanten.LeerXAchse
            then
               null;
                     
            elsif
              YAchseSchleifenwert = 0
              and
                XAchseSchleifenwert = 0
            then
               null;
               
            elsif
              LeseWeltkarte.Basisgrund (KoordinatenExtern => KartenWert) = KartengrundDatentypen.Eis_Enum
              or
                LeseWeltkarte.Basisgrund (KoordinatenExtern => KartenWert) = KartengrundDatentypen.Untereis_Enum
            then
               null;
                                    
            elsif
              False = PassierbarkeitspruefungLogik.PassierbarkeitPrüfenID (SpeziesExtern              => SpeziesExtern,
                                                                            IDExtern                   => 2,
                                                                            NeueKoordinatenExtern      => KartenWert,
                                                                            StadtBerücksichtigenExtern => False)
            then
               null;
               
            elsif
              FreieFelder = 0
            then
               case
                 EinheitSuchenLogik.KoordinatenEinheitOhneSpeziesSuchen (KoordinatenExtern => KartenWert,
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
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      StartkoordinateEinsExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      StartkoordinateZweiExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
   is begin

      EinheitenErzeugenEntfernenLogik.EinheitErzeugen (KoordinatenExtern        => StartkoordinateEinsExtern,
                                                       EinheitNummerExtern      => 1,
                                                       IDExtern                 => 1,
                                                       StadtSpeziesNummerExtern => (SpeziesExtern, 0));
      
      EinheitenErzeugenEntfernenLogik.EinheitErzeugen (KoordinatenExtern        => StartkoordinateZweiExtern,
                                                       EinheitNummerExtern      => 2,
                                                       IDExtern                 => 2,
                                                       StadtSpeziesNummerExtern => (SpeziesExtern, 0));
      
      case
        LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern)
      is
         when SpeziesDatentypen.Mensch_Spieler_Enum =>
            SchreibeCursor.KoordinatenAktuell (SpeziesExtern     => SpeziesExtern,
                                               KoordinatenExtern => StartkoordinateEinsExtern);
            SchreibeCursor.KoordinatenAlt (SpeziesExtern     => SpeziesExtern,
                                           KoordinatenExtern => StartkoordinateEinsExtern);
            
         when others =>
            null;
      end case;
            
   end StartpunktFestlegen;

end SpieleinstellungenSpeziesLogik;
