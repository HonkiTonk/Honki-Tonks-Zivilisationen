with KartenKonstanten;
with GrafikRecordKonstanten;
with SystemDatentypen;

with LeseZeiger;

with SichtweitenGrafik;
with KartenkoordinatenberechnungssystemLogik;

package body UmwandlungenGrafik is

   function KoordinatenKartenposition
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return Sf.System.Vector2.sfVector2f
   is
      use type KartenRecords.KartenfeldNaturalRecord;
   begin
      
      Sichtbereich := SichtweitenGrafik.SichtbereichLesen;
      ZeigerKoordinatenAlt := LeseZeiger.KoordinatenAlt (SpeziesExtern => SpeziesExtern);
      Feldposition := GrafikRecordKonstanten.Nullposition;
      Kartenfeldfläche := SichtweitenGrafik.Kartenfeldfläche;
            
      SenkrechteSchleife:
      for SenkrechteSchleifenwert in -Sichtbereich.Senkrechte .. Sichtbereich.Senkrechte loop
         WaagerechteSchleife:
         for WaagerechteSchleifenwert in -Sichtbereich.Waagerechte .. Sichtbereich.Waagerechte loop
            
            KartenWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => ZeigerKoordinatenAlt,
                                                                                                      ÄnderungExtern    => (KartenKonstanten.LeerEbeneÄnderung, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                                                                                      TaskExtern        => SystemDatentypen.Grafik_Task_Enum);
            
            if
              KartenWert.Waagerechte = KartenKonstanten.LeerWaagerechte
            then
               null;
               
            elsif
              KartenWert = KoordinatenExtern
            then
               return Feldposition;
               
            else
               null;
            end if;
            
            Feldposition.x := Feldposition.x + Kartenfeldfläche.x;
                          
         end loop WaagerechteSchleife;
         
         Feldposition := (GrafikRecordKonstanten.Nullposition.x, Feldposition.y + Kartenfeldfläche.y);
         
      end loop SenkrechteSchleife;
      
      return GrafikRecordKonstanten.FalschePosition;
      
   end KoordinatenKartenposition;

end UmwandlungenGrafik;
