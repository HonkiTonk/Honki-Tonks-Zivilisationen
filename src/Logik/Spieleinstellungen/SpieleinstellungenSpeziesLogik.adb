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
with SchreibeZeiger;

with ZufallsgeneratorenSpieleinstellungenLogik;
with ZufallsgeneratorenStartkoordinatenLogik;
with EinheitSuchenLogik;
with KartenkoordinatenberechnungssystemLogik;
with PassierbarkeitspruefungLogik;
with EinheitenErzeugenEntfernenLogik;
with AuswahlaufteilungLogik;
with Fehlermeldungssystem;
with LadezeitenLogik;
with UmwandlungenDatentypen;

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
               BelegungÄndern (SpeziesExtern => UmwandlungenDatentypen.RückgabeNachSpezies (RückgabeExtern => SpeziesAuswahl));

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
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
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
      for SpeziesSchleifenwert in SpeziesDatentypen.Spezies_Vorhanden_Enum'Range loop
         
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
      
   end SpeziesAutomatischBelegen;



   procedure StartwerteErmitteln
   is
      use type SystemDatentypen.NullBisHundert;
   begin
      
      SpieleranzahlWerteFestlegen:
      for SpeziesSchleifenwert in SpeziesDatentypen.Spezies_Vorhanden_Enum'Range loop
        
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
                        -- Hier wieder eine Meldung einbauen für den Fall dass die Spezies nicht platziert werden konnte? Scheint sinnvoll. äöü
                        SchreibeSpeziesbelegung.Belegung (SpeziesExtern  => SpeziesSchleifenwert,
                                                          BelegungExtern => SpeziesDatentypen.Leer_Spieler_Enum);
                        
                     when others =>
                        null;
                  end case;
         
               end loop StartwerteFestlegenSchleife;
         end case;
         
         LadezeitenLogik.FortschrittSpielwelt (LadezeitenDatentypen.Platziere_Spezies_Enum) := SpeziesDatentypen.Spezies_Vorhanden_Enum'Pos (SpeziesSchleifenwert) * 5;
         
      end loop SpieleranzahlWerteFestlegen;
      
      LadezeitenLogik.FortschrittSpielweltMaximum (WelcheBerechnungenExtern => LadezeitenDatentypen.Platziere_Spezies_Enum);
      
   end StartwerteErmitteln;



   function StartpunktPrüfen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
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
                                                                TaskExtern        => SystemDatentypen.Logik_Task_Enum).Nummer
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
        StartKoordinaten (2).Ebene
      is
         when KartenKonstanten.LeerEbene =>
            return False;
            
         when others =>
            StartpunktFestlegen (SpeziesExtern             => SpeziesExtern,
                                 StartkoordinateEinsExtern => StartKoordinaten (1),
                                 StartkoordinateZweiExtern => StartKoordinaten (2));
            return True;
      end case;
      
   end StartpunktPrüfen;
   
   
   
   function ZusatzfeldBestimmen
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      NotAusExtern : in ZahlenDatentypen.NotAus)
      return KartenRecords.KartenfeldNaturalRecord
   is
      use type KartengrundDatentypen.Basisgrund_Enum;
      use type ZahlenDatentypen.NotAus;
   begin
            
      FreieFelder := 0;
      
      SenkrechteSchleife:
      for SenkrechteSchleifenwert in KartenDatentypen.SenkrechteUmgebungEins'Range loop
         WaagerechteSchleife:
         for WaagerechteSchleifenwert in KartenDatentypen.WaagerechteUmgebungEins'Range loop

            KartenWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => KoordinatenExtern,
                                                                                                      ÄnderungExtern    => (KartenKonstanten.LeerEbeneÄnderung, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                                                                                      TaskExtern        => SystemDatentypen.Logik_Task_Enum);
                  
            if
              KartenWert.Waagerechte = KartenKonstanten.LeerWaagerechte
            then
               null;
                     
            elsif
              SenkrechteSchleifenwert = 0
              and
                WaagerechteSchleifenwert = 0
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
                                                                         TaskExtern        => SystemDatentypen.Logik_Task_Enum).Nummer
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

         end loop WaagerechteSchleife;
      end loop SenkrechteSchleife;
      
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
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      StartkoordinateEinsExtern : in KartenRecords.KartenfeldNaturalRecord;
      StartkoordinateZweiExtern : in KartenRecords.KartenfeldNaturalRecord)
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
            SchreibeZeiger.KoordinatenAktuell (SpeziesExtern     => SpeziesExtern,
                                               KoordinatenExtern => StartkoordinateEinsExtern);
            SchreibeZeiger.KoordinatenAlt (SpeziesExtern     => SpeziesExtern,
                                           KoordinatenExtern => StartkoordinateEinsExtern);
            
         when others =>
            null;
      end case;
            
   end StartpunktFestlegen;

end SpieleinstellungenSpeziesLogik;
