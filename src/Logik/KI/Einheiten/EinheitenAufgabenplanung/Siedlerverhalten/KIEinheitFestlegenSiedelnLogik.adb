with KartengrundDatentypen;
with KartenKonstanten;
with KartenRecordKonstanten;

with SchreibeEinheitenGebaut;
with LeseEinheitenGebaut;
with LeseWeltkarte;
with LeseAllgemeines;

with KartenkoordinatenberechnungssystemLogik;

with KIDatentypen;
with KIKonstanten;

with KIKartenfeldbewertungModifizierenLogik;
with KIAufgabenVerteiltLogik;
with KIEinheitAllgemeinePruefungenLogik;
with KIAchsenzufallLogik;

package body KIEinheitFestlegenSiedelnLogik is

   function StadtBauen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is
      use type KartenRecords.AchsenKartenfeldNaturalRecord;
   begin
      
      NeueStadtKoordinaten := StadtfeldSuchen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      case
        NeueStadtKoordinaten = KartenRecordKonstanten.LeerKoordinate
      is
         when True =>
            return False;
            
         when False =>
            SchreibeEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                       KoordinatenExtern        => NeueStadtKoordinaten);
            SchreibeEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    AufgabeExtern            => KIDatentypen.Stadt_Bauen_Enum);
            return True;
      end case;
      
   end StadtBauen;
   
    
   
   -- Erst um die Einheit und dann um alle Städte herum prüfen, wie bei Verbesserungen? äöü
   function StadtfeldSuchen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KartenRecords.AchsenKartenfeldNaturalRecord
   is begin
        
      UmgebungPrüfen := 1;
      BereitsGeprüft := UmgebungPrüfen - 1;
            
      KartenfeldSuchenSchleife:
      while UmgebungPrüfen <= KIKonstanten.Felderreichweite (LeseAllgemeines.Schwierigkeitsgrad) loop
         
         MöglichesFeld := NeuesStadtfeld (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                           UmgebungExtern           => UmgebungPrüfen,
                                           GeprüftExtern            => BereitsGeprüft);
         
         case
           MöglichesFeld.XAchse
         is
            when KartenKonstanten.LeerXAchse =>
               UmgebungPrüfen := UmgebungPrüfen + 1;
               BereitsGeprüft := UmgebungPrüfen - 1;
               
            when others =>
               return MöglichesFeld;
         end case;
         
      end loop KartenfeldSuchenSchleife;
      
      return KartenRecordKonstanten.LeerKoordinate;
      
   end StadtfeldSuchen;
   
   
   
   function NeuesStadtfeld
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      UmgebungExtern : in KartenDatentypen.KartenfeldNatural;
      GeprüftExtern : in KartenDatentypen.KartenfeldNatural)
      return KartenRecords.AchsenKartenfeldNaturalRecord
   is
      use type KartenDatentypen.Ebene;
   begin
      
      Zufallsmultiplikator := KIAchsenzufallLogik.AlleAchsen;

      EinheitenKoordinaten := LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern);

      EAchseSchleife:
      for EAchseSchleifenwert in KartenDatentypen.EbenenbereichEins loop
         YAchseSchleife:
         for YAchseSchleifenwert in -UmgebungExtern .. UmgebungExtern loop
            XAchseSchleife:
            for XAchseSchleifenwert in -UmgebungExtern .. UmgebungExtern loop
               
               if
                 GeprüftExtern > abs (YAchseSchleifenwert)
                 and
                   GeprüftExtern > abs (XAchseSchleifenwert)
               then
                  FeldGutUndFrei := False;

               else
                  MöglichesStadtfeld := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => EinheitenKoordinaten,
                                                                                                                     ÄnderungExtern    => (Zufallsmultiplikator.EAchse * EAchseSchleifenwert,
                                                                                                                                            Zufallsmultiplikator.YAchse * YAchseSchleifenwert,
                                                                                                                                            Zufallsmultiplikator.XAchse * XAchseSchleifenwert),
                                                                                                                     LogikGrafikExtern => True);

                  if
                    MöglichesStadtfeld.XAchse = KartenKonstanten.LeerXAchse
                  then
                     FeldGutUndFrei := False;

                  else
                     FeldGutUndFrei := KartenfeldUmgebungPrüfen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                  KoordinatenExtern        => MöglichesStadtfeld);
                  end if;
               end if;

               if
                 FeldGutUndFrei = False
               then
                  null;

               elsif
                 False = KIAufgabenVerteiltLogik.EinheitAufgabeZiel (AufgabeExtern         => KIDatentypen.Stadt_Bauen_Enum,
                                                                     RasseExtern           => EinheitRasseNummerExtern.Rasse,
                                                                     ZielKoordinatenExtern => MöglichesStadtfeld)
               then
                  return MöglichesStadtfeld;

               else
                  null;
               end if;

            end loop XAchseSchleife;
         end loop YAchseSchleife;
      end loop EAchseSchleife;

      return KartenRecordKonstanten.LeerKoordinate;

   end NeuesStadtfeld;
   
   
   
   function KartenfeldUmgebungPrüfen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is
      use type KartengrundDatentypen.Basisgrund_Enum;
   begin
      
      case
        KIEinheitAllgemeinePruefungenLogik.KartenfeldPrüfen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                              KoordinatenExtern        => KoordinatenExtern)
      is
         when False =>
            return False;
            
         when True =>
            null;
      end case;
      
      -- Diese Prüfung hier mal rassenspezifisch erweitern. äöü
      if
        LeseWeltkarte.Basisgrund (KoordinatenExtern => KoordinatenExtern) = KartengrundDatentypen.Eis_Enum
      then
         return False;
         
      elsif
        False = KIKartenfeldbewertungModifizierenLogik.BewertungStadtBauen (KoordinatenExtern => KoordinatenExtern,
                                                                            RasseExtern       => EinheitRasseNummerExtern.Rasse)
      then
         return False;
         
      else
         return True;
      end if;
      
   end KartenfeldUmgebungPrüfen;

end KIEinheitFestlegenSiedelnLogik;
