with KartenKonstanten;
with KartengrundDatentypen;
with KartenverbesserungDatentypen;
with StadtKonstanten;
with KartenextraDatentypen;
with DiplomatieDatentypen;
with SystemDatentypen;

with LeseEinheitenDatenbank;
with LeseEinheitenGebaut;
with SchreibeWeltkarte;
with SchreibeAllgemeines;
with LeseAllgemeines;
with SchreibeDiplomatie;

with EinheitenErzeugenEntfernenLogik;
with KartenkoordinatenberechnungssystemLogik;
with StadtEntfernenLogik;
with StadtSuchenLogik;
with EinheitSuchenLogik;
with DiplomatischerZustandAenderbarLogik;

package body PZBEingesetztLogik is

   procedure PZBEingesetzt
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
   is
      use type SpeziesDatentypen.Spezies_Enum;
   begin
      
      SchreibeAllgemeines.EingesetztePZB;
      SchreibeAllgemeines.PlanetVernichtet (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies);
      Zusammenbruchszeit := LeseAllgemeines.Zusammenbruchszeit;
      Vernichtungsbereich := LeseEinheitenDatenbank.Effektreichweite (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies,
                                                                      IDExtern      => LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern),
                                                                      EffektExtern  => KartenextraDatentypen.Vernichtet_Enum);
      
      case
        Zusammenbruchszeit
      is
         when -1 =>
            if
              LeseWeltkarteneinstellungen.Senkrechte <= KartenDatentypen.Senkrechte (LeseWeltkarteneinstellungen.Waagerechte)
            then
               Zusammenbruchszeit := Natural (abs (LeseWeltkarteneinstellungen.Senkrechte + 2 * Vernichtungsbereich.SenkrechteAnfang) / 10);
                  
            else
               Zusammenbruchszeit := Natural (abs (LeseWeltkarteneinstellungen.Waagerechte + 2 * Vernichtungsbereich.WaagerechteAnfang) / 10 );
            end if;
               
         when others =>
            EingesetztePZB := LeseAllgemeines.EingesetztePZB;
            
            if
              LeseWeltkarteneinstellungen.Senkrechte <= KartenDatentypen.Senkrechte (LeseWeltkarteneinstellungen.Waagerechte)
              and
                Zusammenbruchszeit > Natural (abs (LeseWeltkarteneinstellungen.Senkrechte + 2 * Vernichtungsbereich.SenkrechteAnfang) / 10) / EingesetztePZB
            then
               Zusammenbruchszeit := Natural (abs (LeseWeltkarteneinstellungen.Senkrechte + 2 * Vernichtungsbereich.SenkrechteAnfang) / 10) / EingesetztePZB;
               
            elsif
              LeseWeltkarteneinstellungen.Senkrechte > KartenDatentypen.Senkrechte (LeseWeltkarteneinstellungen.Waagerechte)
              and
                Zusammenbruchszeit > Natural (abs (LeseWeltkarteneinstellungen.Waagerechte + 2 * Vernichtungsbereich.WaagerechteAnfang) / 10) / EingesetztePZB
            then
               Zusammenbruchszeit := Natural (abs (LeseWeltkarteneinstellungen.Waagerechte + 2 * Vernichtungsbereich.WaagerechteAnfang) / 10) / EingesetztePZB;
                  
            else
               null;
            end if;
      end case;
      
      SchreibeAllgemeines.Zusammenbruchszeit (ZeitExtern          => Zusammenbruchszeit,
                                              RechnenSetzenExtern => False);
         
      PlanetenVernichten (KoordinatenExtern         => LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern),
                          VernichtungsbereichExtern => Vernichtungsbereich);
      
      case
        LeseSpeziesbelegung.Besiegt (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
      is
         when True =>
            return;
            
         when False =>
            null;
      end case;
      
      SpeziesSchleife:
      for SpeziesSchleifenwert in SpeziesDatentypen.Spezies_Vorhanden_Enum'Range loop
         
         if
           SpeziesSchleifenwert = EinheitSpeziesNummerExtern.Spezies
           or
             LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesSchleifenwert) = SpeziesDatentypen.Leer_Spieler_Enum
           or
             LeseSpeziesbelegung.Besiegt (SpeziesExtern => SpeziesSchleifenwert) = True
         then
            null;
            
         else
            DiplomatischerZustandAenderbarLogik.StatusÄnderbarkeitPrüfen (SpeziesEinsExtern                   => EinheitSpeziesNummerExtern.Spezies,
                                                                            SpeziesZweiExtern                   => SpeziesSchleifenwert,
                                                                            NeuerStatusExtern                   => DiplomatieDatentypen.Krieg_Enum,
                                                                            ZeitbegrenzungBerücksichtigenExtern => False);
            SchreibeDiplomatie.AktuelleSympathie (SpeziesEinsExtern   => EinheitSpeziesNummerExtern.Spezies,
                                                  SpeziesZweiExtern   => SpeziesSchleifenwert,
                                                  SympathieExtern     => DiplomatieDatentypen.MeinungsänderungFeldeffekte (KartenextraDatentypen.Vernichtet_Enum, EinheitSpeziesNummerExtern.Spezies),
                                                  RechnenSetzenExtern => False);
         end if;
         
      end loop SpeziesSchleife;
      
   end PZBEingesetzt;
   
   
   
   procedure PlanetenVernichten
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      VernichtungsbereichExtern : in KartenRecords.EffektbereichRecord)
   is
      use type KartenDatentypen.Ebene;
   begin
      
      EbeneSchleife:
      for EbeneSchleifenwert in KartenKonstanten.AnfangEbene .. KartenKonstanten.EndeEbene loop
         SenkrechteSchleife:
         for SenkrechteSchleifenwert in VernichtungsbereichExtern.SenkrechteAnfang .. VernichtungsbereichExtern.SenkrechteEnde loop
            WaagerechteSchleife:
            for WaagerechteSchleifenwert in VernichtungsbereichExtern.WaagerechteAnfang .. VernichtungsbereichExtern.WaagerechteEnde loop

               Kartenwert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => (EbeneSchleifenwert, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte),
                                                                                                         ÄnderungExtern    => (KartenKonstanten.LeerEbeneÄnderung, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                                                                                         TaskExtern        => SystemDatentypen.Logik_Task_Enum);
               
               case
                 Kartenwert.Ebene
               is
                  when KartenKonstanten.LeerEbene =>
                     null;
                     
                  when others =>
                     FeldVernichten (KoordinatenExtern => Kartenwert);
               end case;

            end loop WaagerechteSchleife;
         end loop SenkrechteSchleife;
      end loop EbeneSchleife;
      
   end PlanetenVernichten;
   
   
   
   -- Hier die Entfernung von Grund/Verbesserungen nicht durch die Platzierungssysteme vornehmen, da ja alles zerstört wird wäre das hier unsinnig.
   procedure FeldVernichten
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
   is begin
      
      Einheit := EinheitSuchenLogik.KoordinatenEinheitOhneSpeziesSuchen (KoordinatenExtern => KoordinatenExtern,
                                                                         TaskExtern        => SystemDatentypen.Logik_Task_Enum);
      
      case
        Einheit.Nummer
      is
         when EinheitenKonstanten.LeerNummer =>
            null;
            
         when others =>
            EinheitenErzeugenEntfernenLogik.EinheitEntfernen (EinheitSpeziesNummerExtern => Einheit);
      end case;
      
      Stadt := StadtSuchenLogik.KoordinatenStadtOhneSpeziesSuchen (KoordinatenExtern => KoordinatenExtern);
      
      case
        Stadt.Nummer
      is
         when StadtKonstanten.LeerNummer =>
            null;
            
         when others =>
            StadtEntfernenLogik.StadtEntfernen (StadtSpeziesNummerExtern => Stadt);
      end case;
      
      SchreibeWeltkarte.Gesamtgrund (KoordinatenExtern => KoordinatenExtern,
                                     GrundExtern       => (KartengrundDatentypen.Vernichtet_Enum, KartengrundDatentypen.Leer_Zusatzgrund_Enum));
      SchreibeWeltkarte.Fluss (KoordinatenExtern => KoordinatenExtern,
                               FlussExtern       => KartenextraDatentypen.Leer_Fluss_Enum);
      SchreibeWeltkarte.Weg (KoordinatenExtern => KoordinatenExtern,
                             WegExtern         => KartenverbesserungDatentypen.Leer_Weg_Enum);
      SchreibeWeltkarte.Verbesserung (KoordinatenExtern  => KoordinatenExtern,
                                      VerbesserungExtern => KartenverbesserungDatentypen.Leer_Verbesserung_Enum);
      SchreibeWeltkarte.Ressource (KoordinatenExtern => KoordinatenExtern,
                                   RessourceExtern   => KartenextraDatentypen.Leer_Ressource_Enum);
      
   end FeldVernichten;

end PZBEingesetztLogik;
