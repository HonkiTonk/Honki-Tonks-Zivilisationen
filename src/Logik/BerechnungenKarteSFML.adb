pragma SPARK_Mode (On);

with KartenDatentypen; use KartenDatentypen;
with KartenKonstanten;

with Sichtweiten;
with GrafikEinstellungenSFML;
with KartePositionPruefen;

package body BerechnungenKarteSFML is
   
   procedure KartenfelderAbmessungBerechnen
   is begin
      
      FensterKarte := (Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.x) * AusschnittKarte, Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.y));
      FensterAnzeige := (Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.x), Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.y));
                  
      KartenfelderAbmessung.x := FensterKarte.x / Float (2 * Sichtweiten.SichtweiteLesen (YAchseXAchseExtern => False) + 1);
      KartenfelderAbmessung.y := FensterKarte.y / Float (2 * Sichtweiten.SichtweiteLesen (YAchseXAchseExtern => True) + 1);
      
   end KartenfelderAbmessungBerechnen;
   
   
   
   procedure StadtfelderAbmessungBerechnen
   is begin
      
      StadtKarte := (Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.x) * AusschnittStadtKarte, Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.y));
      StadtAnzeige := (Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.x), Float (GrafikEinstellungenSFML.AktuelleFensterAuflösung.y));
      
      StadtfelderAbmessung.x := StadtKarte.x / Float (KartenDatentypen.Stadtfeld'Last);
      StadtfelderAbmessung.y := StadtKarte.y / Float (KartenDatentypen.Stadtfeld'Last);
      
   end StadtfelderAbmessungBerechnen;
   
   
   
   function SichtbereichKarteBerechnen
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return KartenDatentypen.SichtbereichAnfangEndeArray
   is begin
      
      YSichtAnfang := -Sichtweiten.SichtweiteLesen (YAchseXAchseExtern => True);
      YSichtEnde := Sichtweiten.SichtweiteLesen (YAchseXAchseExtern => True);
      XSichtAnfang := -Sichtweiten.SichtweiteLesen (YAchseXAchseExtern => False);
      XSichtEnde := Sichtweiten.SichtweiteLesen (YAchseXAchseExtern => False);
      
      YBereichSchleife:
      for YBereichSchleifenwert in YSichtAnfang .. YSichtEnde loop
         
         KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt,
                                                                     ÄnderungExtern    => (0, YBereichSchleifenwert, 1),
                                                                     LogikGrafikExtern => False);
         
         case
           KartenWert.YAchse
         is
            when KartenKonstanten.LeerYAchse =>
               if
                 YBereichSchleifenwert <= 0
               then
                  YSichtAnfang := YSichtAnfang + 1;
                  YSichtEnde := YSichtEnde + 1;
                  
               else
                  YSichtAnfang := YSichtAnfang - 1;
                  YSichtEnde := YSichtEnde - 1;
               end if;
                  
            when others =>
               null;
         end case;
         
      end loop YBereichSchleife;
      
      XBereichSchleife:
      for XBereichSchleifenwert in XSichtAnfang .. XSichtEnde loop
         
         KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => GlobaleVariablen.CursorImSpiel (RasseExtern).PositionAlt,
                                                                     ÄnderungExtern    => (0, 1, XBereichSchleifenwert),
                                                                     LogikGrafikExtern => False);
         
         case
           KartenWert.XAchse
         is
            when KartenKonstanten.LeerXAchse =>
               if
                 XBereichSchleifenwert <= 0
               then
                  XSichtAnfang := XSichtAnfang + 1;
                  XSichtEnde := XSichtEnde + 1;
                  
               else
                  XSichtAnfang := XSichtAnfang - 1;
                  XSichtEnde := XSichtEnde - 1;
               end if;
                  
            when others =>
               null;
         end case;
         
      end loop XBereichSchleife;
      
      return (YSichtAnfang, YSichtEnde, XSichtAnfang, XSichtEnde);
      
   end SichtbereichKarteBerechnen;

end BerechnungenKarteSFML;
