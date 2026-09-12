with KartenKonstanten;
with KartenfluesseDatentypen;
with DiplomatieDatentypen;
with SpeziesKonstanten;
with SystemDatentypen;
with KarteneffekteDatentypen;
with KartenbasisgrundDatentypen;

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
                                                                  EffektExtern  => KarteneffekteDatentypen.Chemisch_Enum);
      
      Koordinaten := LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      
      case
        Koordinaten.Ebene
      is
         when KartenKonstanten.HimmelKonstante =>
            Gefahrenhöhe.EbeneAnfang := KartenKonstanten.OberflächeKonstante;
            Gefahrenhöhe.EbeneEnde := KartenKonstanten.HimmelKonstante;

         when others =>
            Gefahrenhöhe.EbeneAnfang := Koordinaten.Ebene;
            Gefahrenhöhe.EbeneEnde := Koordinaten.Ebene;
      end case;
      
      EbeneSchleife:
      for EbeneSchleifenwert in Gefahrenhöhe.EbeneAnfang .. Gefahrenhöhe.EbeneEnde loop
         SenkrechteSchleife:
         for SenkrechteSchleifenwert in Gefahrenbereich.SenkrechteAnfang .. Gefahrenbereich.SenkrechteEnde loop
            WaagerechteSchleife:
            for WaagerechteSchleifenwert in Gefahrenbereich.WaagerechteAnfang .. Gefahrenbereich.WaagerechteEnde loop

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
                                                   FeldeffektExtern  => KarteneffekteDatentypen.Chemisch_Enum);
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
                                                  SympathieExtern     => DiplomatieDatentypen.MeinungsänderungFeldeffekte (KarteneffekteDatentypen.Chemisch_Enum, EinheitSpeziesNummerExtern.Spezies),
                                                  RechnenSetzenExtern => True);
         end if;
         
      end loop SpeziesSchleife;
      
   end ChemischeWaffeEingesetzt;
   
   
   
   -- Hier auch noch die Kriegserklärung/Meinungsverschlechterung einbauen. äöü
   procedure Wasserverschmutzung
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
   is
      use type KartenDatentypen.EbeneBasis;
      use type KartenfluesseDatentypen.Fluss_Enum;
      use type KartenbasisgrundDatentypen.Basisgrund_Enum;
   begin
      
      case
        LeseWeltkarte.Fluss (KoordinatenExtern => KoordinatenExtern)
      is
         when KartenfluesseDatentypen.Leer_Fluss_Enum | KartenfluesseDatentypen.Fluss_Kernfläche_Enum'Range =>
            return;
            
         when others =>
            null;
      end case;
      
      SenkrechteSchleife:
      for SenkrechteSchleifenwert in KartenDatentypen.SenkrechteUmgebungEins'Range loop
         WaagerechteSchleife:
         for WaagerechteSchleifenwert in KartenDatentypen.WaagerechteUmgebungEins'Range loop

            KartenwertFluss := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => KoordinatenExtern,
                                                                                                           ÄnderungExtern    => (KartenKonstanten.LeerEbeneÄnderung, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                                                                                           TaskExtern        => SystemDatentypen.Logik_Task_Enum);
               
            if
              KartenwertFluss.Ebene = KartenKonstanten.LeerEbene
            then
               null;
               
            elsif
              True = LeseWeltkarte.Effekt (KoordinatenExtern   => KartenwertFluss,
                                           WelcherEffektExtern => KarteneffekteDatentypen.Chemisch_Enum)
            then
               null;
               
            elsif
              LeseWeltkarte.Fluss (KoordinatenExtern => KartenwertFluss) = KartenfluesseDatentypen.Leer_Fluss_Enum
            then
               null;
               
            elsif
              LeseWeltkarte.Basisgrund (KoordinatenExtern => KartenwertFluss) = KartenbasisgrundDatentypen.Küstengewässer_Enum
            then
               SchreibeWeltkarte.Feldeffekt (KoordinatenExtern => KartenwertFluss,
                                             FeldeffektExtern  => KarteneffekteDatentypen.Chemisch_Enum);
                     
            else
               SchreibeWeltkarte.Feldeffekt (KoordinatenExtern => KartenwertFluss,
                                             FeldeffektExtern  => KarteneffekteDatentypen.Chemisch_Enum);
               Wasserverschmutzung (KoordinatenExtern => KartenwertFluss);
            end if;

         end loop WaagerechteSchleife;
      end loop SenkrechteSchleife;
      
   end Wasserverschmutzung;

end ChemischeWaffeEingesetztLogik;
