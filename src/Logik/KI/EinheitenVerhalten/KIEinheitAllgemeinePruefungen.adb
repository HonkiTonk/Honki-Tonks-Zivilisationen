pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartengrundDatentypen; use KartengrundDatentypen;
with EinheitenRecords; use EinheitenRecords;
with EinheitenDatentypen; use EinheitenDatentypen;
with EinheitenKonstanten;
with KartenKonstanten;

with LeseKarten;

with EinheitSuchen;
with BewegungPassierbarkeitPruefen;

with Kartenkoordinatenberechnungssystem;

package body KIEinheitAllgemeinePruefungen is
   
   -- Einige Prüfungen sind nicht immer 100% sinnvoll, beispielsweise von KIEinheitFestlegenVerbesserungen.StadtumgebungVerbessern kommend ist die Sichtbarkeitsprüfung ein wenig unsinnig,
   -- aber nur dafür eine Extrafunktion schein ein wenig übertrieben.
   -- Werde wohl mehrere Versionen bauen müssen. äöü
   function KartenfeldPrüfen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is begin
      
      EinheitAufFeld := EinheitSuchen.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => KoordinatenExtern,
                                                                         LogikGrafikExtern => True);
      
      if
        EinheitAufFeld.Nummer /= EinheitenKonstanten.LeerNummer
        and
          EinheitAufFeld /= EinheitRasseNummerExtern
      then
         return False;
      
      elsif
        False = BewegungPassierbarkeitPruefen.PassierbarkeitPrüfenNummer (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                           NeueKoordinatenExtern    => KoordinatenExtern)
      then
         return False;
         
      elsif
        True = AktuellUnpassierbar (KoordinatenExtern => KoordinatenExtern,
                                    RasseExtern       => EinheitRasseNummerExtern.Rasse)
      then
         return False;
                  
      elsif
        False = LeseKarten.Sichtbar (KoordinatenExtern => KoordinatenExtern,
                                     RasseExtern       => EinheitRasseNummerExtern.Rasse)
      then
         return False;
         
      else
         return True;
      end if;
      
   end KartenfeldPrüfen;
   
   
   
   function AktuellUnpassierbar
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
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
                  Wasserumgebung := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => KoordinatenExtern,
                                                                                                           ÄnderungExtern    => (0, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                           LogikGrafikExtern => True);
            
                  case
                    Wasserumgebung.XAchse
                  is
                     when KartenKonstanten.LeerXAchse =>
                        BlockierteFelder := BlockierteFelder + 1;
                  
                     when others =>
                        BlockierteFelder := BlockierteFelder + FeldUnpassierbar (KoordinatenExtern => Wasserumgebung,
                                                                                 RasseExtern       => RasseExtern);
                        
                  end case;
               end if;
            
            end loop XAchseSchleife;
         end loop YAchseSchleife;
         
         case
           UmgebungPrüfen
         is
            when 1 =>
               if
                 BlockierteFelder >= 8
               then
                  return True;
            
               else
                  null;
               end if;
               
            when 2 =>
               if
                 BlockierteFelder >= 16
               then
                  return True;
            
               else
                  null;
               end if;
               
            when others =>
               if
                 BlockierteFelder >= 24
               then
                  return True;
            
               else
                  return False;
               end if;
         end case;
         
         UmgebungPrüfen := UmgebungPrüfen + 1;
         BereitsGeprüft := UmgebungPrüfen - 1;
                  
      end loop PassierbareUmgebungSchleife;
      
      -- Hier später noch brauchbare Prüfungen auf vorhandene Technologie und Wassertransporter einbauen. äöü
      -- Die Technologieprüfung mit in die Passierbarkeitsprüfung werfen? Bzw. eine Abspaltung davon für die KI vornehmen. äöü
      -- ForschungenSchleife:
      -- for ForschungSchleifenwert in ForschungenDatentypen.ForschungID'Range loop
         
      --    null;
         
      -- end loop ForschungenSchleife;
      
      -- return True;
      
   end AktuellUnpassierbar;
   
   
   
   function FeldUnpassierbar
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return KartenDatentypen.SichtweiteNatural
   is begin
      
      WelcherGrund := LeseKarten.BasisGrund (KoordinatenExtern => KoordinatenExtern);
                  
      if
        RasseExtern in RassenDatentypen.Rassen_Überirdisch_Enum'Range
        and
          (WelcherGrund = KartengrundDatentypen.Wasser_Enum
           or
             WelcherGrund = KartengrundDatentypen.Küstengewässer_Enum)
      then
         return 1;
                     
      elsif
        RasseExtern = RassenDatentypen.Tesorahn_Enum
        and
          WelcherGrund not in KartengrundDatentypen.Kartengrund_Unterfläche_Wasser_Enum
      then
         return 1;
                     
      elsif
        RasseExtern = RassenDatentypen.Talbidahr_Enum
        and
          WelcherGrund not in KartengrundDatentypen.Kartengrund_Unterfläche_Land_Enum
      then
         return 1;
               
      else
         return 0;
      end if;
      
   end FeldUnpassierbar;
        
end KIEinheitAllgemeinePruefungen;
