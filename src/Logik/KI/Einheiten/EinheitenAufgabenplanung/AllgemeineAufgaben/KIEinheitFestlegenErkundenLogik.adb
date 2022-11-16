with KartenKonstanten;

with LeseWeltkarte;
with SchreibeEinheitenGebaut;
with LeseEinheitenGebaut;

with PassierbarkeitspruefungLogik;
with KartenkoordinatenberechnungssystemLogik;

with KIDatentypen;

with KIAufgabenVerteiltLogik;
with KIEinheitAllgemeinePruefungenLogik;
with KIAchsenzufallLogik;

package body KIEinheitFestlegenErkundenLogik is

   function Erkunden
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      EinheitKoordinaten := LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
      UmgebungPrüfen := 1;
      BereitsGeprüft := UmgebungPrüfen - 1;
      
      UnbekanntesFeldSuchenSchleife:
      loop
         
         case
           ZielSuchen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                       KoordinatenExtern        => EinheitKoordinaten,
                       KartenreichweiteExtern   => UmgebungPrüfen,
                       GeprüftExtern            => BereitsGeprüft)
         is
            when True =>
               return True;
               
            when False =>
               null;
         end case;
         
         if
           UmgebungPrüfen > 15
         then
            exit UnbekanntesFeldSuchenSchleife;
            
         else
            UmgebungPrüfen := UmgebungPrüfen + 1;
            BereitsGeprüft := UmgebungPrüfen - 1;
         end if;
         
      end loop UnbekanntesFeldSuchenSchleife;
      
      return False;
      
   end Erkunden;
   
   
   
   function ZielSuchen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
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
                                                    RasseExtern       => EinheitRasseNummerExtern.Rasse)
                    and
                      True = PassierbarkeitspruefungLogik.PassierbarkeitPrüfenNummer (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                                       NeueKoordinatenExtern    => KartenWert)
                    and
                      False = KIAufgabenVerteiltLogik.EinheitZiel (RasseExtern           => EinheitRasseNummerExtern.Rasse,
                                                                   ZielKoordinatenExtern => KartenWert)
                    and
                      False = KIEinheitAllgemeinePruefungenLogik.AktuellUnpassierbar (KoordinatenExtern        => KartenWert,
                                                                                      EinheitRasseNummerExtern => EinheitRasseNummerExtern)
                  then
                     SchreibeEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                KoordinatenExtern        => KartenWert);
                     SchreibeEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                             AufgabeExtern            => KIDatentypen.Erkunden_Enum);
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
