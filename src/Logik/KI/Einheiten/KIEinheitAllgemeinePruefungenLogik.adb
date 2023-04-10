with SpeziesKonstanten;

with LeseWeltkarte;

with EinheitSuchenLogik;
with PassierbarkeitspruefungLogik;

with KIBewegungAllgemeinLogik;

package body KIEinheitAllgemeinePruefungenLogik is
   
   -- Einige Prüfungen sind nicht immer 100% sinnvoll, beispielsweise von KIEinheitFestlegenVerbesserungen.StadtumgebungVerbessern kommend ist die Sichtbarkeitsprüfung ein wenig unsinnig.
   -- Aber nur dafür eine Extrafunktion scheint ein wenig übertrieben?
   -- Werde wohl mehrere Versionen bauen müssen? äöü
   function KartenfeldPrüfen
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is begin
      
      if
        True = EinheitBlockiert (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                 KoordinatenExtern          => KoordinatenExtern)
      then
         return False;
      
      elsif
        False = PassierbarkeitspruefungLogik.PassierbarkeitPrüfenNummer (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                                          NeueKoordinatenExtern      => KoordinatenExtern)
      then
         return False;
         
         -- Hier noch einen Weg finden einen Transporter einzubauen. äöü
                  
      elsif
        False = LeseWeltkarte.Sichtbar (KoordinatenExtern => KoordinatenExtern,
                                        SpeziesExtern     => EinheitSpeziesNummerExtern.Spezies)
      then
         return False;
         
      else
         return True;
      end if;
      
   end KartenfeldPrüfen;
   
   
   
   function EinheitBlockiert
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is
      use type EinheitenDatentypen.MaximaleEinheitenMitNullWert;
      use type EinheitenRecords.SpeziesEinheitnummerRecord;
      use type SpeziesDatentypen.Spezies_Enum;
   begin
            
      EinheitAufFeld := EinheitSuchenLogik.KoordinatenEinheitOhneSpeziesSuchen (KoordinatenExtern => KoordinatenExtern,
                                                                                LogikGrafikExtern => True);
      
      if
        EinheitAufFeld.Nummer = EinheitenKonstanten.LeerNummer
        or
          EinheitAufFeld = EinheitSpeziesNummerExtern
      then
         return False;
         
      elsif
        EinheitAufFeld.Spezies /= SpeziesKonstanten.LeerSpezies
        and
          EinheitAufFeld.Spezies /= EinheitSpeziesNummerExtern.Spezies
      then
         return True;
         
      elsif
        False = KIBewegungAllgemeinLogik.EinheitentauschMöglich (BlockierendeEinheitExtern => EinheitAufFeld)
      then
         return True;
         
      else
         return False;
      end if;
            
   end EinheitBlockiert;
   
   
   
   function FeldUnpassierbar
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return KartenDatentypen.SichtweiteNatural
   is begin
      
      case
        PassierbarkeitspruefungLogik.PassierbarkeitPrüfenNummer (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                                  NeueKoordinatenExtern      => KoordinatenExtern)
      is
         when True =>
            return 0;
            
         when False =>
            return 1;
      end case;
      
   end FeldUnpassierbar;
        
end KIEinheitAllgemeinePruefungenLogik;
