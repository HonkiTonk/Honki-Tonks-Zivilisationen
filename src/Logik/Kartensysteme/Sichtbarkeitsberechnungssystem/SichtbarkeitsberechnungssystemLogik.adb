with KartenKonstanten;

with LeseEinheitenGebaut;
with LeseEinheitenDatenbank;
with LeseStadtGebaut;
  
with KartenkoordinatenberechnungssystemLogik;
with SichtbereicheErmittelnLogik;
with SichtbarkeitSetzenLogik;
with QuadrantenberechnungenLogik;

package body SichtbarkeitsberechnungssystemLogik is

   procedure SichtbarkeitsprüfungFürEinheit
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      SichtweiteObjekt := SichtbereicheErmittelnLogik.SichtweiteErmitteln (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      case
        SichtweiteObjekt
      is
         when KartenDatentypen.Sichtweite'First =>
            SichtbarkeitsprüfungOhneBlockade (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                               SichtweiteExtern         => SichtweiteObjekt);
            return;
            
         when 3 =>
            EinheitID := LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
            if
              LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern).EAchse >= KartenKonstanten.OberflächeKonstante
              and
                (True = LeseEinheitenDatenbank.Passierbarkeit (RasseExtern          => EinheitRasseNummerExtern.Rasse,
                                                               IDExtern             => EinheitID,
                                                               WelcheUmgebungExtern => EinheitenDatentypen.Luft_Enum)
                 or
                   True = LeseEinheitenDatenbank.Passierbarkeit (RasseExtern          => EinheitRasseNummerExtern.Rasse,
                                                                 IDExtern             => EinheitID,
                                                                 WelcheUmgebungExtern => EinheitenDatentypen.Weltraum_Enum))
            then
               SichtbarkeitsprüfungOhneBlockade (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                  SichtweiteExtern         => SichtweiteObjekt);
               return;
               
            else
               null;
            end if;
            
         when others =>
            null;
      end case;

      QuadrantenberechnungenLogik.QuadrantenDurchlaufen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                                         SichtweiteExtern  => SichtweiteObjekt,
                                                         KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
      
   end SichtbarkeitsprüfungFürEinheit;
   
   
   
   procedure SichtbarkeitsprüfungOhneBlockade
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      SichtweiteExtern : in KartenDatentypen.Sichtweite)
   is begin
      
      Einheitenkoordinaten := LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      YAchseSchleife:
      for YAchseSchleifenwert in -SichtweiteExtern .. SichtweiteExtern loop
         XAchseSchleife:
         for XAchseSchleifenwert in -SichtweiteExtern .. SichtweiteExtern loop
            
            KartenWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => Einheitenkoordinaten,
                                                                                                      ÄnderungExtern    => (KartenKonstanten.LeerEAchseÄnderung, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                      LogikGrafikExtern => True);
            
            case
              KartenWert.XAchse
            is
               when KartenKonstanten.LeerXAchse =>
                  null;
                  
               when others =>
                  SichtbarkeitSetzenLogik.EbenenBerechnungen (RasseExtern       => EinheitRasseNummerExtern.Rasse,
                                                              KoordinatenExtern => KartenWert);
            end case;
               
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end SichtbarkeitsprüfungOhneBlockade;
   
   

   procedure SichtbarkeitsprüfungFürStadt
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
      
      SichtweiteObjekt := LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern) + 1;
      Stadtkoordinaten := LeseStadtGebaut.Koordinaten (StadtRasseNummerExtern => StadtRasseNummerExtern);
      
      YAchseSchleife:
      for YAchseSchleifenwert in -SichtweiteObjekt .. SichtweiteObjekt loop
         XAchseSchleife:
         for XAchseSchleifenwert in -SichtweiteObjekt .. SichtweiteObjekt loop
            
            KartenWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => Stadtkoordinaten,
                                                                                                      ÄnderungExtern    => (KartenKonstanten.LeerEAchseÄnderung, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                      LogikGrafikExtern => True);
            
            case
              KartenWert.XAchse
            is
               when KartenKonstanten.LeerXAchse =>
                  null;
                  
               when others =>
                  SichtbarkeitSetzenLogik.EbenenBerechnungen (RasseExtern       => StadtRasseNummerExtern.Rasse,
                                                              KoordinatenExtern => KartenWert);
            end case;
                        
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end SichtbarkeitsprüfungFürStadt;
   
end SichtbarkeitsberechnungssystemLogik;
