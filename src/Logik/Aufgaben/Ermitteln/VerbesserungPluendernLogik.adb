with KartenverbesserungDatentypen;
with TextnummernKonstanten;

with LeseWeltkarte;
with SchreibeWeltkarte;
with SchreibeWichtiges;

with JaNeinLogik;

package body VerbesserungPluendernLogik is

   function VerbesserungPlündern
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      AnlegenTestenExtern : in Boolean;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is
      use type KartenverbesserungDatentypen.Karten_Verbesserung_Enum;
      use type KartenverbesserungDatentypen.Karten_Weg_Enum;
   begin
            
      if
        LeseWeltkarte.Verbesserung (KoordinatenExtern => KoordinatenExtern) = KartenverbesserungDatentypen.Leer_Verbesserung_Enum
        and
          LeseWeltkarte.Weg (KoordinatenExtern => KoordinatenExtern) = KartenverbesserungDatentypen.Leer_Weg_Enum
      then
         return False;
         
      elsif
        AnlegenTestenExtern = False
      then
         return True;
         
      else
         null;
      end if;
      
      case
        SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung
      is
         when RassenDatentypen.KI_Spieler_Enum =>
            null;
            
         when others =>
            if
              JaNeinLogik.JaNein (FrageZeileExtern => TextnummernKonstanten.FrageLandverbesserungPlündern) = True
            then
               null;
                     
            else
               return False;
            end if;
      end case;
      
      case
        LeseWeltkarte.Verbesserung (KoordinatenExtern => KoordinatenExtern)
      is
         when KartenverbesserungDatentypen.Leer_Verbesserung_Enum =>
            null;
            
         when others =>
            SchreibeWeltkarte.Verbesserung (KoordinatenExtern  => KoordinatenExtern,
                                         VerbesserungExtern => KartenverbesserungDatentypen.Leer_Verbesserung_Enum);
            SchreibeWichtiges.Geldmenge (RasseExtern         => EinheitRasseNummerExtern.Rasse,
                                         GeldZugewinnExtern  => 10,
                                         RechnenSetzenExtern => True);
      end case;
      
      case
        LeseWeltkarte.Weg (KoordinatenExtern => KoordinatenExtern)
      is
         when KartenverbesserungDatentypen.Leer_Weg_Enum =>
            null;
            
         when others =>
            SchreibeWeltkarte.Weg (KoordinatenExtern => KoordinatenExtern,
                                WegExtern         => KartenverbesserungDatentypen.Leer_Weg_Enum);
            SchreibeWichtiges.Geldmenge (RasseExtern         => EinheitRasseNummerExtern.Rasse,
                                         GeldZugewinnExtern  => 5,
                                         RechnenSetzenExtern => True);
      end case;
      
      return True;
      
   end VerbesserungPlündern;

end VerbesserungPluendernLogik;
