with KartenKonstanten;
with KartengrundDatentypen;
with KartenextraDatentypen;
with DiplomatieDatentypen;
with SpeziesKonstanten;

with LeseEinheitenDatenbank;
with LeseEinheitenGebaut;
with SchreibeWeltkarte;
with LeseWeltkarte;
with SchreibeDiplomatie;

with KartenkoordinatenberechnungssystemLogik;
with DiplomatischerZustandAenderbarLogik;
with EinheitSuchenLogik;

package body ChemischeWaffeEingesetztLogik is

   procedure ChemischeWaffeEingesetzt
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
   is
      use type SpeziesDatentypen.Spezies_Enum;
   begin
      
      Gefahrenbereich := LeseEinheitenDatenbank.Effektreichweite (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies,
                                                                  IDExtern      => LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern),
                                                                  EffektExtern  => KartengrundDatentypen.Chemisch_Enum);
      
      Koordinaten := LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      
      case
        Koordinaten.EAchse
      is
         when KartenKonstanten.HimmelKonstante =>
            Gefahrenhöhe.EAchseAnfang := KartenKonstanten.OberflächeKonstante;
            Gefahrenhöhe.EAchseEnde := KartenKonstanten.HimmelKonstante;

         when others =>
            Gefahrenhöhe.EAchseAnfang := Koordinaten.EAchse;
            Gefahrenhöhe.EAchseEnde := Koordinaten.EAchse;
      end case;
      
      EAchseSchleife:
      for EAchseSchleifenwert in Gefahrenhöhe.EAchseAnfang .. Gefahrenhöhe.EAchseEnde loop
         YAchseSchleife:
         for YAchseSchleifenwert in Gefahrenbereich.YAchseAnfang .. Gefahrenbereich.YAchseEnde loop
            XAchseSchleife:
            for XAchseSchleifenwert in Gefahrenbereich.XAchseAnfang .. Gefahrenbereich.XAchseEnde loop

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
                                                   FeldeffektExtern  => KartengrundDatentypen.Chemisch_Enum);
                     Wasserverschmutzung (KoordinatenExtern => Kartenwert);
                     
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
                                                  SympathieExtern     => DiplomatieDatentypen.MeinungsänderungFeldeffekte (KartengrundDatentypen.Chemisch_Enum, EinheitSpeziesNummerExtern.Spezies),
                                                  RechnenSetzenExtern => True);
         end if;
         
      end loop SpeziesSchleife;
      
   end ChemischeWaffeEingesetzt;
   
   
   
   -- Hier auch noch die Kriegserklärung/Meinungsverschlechterung einbauen? äöü
   procedure Wasserverschmutzung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
   is
      use type KartenDatentypen.Ebene;
      use type KartenextraDatentypen.Fluss_Enum;
      use type KartengrundDatentypen.Basisgrund_Enum;
   begin
      
      case
        LeseWeltkarte.Fluss (KoordinatenExtern => KoordinatenExtern)
      is
         when KartenextraDatentypen.Leer_Fluss_Enum | KartenextraDatentypen.Fluss_Kernfläche_Enum'Range =>
            return;
            
         when others =>
            null;
      end case;
      
      YAchseSchleife:
      for YAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
         XAchseSchleife:
         for XAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop

            KartenwertFluss := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => KoordinatenExtern,
                                                                                                           ÄnderungExtern    => (KartenKonstanten.LeerEAchseÄnderung, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                           LogikGrafikExtern => True);
               
            if
              KartenwertFluss.EAchse = KartenKonstanten.LeerEAchse
            then
               null;
               
            elsif
              True = LeseWeltkarte.Effekt (KoordinatenExtern   => KartenwertFluss,
                                           WelcherEffektExtern => KartengrundDatentypen.Chemisch_Enum)
            then
               null;
               
            elsif
              LeseWeltkarte.Fluss (KoordinatenExtern => KartenwertFluss) = KartenextraDatentypen.Leer_Fluss_Enum
            then
               null;
               
            elsif
              LeseWeltkarte.Basisgrund (KoordinatenExtern => KartenwertFluss) = KartengrundDatentypen.Küstengewässer_Enum
            then
               SchreibeWeltkarte.Feldeffekt (KoordinatenExtern => KartenwertFluss,
                                             FeldeffektExtern  => KartengrundDatentypen.Chemisch_Enum);
                     
            else
               SchreibeWeltkarte.Feldeffekt (KoordinatenExtern => KartenwertFluss,
                                             FeldeffektExtern  => KartengrundDatentypen.Chemisch_Enum);
               Wasserverschmutzung (KoordinatenExtern => KartenwertFluss);
            end if;

         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end Wasserverschmutzung;

end ChemischeWaffeEingesetztLogik;
