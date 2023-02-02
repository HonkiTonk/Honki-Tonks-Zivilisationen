with KartenKonstanten;
with KartengrundDatentypen;
with DiplomatieDatentypen;
with SpeziesKonstanten;

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
                                                                    EffektExtern  => KartengrundDatentypen.Strahlung_Enum);
      
      Koordinaten := LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      
      case
        Koordinaten.EAchse
      is
         when KartenKonstanten.HimmelKonstante =>
            Strahlungshöhe.EAchseAnfang := KartenKonstanten.OberflächeKonstante;
            Strahlungshöhe.EAchseEnde := KartenKonstanten.HimmelKonstante;

         when others =>
            Strahlungshöhe.EAchseAnfang := Koordinaten.EAchse;
            Strahlungshöhe.EAchseEnde := Koordinaten.EAchse;
      end case;
      
      EAchseSchleife:
      for EAchseSchleifenwert in Strahlungshöhe.EAchseAnfang .. Strahlungshöhe.EAchseEnde loop
         YAchseSchleife:
         for YAchseSchleifenwert in Strahlungsbereich.YAchseAnfang .. Strahlungsbereich.YAchseEnde loop
            XAchseSchleife:
            for XAchseSchleifenwert in Strahlungsbereich.XAchseAnfang .. Strahlungsbereich.XAchseEnde loop

               Kartenwert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => (EAchseSchleifenwert, Koordinaten.YAchse, Koordinaten.XAchse),
                                                                                                         ÄnderungExtern    => (KartenKonstanten.LeerEAchseÄnderung, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                         LogikGrafikExtern => True);
               
               case
                 Kartenwert.EAchse
               is
                  when KartenKonstanten.LeerEAchse =>
                     null;
                     
                  when others =>
                     SchreibeWeltkarte.Feldeffekt (KoordinatenExtern => Kartenwert,
                                                   FeldeffektExtern  => KartengrundDatentypen.Strahlung_Enum);
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
                                                                                        LogikGrafikExtern => True).Spezies;
                     
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

            end loop XAchseSchleife;
         end loop YAchseSchleife;
      end loop EAchseSchleife;
      
      SpeziesSchleife:
      for SpeziesSchleifenwert in SpeziesDatentypen.Spezies_Verwendet_Enum'Range loop
         
         if
           SpeziesSchleifenwert = EinheitSpeziesNummerExtern.Spezies
           or
             LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesSchleifenwert) = SpeziesDatentypen.Leer_Spieler_Enum
         then
            null;
            
         else
            SchreibeDiplomatie.AktuelleSympathie (SpeziesEinsExtern   => EinheitSpeziesNummerExtern.Spezies,
                                                  SpeziesZweiExtern   => SpeziesSchleifenwert,
                                                  SympathieExtern     => DiplomatieDatentypen.MeinungsänderungFeldeffekte (KartengrundDatentypen.Strahlung_Enum, EinheitSpeziesNummerExtern.Spezies),
                                                  RechnenSetzenExtern => True);
         end if;
         
      end loop SpeziesSchleife;
      
   end StrahlungswaffeEingesetzt;

end StrahlungswaffeEingesetztLogik;
