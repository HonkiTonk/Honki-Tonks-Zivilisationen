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
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
   is
      use type KartenRecords.AchsenKartenfeldNaturalRecord;
   begin
      
      NeueStadtKoordinaten := StadtfeldSuchen (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      
      case
        NeueStadtKoordinaten = KartenRecordKonstanten.LeerKoordinate
      is
         when True =>
            return False;
            
         when False =>
            SchreibeEinheitenGebaut.KIZielKoordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                       KoordinatenExtern        => NeueStadtKoordinaten);
            SchreibeEinheitenGebaut.KIBeschäftigt (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                    AufgabeExtern            => KIDatentypen.Stadt_Bauen_Enum);
            return True;
      end case;
      
   end StadtBauen;
   
    
   
   -- Erst um die Einheit und dann um alle Städte herum prüfen, wie bei Verbesserungen? äöü
   function StadtfeldSuchen
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return KartenRecords.AchsenKartenfeldNaturalRecord
   is begin
        
      UmgebungPrüfen := 1;
      BereitsGeprüft := UmgebungPrüfen - 1;
            
      KartenfeldSuchenSchleife:
      while UmgebungPrüfen <= KIKonstanten.Felderreichweite (LeseAllgemeines.Schwierigkeitsgrad) loop
         
         MöglichesFeld := NeuesStadtfeld (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
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
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      UmgebungExtern : in KartenDatentypen.KartenfeldNatural;
      GeprüftExtern : in KartenDatentypen.KartenfeldNatural)
      return KartenRecords.AchsenKartenfeldNaturalRecord
   is
      use type KartenDatentypen.Ebene;
   begin
      
      Zufallsmultiplikator := KIAchsenzufallLogik.AlleAchsen;

      EinheitenKoordinaten := LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);

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
                     FeldGutUndFrei := KartenfeldUmgebungPrüfen (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                                  KoordinatenExtern        => MöglichesStadtfeld);
                  end if;
               end if;

               if
                 FeldGutUndFrei = False
               then
                  null;

               elsif
                 False = KIAufgabenVerteiltLogik.EinheitAufgabeZiel (AufgabeExtern         => KIDatentypen.Stadt_Bauen_Enum,
                                                                     SpeziesExtern           => EinheitSpeziesNummerExtern.Spezies,
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
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is
      use type KartengrundDatentypen.Basisgrund_Enum;
   begin
      
      case
        KIEinheitAllgemeinePruefungenLogik.KartenfeldPrüfen (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                              KoordinatenExtern        => KoordinatenExtern)
      is
         when False =>
            return False;
            
         when True =>
            null;
      end case;
      
      -- Diese Prüfung hier mal Speziesspezifisch erweitern. äöü
      if
        LeseWeltkarte.Basisgrund (KoordinatenExtern => KoordinatenExtern) = KartengrundDatentypen.Eis_Enum
      then
         return False;
         
      elsif
        False = KIKartenfeldbewertungModifizierenLogik.BewertungStadtBauen (KoordinatenExtern => KoordinatenExtern,
                                                                            SpeziesExtern       => EinheitSpeziesNummerExtern.Spezies)
      then
         return False;
         
      else
         return True;
      end if;
      
   end KartenfeldUmgebungPrüfen;

end KIEinheitFestlegenSiedelnLogik;
