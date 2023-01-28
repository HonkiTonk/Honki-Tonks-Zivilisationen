with KartenKonstanten;
with KartengrundDatentypen;
with KartenextraDatentypen;
with DiplomatieDatentypen;

with LeseEinheitenDatenbank;
with LeseEinheitenGebaut;
with SchreibeWeltkarte;
with LeseWeltkarte;
with SchreibeDiplomatie;

with KartenkoordinatenberechnungssystemLogik;

package body ChemischeWaffeEingesetztLogik is

   procedure ChemischeWaffeEingesetzt
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
   is
      use type SpeziesDatentypen.Spezies_Enum;
   begin
      
      Gefahrenbereich := LeseEinheitenDatenbank.Effektreichweite (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies,
                                                                  IDExtern      => LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern));
      
      Koordinaten := LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      
      EAchseSchleife:
      for EAchseSchleifenwert in Gefahrenbereich.EAchseAnfang .. Gefahrenbereich.EAchseEnde loop
         YAchseSchleife:
         for YAchseSchleifenwert in Gefahrenbereich.YAchseAnfang .. Gefahrenbereich.YAchseEnde loop
            XAchseSchleife:
            for XAchseSchleifenwert in Gefahrenbereich.XAchseAnfang .. Gefahrenbereich.XAchseEnde loop

               Kartenwert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => Koordinaten,
                                                                                                         ÄnderungExtern    => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                         LogikGrafikExtern => True);
               
               case
                 Kartenwert.EAchse
               is
                  when KartenKonstanten.LeerEAchse =>
                     null;
                     
                  when others =>
                     SchreibeWeltkarte.Effekt (KoordinatenExtern => Kartenwert,
                                               EffektExtern      => KartengrundDatentypen.Chemisch_Enum);
                     Wasserverschmutzung (KoordinatenExtern => Kartenwert);
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
   
   
   
   procedure Wasserverschmutzung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
   is
      use type KartenDatentypen.Ebene;
      use type KartenextraDatentypen.Fluss_Enum;
   begin
      
      case
        LeseWeltkarte.Fluss (KoordinatenExtern => KoordinatenExtern)
      is
         when KartenextraDatentypen.Leer_Fluss_Enum | KartenextraDatentypen.Fluss_Kern_Enum'Range =>
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
                     
            else
               SchreibeWeltkarte.Effekt (KoordinatenExtern => KartenwertFluss,
                                         EffektExtern      => KartengrundDatentypen.Chemisch_Enum);
               Wasserverschmutzung (KoordinatenExtern => KartenwertFluss);
            end if;

         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end Wasserverschmutzung;

end ChemischeWaffeEingesetztLogik;
