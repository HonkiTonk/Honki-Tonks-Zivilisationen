with KartenDatentypen; use KartenDatentypen;
with KartenartDatentypen; use KartenartDatentypen;
with Weltkarte;

package body KIYAchsenbewertung is

   function YAchseBewerten
     (ZielpunktExtern : in KartenDatentypen.KartenfeldPositiv;
      AktuellerPunktExtern : in KartenDatentypen.KartenfeldPositiv;
      NeuerPunktExtern : in KartenDatentypen.KartenfeldPositiv)
      return KIDatentypen.Achsenbewertung
   is begin
      
      if
        AktuellerPunktExtern /= ZielpunktExtern
        and
          NeuerPunktExtern = ZielpunktExtern
      then
         return 10;
         
      elsif
        AktuellerPunktExtern = ZielpunktExtern
        and
          NeuerPunktExtern = ZielpunktExtern
      then
         return 10;
         
      elsif
        AktuellerPunktExtern = NeuerPunktExtern
      then
         return 5;
         
      elsif
      abs (ZielpunktExtern - NeuerPunktExtern) < abs (ZielpunktExtern - AktuellerPunktExtern)
      then
         return 7;
         
      else
         null;
      end if;
      
      if
        Weltkarte.Karteneinstellungen.Kartenform.YAchseNorden = KartenartDatentypen.Karte_Y_Kein_Übergang_Enum
        and
          Weltkarte.Karteneinstellungen.Kartenform.YAchseSüden = KartenartDatentypen.Karte_Y_Kein_Übergang_Enum
      then
         null;
         
      elsif
        Weltkarte.Karteneinstellungen.Kartenform.YAchseNorden = KartenartDatentypen.Karte_Y_Kein_Übergang_Enum
        and
          Weltkarte.Karteneinstellungen.Kartenform.YAchseSüden = KartenartDatentypen.Karte_Y_Übergang_Enum
      then
         null;
         
      elsif
        Weltkarte.Karteneinstellungen.Kartenform.YAchseNorden = KartenartDatentypen.Karte_Y_Übergang_Enum
        and
          Weltkarte.Karteneinstellungen.Kartenform.YAchseSüden = KartenartDatentypen.Karte_Y_Kein_Übergang_Enum
      then
         null;
         
      elsif
        Weltkarte.Karteneinstellungen.Kartenform.YAchseNorden = KartenartDatentypen.Karte_Y_Übergang_Enum
        and
          Weltkarte.Karteneinstellungen.Kartenform.YAchseSüden = KartenartDatentypen.Karte_Y_Übergang_Enum
      then
         return Standardübergang (ZielpunktExtern      => ZielpunktExtern,
                                   AktuellerPunktExtern => AktuellerPunktExtern,
                                   NeuerPunktExtern     => NeuerPunktExtern);
         
      else
         null;
      end if;
      
      return 0;
      
   end YAchseBewerten;
   
   
   
   function Standardübergang
     (ZielpunktExtern : in KartenDatentypen.KartenfeldPositiv;
      AktuellerPunktExtern : in KartenDatentypen.KartenfeldPositiv;
      NeuerPunktExtern : in KartenDatentypen.KartenfeldPositiv)
      return KIDatentypen.Achsenbewertung
   is begin
      
      if
        NeuerPunktExtern < AktuellerPunktExtern
        and
          AktuellerPunktExtern < ZielpunktExtern
      then
         ZwischenspeicherNeu := Positive (NeuerPunktExtern) - Positive (ZielpunktExtern) + Positive (Weltkarte.Karteneinstellungen.Kartengröße.YAchse);
         ZwischenspeicherAktuell := Positive (AktuellerPunktExtern) - Positive (ZielpunktExtern) + Positive (Weltkarte.Karteneinstellungen.Kartengröße.YAchse);
         
      elsif
        ZielpunktExtern < AktuellerPunktExtern
        and
          AktuellerPunktExtern < NeuerPunktExtern
      then
         ZwischenspeicherNeu := Positive (ZielpunktExtern) - Positive (NeuerPunktExtern) + Positive (Weltkarte.Karteneinstellungen.Kartengröße.YAchse);
         ZwischenspeicherAktuell := Positive (ZielpunktExtern) - Positive (AktuellerPunktExtern) + Positive (Weltkarte.Karteneinstellungen.Kartengröße.YAchse);
         
      else
         return 0;
      end if;
      
      if
        ZwischenspeicherAktuell < ZwischenspeicherNeu
      then
         return 7;
         
      else
         return 0;
      end if;
      
   end Standardübergang;

end KIYAchsenbewertung;
