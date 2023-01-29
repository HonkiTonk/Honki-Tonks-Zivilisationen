with KartenKonstanten;

with LeseWeltkarte;
with SchreibeEinheitenGebaut;
with LeseEinheitenGebaut;
with LeseAllgemeines;

with PassierbarkeitspruefungLogik;
with KartenkoordinatenberechnungssystemLogik;

with KIDatentypen;
with KIKonstanten;

with KIAufgabenVerteiltLogik;
with KIEinheitAllgemeinePruefungenLogik;
with KIAchsenzufallLogik;

package body KIEinheitFestlegenErkundenLogik is

   function Erkunden
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
   is begin
      
      EinheitKoordinaten := LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      
      case
        KIEinheitAllgemeinePruefungenLogik.DirekteUmgebung (KoordinatenExtern          => EinheitKoordinaten,
                                                            EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern)
      is
         when False =>
            return False;
            
         when True =>
            UmgebungPrüfen := 2;
            BereitsGeprüft := UmgebungPrüfen - 1;
      end case;
      
      UnbekanntesFeldSuchenSchleife:
      while UmgebungPrüfen <= KIKonstanten.Felderreichweite (LeseAllgemeines.Schwierigkeitsgrad) loop
         
         case
           ZielSuchen (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                       KoordinatenExtern          => EinheitKoordinaten,
                       KartenreichweiteExtern     => UmgebungPrüfen,
                       GeprüftExtern              => BereitsGeprüft)
         is
            when True =>
               return True;
               
            when False =>
               UmgebungPrüfen := UmgebungPrüfen + 1;
               BereitsGeprüft := UmgebungPrüfen - 1;
         end case;
         
      end loop UnbekanntesFeldSuchenSchleife;
      
      return False;
      
   end Erkunden;
   
   
   
   -- Warum wird bei all diesen Dinger hier immer nur eine Achse geprüft und nicht alle? äöü
   -- Oder ein sich vergrößernder Bereich. äöü
   function ZielSuchen
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      KartenreichweiteExtern : in KartenDatentypen.KartenfeldNatural;
      GeprüftExtern : in KartenDatentypen.KartenfeldNatural)
      return Boolean
   is
      use type KartenDatentypen.Ebene;
   begin
      
      Zufallsmultiplikator := KIAchsenzufallLogik.AlleAchsen;
      
      EAchseSchleife:
      for EAchseSchleifenwert in KartenDatentypen.EbenenbereichEins'Range loop
         YAchseSchleife:
         for YAchseSchleifenwert in -KartenreichweiteExtern .. KartenreichweiteExtern loop
            XAchseSchleife:
            for XAchseSchleifenwert in -KartenreichweiteExtern .. KartenreichweiteExtern loop
            
               if
                 GeprüftExtern > abs (YAchseSchleifenwert)
                 and
                   GeprüftExtern > abs (XAchseSchleifenwert)
               then
                  null;
                  
               else
                  KartenWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => KoordinatenExtern,
                                                                                                            ÄnderungExtern    => (Zufallsmultiplikator.EAchse * EAchseSchleifenwert,
                                                                                                                                   Zufallsmultiplikator.YAchse * YAchseSchleifenwert,
                                                                                                                                   Zufallsmultiplikator.XAchse * XAchseSchleifenwert),
                                                                                                            LogikGrafikExtern => True);
                  
                  if
                    KartenWert.XAchse = KartenKonstanten.LeerXAchse
                  then
                     null;
                        
                  elsif
                    False = LeseWeltkarte.Sichtbar (KoordinatenExtern => KartenWert,
                                                    SpeziesExtern     => EinheitSpeziesNummerExtern.Spezies)
                    and
                      True = PassierbarkeitspruefungLogik.PassierbarkeitPrüfenNummer (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                                                       NeueKoordinatenExtern      => KartenWert)
                    and
                      False = KIAufgabenVerteiltLogik.EinheitZiel (SpeziesExtern         => EinheitSpeziesNummerExtern.Spezies,
                                                                   ZielKoordinatenExtern => KartenWert)
                    -- and
                    --   False = KIEinheitAllgemeinePruefungenLogik.AktuellUnpassierbar (KoordinatenExtern          => KartenWert,
                    --                                                                   EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern)
                  then
                     SchreibeEinheitenGebaut.KIZielKoordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                                KoordinatenExtern          => KartenWert);
                     SchreibeEinheitenGebaut.KIBeschäftigt (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                             AufgabeExtern              => KIDatentypen.Erkunden_Enum);
                     return True;
                     
                  else
                     null;
                  end if;
               end if;
            
            end loop XAchseSchleife;
         end loop YAchseSchleife;
      end loop EAchseSchleife;
      
      return False;
      
   end ZielSuchen;

end KIEinheitFestlegenErkundenLogik;
