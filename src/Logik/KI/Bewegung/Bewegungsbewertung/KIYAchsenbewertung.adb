with KartenartDatentypen;
with Weltkarte;

with LeseWeltkarteneinstellungen;

with KIKonstanten;

with KIZufallsbewertungLogik;

-- Für eine bessere Bewertung muss ich vermutlich ein System ähnlich der Koordinatenberechnung bauen. äöü
package body KIYAchsenbewertung is

   function YAchseBewerten
     (ZielpunktExtern : in KartenDatentypen.KartenfeldPositiv;
      AktuellerPunktExtern : in KartenDatentypen.KartenfeldPositiv;
      NeuerPunktExtern : in KartenDatentypen.KartenfeldPositiv)
      return KIDatentypen.Achsenbewertung
   is
      use type KartenDatentypen.Kartenfeld;
   begin
      
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
      
      case
        Weltkarte.Karteneinstellungen.Kartenform.YAchseNorden
      is
         when KartenartDatentypen.Karte_Y_Kein_Übergang_Enum =>
            Bewertung (True) := KIKonstanten.LeerBewertung;
            
         when KartenartDatentypen.Karte_Y_Übergang_Enum =>
            Bewertung (True) := StandardübergangNorden (ZielpunktExtern      => ZielpunktExtern,
                                                         AktuellerPunktExtern => AktuellerPunktExtern,
                                                         NeuerPunktExtern     => NeuerPunktExtern);
            
         when KartenartDatentypen.Karte_Y_Rückwärts_Verschobener_Übergang_Enum =>
            Bewertung (True) := KIKonstanten.LeerBewertung;
            
         when KartenartDatentypen.Karte_Y_Verschobener_Übergang_Enum =>
            Bewertung (True) := StandardübergangNorden (ZielpunktExtern      => ZielpunktExtern,
                                                         AktuellerPunktExtern => AktuellerPunktExtern,
                                                         NeuerPunktExtern     => NeuerPunktExtern);
      end case;
      
      case
        Weltkarte.Karteneinstellungen.Kartenform.YAchseSüden
      is
         when KartenartDatentypen.Karte_Y_Kein_Übergang_Enum =>
            Bewertung (False) := KIKonstanten.LeerBewertung;
            
         when KartenartDatentypen.Karte_Y_Übergang_Enum =>
            Bewertung (False) := StandardübergangSüden (ZielpunktExtern      => ZielpunktExtern,
                                                          AktuellerPunktExtern => AktuellerPunktExtern,
                                                          NeuerPunktExtern     => NeuerPunktExtern);
            
         when KartenartDatentypen.Karte_Y_Rückwärts_Verschobener_Übergang_Enum =>
            Bewertung (False) := KIKonstanten.LeerBewertung;
            
         when KartenartDatentypen.Karte_Y_Verschobener_Übergang_Enum =>
            Bewertung (False) := StandardübergangSüden (ZielpunktExtern      => ZielpunktExtern,
                                                          AktuellerPunktExtern => AktuellerPunktExtern,
                                                          NeuerPunktExtern     => NeuerPunktExtern);
      end case;
      
      return KIZufallsbewertungLogik.Bewertung (BewertungEinsExtern => Bewertung (True),
                                                BewertungZweiExtern => Bewertung (False));
      
   end YAchseBewerten;
   
   
   
   function StandardübergangNorden
     (ZielpunktExtern : in KartenDatentypen.KartenfeldPositiv;
      AktuellerPunktExtern : in KartenDatentypen.KartenfeldPositiv;
      NeuerPunktExtern : in KartenDatentypen.KartenfeldPositiv)
      return KIDatentypen.Achsenbewertung
   is
      use type KartenDatentypen.Kartenfeld;
   begin
      
      if
        NeuerPunktExtern < AktuellerPunktExtern
        and
          AktuellerPunktExtern < ZielpunktExtern
      then
         ZwischenspeicherNeu := Positive (NeuerPunktExtern) - Positive (ZielpunktExtern) + Positive (LeseWeltkarteneinstellungen.YAchse);
         ZwischenspeicherAktuell := Positive (ZielpunktExtern) - Positive (AktuellerPunktExtern);
                  
      else
         return KIKonstanten.LeerBewertung;
      end if;
      
      if
        ZwischenspeicherNeu < ZwischenspeicherAktuell
      then
         return 7;
         
      else
         return KIKonstanten.LeerBewertung;
      end if;
      
   end StandardübergangNorden;
   
   
   
   function StandardübergangSüden
     (ZielpunktExtern : in KartenDatentypen.KartenfeldPositiv;
      AktuellerPunktExtern : in KartenDatentypen.KartenfeldPositiv;
      NeuerPunktExtern : in KartenDatentypen.KartenfeldPositiv)
      return KIDatentypen.Achsenbewertung
   is
      use type KartenDatentypen.Kartenfeld;
   begin
      
      if
        ZielpunktExtern < AktuellerPunktExtern
        and
          AktuellerPunktExtern < NeuerPunktExtern
      then
         ZwischenspeicherNeu := Positive (ZielpunktExtern) - Positive (NeuerPunktExtern) + Positive (LeseWeltkarteneinstellungen.YAchse);
         ZwischenspeicherAktuell := Positive (AktuellerPunktExtern) - Positive (ZielpunktExtern);
         
      else
         return KIKonstanten.LeerBewertung;
      end if;
      
      if
        ZwischenspeicherNeu < ZwischenspeicherAktuell
      then
         return 7;
         
      else
         return KIKonstanten.LeerBewertung;
      end if;
      
   end StandardübergangSüden;

end KIYAchsenbewertung;
