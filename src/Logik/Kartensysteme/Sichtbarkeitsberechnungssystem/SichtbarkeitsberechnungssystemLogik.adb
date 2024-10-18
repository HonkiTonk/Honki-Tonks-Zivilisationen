with KartenKonstanten;
with SystemDatentypen;
with KartenDatentypen;

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
      use type KartenDatentypen.Senkrechte;
      use type KartenDatentypen.Waagerechte;
   begin
      
      SichtweiteEinheit := SichtbereicheErmittelnLogik.SichtweiteErmitteln (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      
      if
        SichtweiteEinheit.Senkrechte = KartenDatentypen.SenkrechteSichtweite'First
        or
          SichtweiteEinheit.Waagerechte = KartenDatentypen.WaagerechteSichtweite'First
      then
         SichtbarkeitsprüfungOhneBlockade (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                            SichtweiteExtern           => SichtweiteEinheit);
         return;
            
            -- Das hier auch noch einmal überarbeiten, eventuell will ich mehr als drei Felder aufdecken? äöü
            -- Die Sichtweite auch in die EinheitenDatenbank packen'und dann hier Einheitenabhängig berechnen? äöü
            -- Eventuell mit dem Gelände als Abzug/Teiler? äöü
            -- Eventuell auch unter Berücksichtigung der nun aufgeteilten Achsen. äöü
      elsif
        SichtweiteEinheit.Senkrechte = 3
        or
          SichtweiteEinheit.Waagerechte = 3
      then
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
                                               SichtweiteExtern           => SichtweiteEinheit);
            return;
               
         else
            null;
         end if;
         
      else
         null;
      end if;

      QuadrantenberechnungenLogik.QuadrantenDurchlaufen (SpeziesExtern     => EinheitSpeziesNummerExtern.Spezies,
                                                         SichtweiteExtern  => SichtweiteEinheit,
                                                         KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern));
      
   end SichtbarkeitsprüfungFürEinheit;
   
   
   
   procedure SichtbarkeitsprüfungOhneBlockade
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      SichtweiteExtern : in KartenRecords.SichtweitePositiveRecord)
   is
      use type KartenDatentypen.Senkrechte;
      use type KartenDatentypen.Waagerechte;
   begin
      
      Einheitenkoordinaten := LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      
      YAchseSchleife:
      for YAchseSchleifenwert in -SichtweiteExtern.Senkrechte .. SichtweiteExtern.Senkrechte loop
         XAchseSchleife:
         for XAchseSchleifenwert in -SichtweiteExtern.Waagerechte .. SichtweiteExtern.Waagerechte loop
            
            KartenWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => Einheitenkoordinaten,
                                                                                                      ÄnderungExtern    => (KartenKonstanten.LeerEAchseÄnderung, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                      TaskExtern        => SystemDatentypen.Logik_Task_Enum);
            
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
      use type KartenDatentypen.Senkrechte;
      use type KartenDatentypen.Waagerechte;
   begin
      
      SichtweiteStadt := (LeseStadtGebaut.Umgebungssenkrechte (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern), LeseStadtGebaut.Umgebungswaagerechte (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern));
      SichtweiteStadt.Senkrechte := SichtweiteStadt.Senkrechte + 1;
      SichtweiteStadt.Waagerechte := SichtweiteStadt.Waagerechte + 1;
      
      Stadtkoordinaten := LeseStadtGebaut.Koordinaten (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
      
      YAchseSchleife:
      for YAchseSchleifenwert in -SichtweiteStadt.Senkrechte .. SichtweiteStadt.Senkrechte loop
         XAchseSchleife:
         for XAchseSchleifenwert in -SichtweiteStadt.Waagerechte .. SichtweiteStadt.Waagerechte loop
            
            KartenWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => Stadtkoordinaten,
                                                                                                      ÄnderungExtern    => (KartenKonstanten.LeerEAchseÄnderung, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                      TaskExtern        => SystemDatentypen.Logik_Task_Enum);
            
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
