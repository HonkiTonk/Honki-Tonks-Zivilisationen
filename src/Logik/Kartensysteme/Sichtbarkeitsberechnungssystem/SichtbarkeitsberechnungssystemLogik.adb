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
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
   is
      use type KartenDatentypen.Ebene;
   begin
      
      SichtweiteObjekt := SichtbereicheErmittelnLogik.SichtweiteErmitteln (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      
      case
        SichtweiteObjekt
      is
         when KartenDatentypen.Sichtweite'First =>
            SichtbarkeitsprüfungOhneBlockade (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                               SichtweiteExtern           => SichtweiteObjekt);
            return;
            
            -- Das hier auch noch einmal überarbeiten, eventuell will ich mehr als drei Felder aufdecken? äöü
         when 3 =>
            EinheitID := LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
            
            if
              LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern).EAchse >= KartenKonstanten.OberflächeKonstante
              and
                (True = LeseEinheitenDatenbank.Passierbarkeit (SpeziesExtern        => EinheitSpeziesNummerExtern.Spezies,
                                                               IDExtern             => EinheitID,
                                                               WelcheUmgebungExtern => EinheitenDatentypen.Luft_Enum)
                 or
                   True = LeseEinheitenDatenbank.Passierbarkeit (SpeziesExtern        => EinheitSpeziesNummerExtern.Spezies,
                                                                 IDExtern             => EinheitID,
                                                                 WelcheUmgebungExtern => EinheitenDatentypen.Weltraum_Enum))
            then
               SichtbarkeitsprüfungOhneBlockade (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                  SichtweiteExtern           => SichtweiteObjekt);
               return;
               
            else
               null;
            end if;
            
         when others =>
            null;
      end case;

      QuadrantenberechnungenLogik.QuadrantenDurchlaufen (SpeziesExtern     => EinheitSpeziesNummerExtern.Spezies,
                                                         SichtweiteExtern  => SichtweiteObjekt,
                                                         KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern));
      
   end SichtbarkeitsprüfungFürEinheit;
   
   
   
   procedure SichtbarkeitsprüfungOhneBlockade
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      SichtweiteExtern : in KartenDatentypen.Sichtweite)
   is
      use type KartenDatentypen.Kartenfeld;
   begin
      
      Einheitenkoordinaten := LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      
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
                  SichtbarkeitSetzenLogik.EbenenBerechnungen (SpeziesExtern     => EinheitSpeziesNummerExtern.Spezies,
                                                              KoordinatenExtern => KartenWert);
            end case;
               
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end SichtbarkeitsprüfungOhneBlockade;
   
   

   procedure SichtbarkeitsprüfungFürStadt
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
   is
      use type KartenDatentypen.Kartenfeld;
   begin
      
      SichtweiteObjekt := LeseStadtGebaut.UmgebungGröße (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern) + 1;
      Stadtkoordinaten := LeseStadtGebaut.Koordinaten (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
      
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
                  SichtbarkeitSetzenLogik.EbenenBerechnungen (SpeziesExtern     => StadtSpeziesNummerExtern.Spezies,
                                                              KoordinatenExtern => KartenWert);
            end case;
                        
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end SichtbarkeitsprüfungFürStadt;
   
end SichtbarkeitsberechnungssystemLogik;
