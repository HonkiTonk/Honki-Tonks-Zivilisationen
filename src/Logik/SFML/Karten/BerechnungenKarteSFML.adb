pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;

with Sichtweiten;
with GrafikEinstellungenSFML;

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
   
   
   
   -- Mal eine bessere Lösung finden. äöü
   -- Die Aktuelle zeigt den schwarzen Rahmen an. äöü
   -- Die Ausgeklammerte crasht aber wenn es nur einen Übergang in der jeweiligen Achse gibt. äöü
   function SichtbereichKarteBerechnen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return KartenDatentypen.SichtbereichAnfangEndeArray
   is begin
      
      case
        RasseExtern
      is
         when RassenDatentypen.Menschen_Enum =>
            null;
            
         when others =>
            null;
      end case;
      
      YSichtAnfang := -Sichtweiten.SichtweiteLesen (YAchseXAchseExtern => True);
      YSichtEnde := Sichtweiten.SichtweiteLesen (YAchseXAchseExtern => True);
      XSichtAnfang := -Sichtweiten.SichtweiteLesen (YAchseXAchseExtern => False);
      XSichtEnde := Sichtweiten.SichtweiteLesen (YAchseXAchseExtern => False);
      
      -- YBereichSchleife:
      -- for YBereichSchleifenwert in YSichtAnfang .. YSichtEnde loop
         
      --   KartenWert := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt,
       --                                                                                       ÄnderungExtern    => (0, YBereichSchleifenwert, 1),
       --                                                                                       LogikGrafikExtern => False);
         
      --   case
      --     KartenWert.YAchse
      --   is
      --   when KartenKonstanten.LeerYAchse =>
      --      if
      --        YBereichSchleifenwert <= 0
      --      then
      --         YSichtAnfang := YSichtAnfang + 1;
      --         YSichtEnde := YSichtEnde + 1;
                  
      --      else
       --        YSichtAnfang := YSichtAnfang - 1;
       --        YSichtEnde := YSichtEnde - 1;
      --      end if;
                  
      --   when others =>
      --      null;
      --   end case;
         
    --  end loop YBereichSchleife;
      
     -- XBereichSchleife:
     -- for XBereichSchleifenwert in XSichtAnfang .. XSichtEnde loop
         
     --    KartenWert := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt,
      --                                                                                        ÄnderungExtern    => (0, 1, XBereichSchleifenwert),
      --                                                                                        LogikGrafikExtern => False);
         
       --  case
       --    KartenWert.XAchse
      --   is
       --  when KartenKonstanten.LeerXAchse =>
       --     if
       --      XBereichSchleifenwert <= 0
        --    then
        --       XSichtAnfang := XSichtAnfang + 1;
        --       XSichtEnde := XSichtEnde + 1;
                  
         --   else
        --       XSichtAnfang := XSichtAnfang - 1;
        --       XSichtEnde := XSichtEnde - 1;
         --   end if;
                  
       --  when others =>
       --     null;
       --  end case;
         
     -- end loop XBereichSchleife;
      
      return (YSichtAnfang, YSichtEnde, XSichtAnfang, XSichtEnde);
      
   end SichtbereichKarteBerechnen;

end BerechnungenKarteSFML;
