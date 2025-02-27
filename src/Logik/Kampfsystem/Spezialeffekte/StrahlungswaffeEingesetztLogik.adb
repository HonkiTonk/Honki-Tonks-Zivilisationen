with KartenKonstanten;
with KartenextraDatentypen;
with DiplomatieDatentypen;
with SpeziesKonstanten;
with SystemDatentypen;

with LeseEinheitenDatenbank;
with LeseEinheitenGebaut;
with SchreibeWeltkarte;
with SchreibeDiplomatie;
with LeseWeltkarte;

with KartenkoordinatenberechnungssystemLogik;
with DiplomatischerZustandAenderbarLogik;
with EinheitSuchenLogik;

package body StrahlungswaffeEingesetztLogik is

   procedure StrahlungswaffeEingesetzt
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
   is
      use type SpeziesDatentypen.Spezies_Enum;
   begin
      
      Strahlungsbereich := LeseEinheitenDatenbank.Effektreichweite (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies,
                                                                    IDExtern      => LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern),
                                                                    EffektExtern  => KartenextraDatentypen.Strahlung_Enum);
      
      Koordinaten := LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      
      case
        Koordinaten.Ebene
      is
         when KartenKonstanten.HimmelKonstante =>
            Strahlungshöhe.EbeneAnfang := KartenKonstanten.OberflächeKonstante;
            Strahlungshöhe.EbeneEnde := KartenKonstanten.HimmelKonstante;

         when others =>
            Strahlungshöhe.EbeneAnfang := Koordinaten.Ebene;
            Strahlungshöhe.EbeneEnde := Koordinaten.Ebene;
      end case;
      
      EbeneSchleife:
      for EbeneSchleifenwert in Strahlungshöhe.EbeneAnfang .. Strahlungshöhe.EbeneEnde loop
         SenkrechteSchleife:
         for SenkrechteSchleifenwert in Strahlungsbereich.SenkrechteAnfang .. Strahlungsbereich.SenkrechteEnde loop
            WaagerechteSchleife:
            for WaagerechteSchleifenwert in Strahlungsbereich.WaagerechteAnfang .. Strahlungsbereich.WaagerechteEnde loop

               Kartenwert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => (EbeneSchleifenwert, Koordinaten.Senkrechte, Koordinaten.Waagerechte),
                                                                                                         ÄnderungExtern    => (KartenKonstanten.LeerEbeneÄnderung, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                                                                                         TaskExtern        => SystemDatentypen.Logik_Task_Enum);
               
               case
                 Kartenwert.Ebene
               is
                  when KartenKonstanten.LeerEbene =>
                     null;
                     
                  when others =>
                     SchreibeWeltkarte.Feldeffekt (KoordinatenExtern => Kartenwert,
                                                   FeldeffektExtern  => KartenextraDatentypen.Strahlung_Enum);
                     Spezies := LeseWeltkarte.SpeziesBelegtGrund (KoordinatenExtern => Kartenwert);
                     
                     if
                       Spezies = EinheitSpeziesNummerExtern.Spezies
                       or
                         Spezies = SpeziesKonstanten.LeerSpezies
                     then
                        null;
                        
                     else
                        DiplomatischerZustandAenderbarLogik.StatusÄnderbarkeitPrüfen (SpeziesEinsExtern                   => EinheitSpeziesNummerExtern.Spezies,
                                                                                        SpeziesZweiExtern                   => Spezies,
                                                                                        NeuerStatusExtern                   => DiplomatieDatentypen.Krieg_Enum,
                                                                                        ZeitbegrenzungBerücksichtigenExtern => False);
                     end if;
                     
                     Spezies := EinheitSuchenLogik.KoordinatenEinheitOhneSpeziesSuchen (KoordinatenExtern => Kartenwert,
                                                                                        TaskExtern        => SystemDatentypen.Logik_Task_Enum).Spezies;
                     
                     if
                       Spezies = EinheitSpeziesNummerExtern.Spezies
                       or
                         Spezies = SpeziesKonstanten.LeerSpezies
                     then
                        null;
                        
                     else
                        DiplomatischerZustandAenderbarLogik.StatusÄnderbarkeitPrüfen (SpeziesEinsExtern                   => EinheitSpeziesNummerExtern.Spezies,
                                                                                        SpeziesZweiExtern                   => Spezies,
                                                                                        NeuerStatusExtern                   => DiplomatieDatentypen.Krieg_Enum,
                                                                                        ZeitbegrenzungBerücksichtigenExtern => False);
                     end if;
               end case;

            end loop WaagerechteSchleife;
         end loop SenkrechteSchleife;
      end loop EbeneSchleife;
      
      SpeziesSchleife:
      for SpeziesSchleifenwert in SpeziesDatentypen.Spezies_Vorhanden_Enum'Range loop
         
         if
           SpeziesSchleifenwert = EinheitSpeziesNummerExtern.Spezies
           or
             LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesSchleifenwert) = SpeziesDatentypen.Leer_Spieler_Enum
         then
            null;
            
         else
            SchreibeDiplomatie.AktuelleSympathie (SpeziesEinsExtern   => EinheitSpeziesNummerExtern.Spezies,
                                                  SpeziesZweiExtern   => SpeziesSchleifenwert,
                                                  SympathieExtern     => DiplomatieDatentypen.MeinungsänderungFeldeffekte (KartenextraDatentypen.Strahlung_Enum, EinheitSpeziesNummerExtern.Spezies),
                                                  RechnenSetzenExtern => True);
         end if;
         
      end loop SpeziesSchleife;
      
   end StrahlungswaffeEingesetzt;

end StrahlungswaffeEingesetztLogik;
