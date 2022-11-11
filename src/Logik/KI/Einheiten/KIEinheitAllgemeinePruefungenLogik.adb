with EinheitenRecords; use EinheitenRecords;
with EinheitenDatentypen; use EinheitenDatentypen;
with EinheitenKonstanten;
with KartenKonstanten;

with LeseWeltkarte;
with LeseEinheitenDatenbank;
with LeseEinheitenGebaut;

with EinheitSuchenLogik;
with PassierbarkeitspruefungLogik;
with ForschungstestsLogik;
with KartenkoordinatenberechnungssystemLogik;

package body KIEinheitAllgemeinePruefungenLogik is
   
   -- Einige Prüfungen sind nicht immer 100% sinnvoll, beispielsweise von KIEinheitFestlegenVerbesserungen.StadtumgebungVerbessern kommend ist die Sichtbarkeitsprüfung ein wenig unsinnig.
   -- Aber nur dafür eine Extrafunktion scheint ein wenig übertrieben?
   -- Werde wohl mehrere Versionen bauen müssen? äöü
   -- Alleine schon wegen der Prüfung in AktuellUnpassierbar. äöü
   function KartenfeldPrüfen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is begin
      
      EinheitAufFeld := EinheitSuchenLogik.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => KoordinatenExtern,
                                                                              LogikGrafikExtern => True);
      
      if
        EinheitAufFeld.Nummer /= EinheitenKonstanten.LeerNummer
        and
          EinheitAufFeld /= EinheitRasseNummerExtern
      then
         return False;
      
      elsif
        False = PassierbarkeitspruefungLogik.PassierbarkeitPrüfenNummer (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                          NeueKoordinatenExtern    => KoordinatenExtern)
      then
         return False;
         
      elsif
        True = AktuellUnpassierbar (KoordinatenExtern        => KoordinatenExtern,
                                    EinheitRasseNummerExtern => EinheitRasseNummerExtern)
      then
         return False;
                  
      elsif
        False = LeseWeltkarte.Sichtbar (KoordinatenExtern => KoordinatenExtern,
                                        RasseExtern       => EinheitRasseNummerExtern.Rasse)
      then
         return False;
         
      else
         return True;
      end if;
      
   end KartenfeldPrüfen;
   
   
   
   -- Das prüft auch nicht für die Ebenen darunter und drüber, auch mal anpassen. äöü
   -- Oder muss das angepasst werden?
   function AktuellUnpassierbar
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      UmgebungPrüfen := 1;
      BereitsGeprüft := UmgebungPrüfen - 1;
      
      PassierbareUmgebungSchleife:
      loop
         
         BlockierteFelder := 0;
         
         YAchseSchleife:
         for YAchseSchleifenwert in -UmgebungPrüfen .. UmgebungPrüfen loop
            XAchseSchleife:
            for XAchseSchleifenwert in -UmgebungPrüfen .. UmgebungPrüfen loop
               
               if
                 BereitsGeprüft >= abs (YAchseSchleifenwert)
                 and
                   BereitsGeprüft >= abs (XAchseSchleifenwert)
               then
                  null;
                  
               else
                  Kartenwert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => KoordinatenExtern,
                                                                                                            ÄnderungExtern    => (KartenKonstanten.LeerEAchseÄnderung, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                            LogikGrafikExtern => True);
            
                  case
                    Kartenwert.XAchse
                  is
                     when KartenKonstanten.LeerXAchse =>
                        BlockierteFelder := BlockierteFelder + 1;
                  
                     when others =>
                        BlockierteFelder := BlockierteFelder + FeldUnpassierbar (KoordinatenExtern        => Kartenwert,
                                                                                 EinheitRasseNummerExtern => EinheitRasseNummerExtern);
                        
                  end case;
               end if;
            
            end loop XAchseSchleife;
         end loop YAchseSchleife;
         
         case
           UmgebungPrüfen
         is
            when 1 =>
               if
                 BlockierteFelder >= UmgebungPrüfen * 8
               then
                  exit PassierbareUmgebungSchleife;
            
               else
                  null;
               end if;
               
            when 2 =>
               if
                 BlockierteFelder >= UmgebungPrüfen * 8 -- 16
               then
                  exit PassierbareUmgebungSchleife;
            
               else
                  null;
               end if;
               
            when others =>
               if
                 BlockierteFelder >= UmgebungPrüfen * 8 -- 24
               then
                  exit PassierbareUmgebungSchleife;
            
               else
                  return False;
               end if;
         end case;
         
         UmgebungPrüfen := UmgebungPrüfen + 1;
         BereitsGeprüft := UmgebungPrüfen - 1;
                  
      end loop PassierbareUmgebungSchleife;
      
      TransportMöglich := LeseEinheitenDatenbank.KannTransportiertWerden (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                           IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
      
      case
        TransportMöglich
      is
         when EinheitenDatentypen.Kein_Transport_Enum =>
            return True;
            
         when others =>
            TransporterErforscht := False;
      end case;
      
      TransporterID := EinheitenKonstanten.LeerID;
            
      EinheitenartSchleife:
      for EinheitenartSchleifenwert in EinheitenDatentypen.EinheitenID'Range loop
         
         if
           TransportMöglich >= LeseEinheitenDatenbank.KannTransportieren (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                           IDExtern    => EinheitenartSchleifenwert)
         then
            case
              ForschungstestsLogik.TechnologieVorhanden (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                                         TechnologieExtern => LeseEinheitenDatenbank.Anforderungen (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                                                                    IDExtern    => EinheitenartSchleifenwert))
            is
               when True =>
                  -- Hier auch prüfen ob ein Transporter dieser Art existiert und wenn nicht weitersuchen. äöü
                  TransporterID := EinheitenartSchleifenwert;
                  exit EinheitenartSchleife;
                  
               when False =>
                  null;
            end case;
               
         else
            null;
         end if;
         
      end loop EinheitenartSchleife;
      
      return True;
      
   end AktuellUnpassierbar;
   
   
   
   function FeldUnpassierbar
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KartenDatentypen.SichtweiteNatural
   is begin
      
      case
        PassierbarkeitspruefungLogik.PassierbarkeitPrüfenNummer (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                  NeueKoordinatenExtern    => KoordinatenExtern)
      is
         when True =>
            return 0;
            
         when False =>
            return 1;
      end case;
      
   end FeldUnpassierbar;
        
end KIEinheitAllgemeinePruefungenLogik;
