with KartenartDatentypen;
with Weltkarte;

with KIKonstanten;

with KIZufallsbewertungLogik;

-- Für eine bessere Bewertung muss ich vermutlich ein System ähnlich der Koordinatenberechnung bauen. äöü
package body KIEAchsenbewertung is

   function EAchseBewerten
     (ZielebeneExtern : in KartenDatentypen.EbeneVorhanden;
      AktuelleEbeneExtern : in KartenDatentypen.EbeneVorhanden;
      NeueEbeneExtern : in KartenDatentypen.EbeneVorhanden)
      return KIDatentypen.Achsenbewertung
   is begin
      
      if
        AktuelleEbeneExtern /= ZielebeneExtern
        and
          NeueEbeneExtern = ZielebeneExtern
      then
         return 10;
      
      elsif
        AktuelleEbeneExtern = ZielebeneExtern
        and
          NeueEbeneExtern = ZielebeneExtern
      then
         return 10;
         
      elsif
        AktuelleEbeneExtern = NeueEbeneExtern
      then
         return 5;
         
      elsif
      abs (Ebenenumrechnung (ZielebeneExtern) - Ebenenumrechnung (NeueEbeneExtern)) < abs (Ebenenumrechnung (ZielebeneExtern) - Ebenenumrechnung (AktuelleEbeneExtern))
      then
         return 7;
         
      else
         null;
      end if;
      
      case
        Weltkarte.Karteneinstellungen.Kartenform.EAchseOben
      is
         when KartenartDatentypen.Karte_E_Kein_Übergang_Enum =>
            Bewertung (True) := KIKonstanten.LeerBewertung;
            
         when KartenartDatentypen.Karte_E_Übergang_Enum =>
            Bewertung (True) := StandardübergangOben (ZielebeneExtern     => ZielebeneExtern,
                                                       AktuelleEbeneExtern => AktuelleEbeneExtern,
                                                       NeueEbeneExtern     => NeueEbeneExtern);
      end case;
      
      case
        Weltkarte.Karteneinstellungen.Kartenform.EAchseUnten
      is
         when KartenartDatentypen.Karte_E_Kein_Übergang_Enum =>
            Bewertung (False) := KIKonstanten.LeerBewertung;
            
         when KartenartDatentypen.Karte_E_Übergang_Enum =>
            Bewertung (False) := StandardübergangUnten (ZielebeneExtern     => ZielebeneExtern,
                                                         AktuelleEbeneExtern => AktuelleEbeneExtern,
                                                         NeueEbeneExtern     => NeueEbeneExtern);
      end case;
      
      return KIZufallsbewertungLogik.Bewertung (BewertungEinsExtern => Bewertung (True),
                                                BewertungZweiExtern => Bewertung (False));
   
   end EAchseBewerten;
   
   
   
   function StandardübergangOben
     (ZielebeneExtern : in KartenDatentypen.EbeneVorhanden;
      AktuelleEbeneExtern : in KartenDatentypen.EbeneVorhanden;
      NeueEbeneExtern : in KartenDatentypen.EbeneVorhanden)
      return KIDatentypen.Achsenbewertung
   is begin
      
      if
        Ebenenumrechnung (NeueEbeneExtern) > Ebenenumrechnung (AktuelleEbeneExtern)
        and
          Ebenenumrechnung (AktuelleEbeneExtern) > Ebenenumrechnung (ZielebeneExtern)
      then
         ZwischenspeicherNeu := Ebenenumrechnung (ZielebeneExtern) - Ebenenumrechnung (NeueEbeneExtern) + Ebenenumrechnung (KartenDatentypen.EbeneVorhanden'Last);
         ZwischenspeicherAktuell := Ebenenumrechnung (AktuelleEbeneExtern) - Ebenenumrechnung (ZielebeneExtern);
                  
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
      
   end StandardübergangOben;
   
   
   
   function StandardübergangUnten
     (ZielebeneExtern : in KartenDatentypen.EbeneVorhanden;
      AktuelleEbeneExtern : in KartenDatentypen.EbeneVorhanden;
      NeueEbeneExtern : in KartenDatentypen.EbeneVorhanden)
      return KIDatentypen.Achsenbewertung
   is begin
      
      if
        Ebenenumrechnung (ZielebeneExtern) > Ebenenumrechnung (AktuelleEbeneExtern)
        and
          Ebenenumrechnung (AktuelleEbeneExtern) > Ebenenumrechnung (NeueEbeneExtern)
      then
         ZwischenspeicherNeu := Ebenenumrechnung (NeueEbeneExtern) - Ebenenumrechnung (ZielebeneExtern) + Ebenenumrechnung (KartenDatentypen.EbeneVorhanden'Last);
         ZwischenspeicherAktuell := Ebenenumrechnung (ZielebeneExtern) - Ebenenumrechnung (AktuelleEbeneExtern);
         
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
      
   end StandardübergangUnten;

end KIEAchsenbewertung;
